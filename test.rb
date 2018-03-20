require File.expand_path(File.dirname(__FILE__) + '/github_jobs')

require 'minitest/autorun'

class GitHubJobsTest < Minitest::Test

  def test_version
    assert_equal '0.0.1', GitHubJobs::VERSION
  end

  def test_request_by_location
    request = GitHubJobs::Request.new
    response = request.by_location('boston')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_match 'Boston', parsed_response[0]['location']
  end

  def test_request_by_keyword
    request = GitHubJobs::Request.new
    response = request.by_keyword('react')
    assert_equal 200, response.code

    parsed_response = JSON.parse(response.body)
    assert_equal true, parsed_response.all? { |job| /[Rr]eact/.match job['description'] }
  end
end
