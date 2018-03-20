require 'httparty'

module GitHubJobs
  VERSION = '0.0.1'

  class Base
    include HTTParty
    base_uri 'jobs.github.com/positions.json'
  end

  class Request < Base

    def by_location(location)
      self.class.get("?location=#{location}")
    end

    def by_keyword(keyword)
      self.class.get("?description=#{keyword}")
    end

    def by_location_and_keyword

    end

  end
end


#######
# tests
#######
require 'minitest/autorun'

class GitHubJobsTest < Minitest::Test

  def test_version
    assert_equal '0.0.1', GitHubJobs::VERSION
  end

  def test_request_by_location
    request = GitHubJobs::Request.new
    response = request.by_location('boston')
    assert_equal 200, response.code
  end

  def test_request_by_keyword
    request = GitHubJobs::Request.new
    response = request.by_keyword('react')
    assert_equal 200, response.code
  end
end
