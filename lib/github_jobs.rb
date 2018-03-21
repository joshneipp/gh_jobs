require 'rubygems'
require 'bundler/setup'
require 'httparty'

require File.expand_path(File.dirname(__FILE__) + '/version')
require File.expand_path(File.dirname(__FILE__) + '/config')

module GitHubJobs
  class Base
    include HTTParty
    base_uri 'jobs.github.com/positions.json'
  end

  class Request < Base

    def by_location(**args)
      location = args.fetch(:location, GitHubJobs::Config::DEFAULT_LOCATION)
      self.class.get("?location=#{location}")
    end

    def by_keyword(**args)
      keyword = args.fetch(:keyword, GitHubJobs::Config::DEFAULT_LANGUAGE)
      self.class.get("?description=#{keyword}")
    end

    def by_location_and_keyword(**args)
      location = args.fetch(:location, GitHubJobs::Config::DEFAULT_LOCATION)
      keyword = args.fetch(:keyword, GitHubJobs::Config::DEFAULT_LANGUAGE)
      self.class.get("?description=#{keyword}&location=#{location}")
    end

    def by_location_and_keyword_and_experience(**args)
      location = args.fetch(:location, GitHubJobs::Config::DEFAULT_LOCATION)
      keyword = args.fetch(:keyword, GitHubJobs::Config::DEFAULT_LANGUAGE)
      experience = args.fetch(:experience, GitHubJobs::Config::DEFAULT_EXPERIENCE)
      self.class.get("?description=#{keyword}&location=#{location}&search=#{experience}")
    end
  end
end
