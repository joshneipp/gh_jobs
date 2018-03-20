module GitHubJobs
  VERSION = '0.0.1'

  class Base
  end

  class Request < Base

    def by_location

    end

    def by_keyword

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
end
