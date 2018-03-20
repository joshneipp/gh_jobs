require File.expand_path(File.dirname(__FILE__) + '../../lib/github_jobs')
require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class GitHubJobsTest < Minitest::Test

  def test_version
    assert_equal '0.0.1', GitHubJobs::VERSION
  end

  def test_request_by_location
    request = GitHubJobs::Request.new
    response = request.by_location(location: 'boston')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_match 'Boston', parsed_response[0]['location']
  end

  def test_request_by_keyword
    request = GitHubJobs::Request.new
    response = request.by_keyword(keyword: 'react')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /[Rr]eact/.match job['description'] }
      'all response descriptions should include "React"'
  end

  def test_request_by_location_and_keyword
    response = GitHubJobs::Request.new.by_location_and_keyword(keyword: 'react', location: 'ny')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /[Rr]eact/.match job['description'] }
    assert_equal true, parsed_response.all? { |job| /(York)|([Nn][Yy])/.match(job['location']) },
      'all response descriptions should include "York" or "NY"'
  end

  def test_request_by_location_and_keyword_and_experience
    response = GitHubJobs::Request.new.by_location_and_keyword_and_experience(keyword: 'ruby', location: 'ny', experience: '1-3')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /[Rr]uby/.match(job['description']) },
      'all response descriptions should include "Ruby"'

    assert_equal true, parsed_response.all? { |job| /York|([Nn][Yy])/.match(job['location']) },
      'all response locations should include "New York"'

    assert_equal true, parsed_response.all? { |job| /1\-3/.match(job['description']) },
      'all response descriptions should include "1-3" years of experience'
  end
end
