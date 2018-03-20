require File.expand_path(File.dirname(__FILE__) + '/version')
require 'httparty'

module GitHubJobs
  class Base
    include HTTParty
    base_uri 'jobs.github.com/positions.json'
  end

  class Request < Base

    def by_location(args = {})
      location = args.fetch(:location, "ny")
      self.class.get("?location=#{location}")
    end

    def by_keyword(args = {})
      keyword = args.fetch(:keyword, "ruby")
      self.class.get("?description=#{keyword}")
    end

    def by_location_and_keyword(args = {})
      location = args.fetch(:location, "ny")
      keyword = args.fetch(:keyword, "ruby")
      self.class.get("?description=#{keyword}&location=#{location}")
    end

  end
end
