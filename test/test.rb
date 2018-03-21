require File.expand_path(File.dirname(__FILE__) + '../../../lib/github_jobs')
require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class GitHubJobsTest < Minitest::Test
  include TestHelper

  def test_version
    assert_equal '0.0.1', GitHubJobs::VERSION
  end

  def test_request_by_location
    stub_request_for('location=ny')
    request = GitHubJobs::Request.new
    response = request.by_location(location: 'ny')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_match 'York', parsed_response[0]['location']
  end

  def test_request_by_keyword
    stub_request_for('description=react')
    request = GitHubJobs::Request.new
    response = request.by_keyword(keyword: 'react')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /[Rr]eact/.match job['description'] }
      'all response descriptions should include "React"'
  end

  def test_request_by_location_and_keyword
    stub_request_for('description=react&location=ny')
    response = GitHubJobs::Request.new.by_location_and_keyword(keyword: 'react', location: 'ny')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /[Rr]eact/.match job['description'] }
    assert_equal true, parsed_response.all? { |job| /(York)|([Nn][Yy])/.match(job['location']) },
      'all response descriptions should include "York" or "NY"'
  end

  def test_request_by_location_and_keyword_and_experience
    stub_request_for('description=react&location=ny&search=1-3')
    response = GitHubJobs::Request.new.by_location_and_keyword_and_experience(keyword: 'react', location: 'ny', experience: '1-3')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /React/.match(job['description']) },
      'all response descriptions should include "React"'

    assert_equal true, parsed_response.all? { |job| /York|([Nn][Yy])/.match(job['location']) },
      'all response locations should include "New York"'

    assert_equal true, parsed_response.all? { |job| /1\-3/.match(job['description']) },
      'all response descriptions should include "1-3" years of experience'
  end
end
