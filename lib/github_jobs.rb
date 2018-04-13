require 'rubygems'
# require 'bundler/setup'
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

  class Summary < Request
    def generate_for_defaults
      summary = Hash.new

      GitHubJobs::Config::DEFAULT_LOCATIONS.each do |loc|
        jobs_total = Request.new.by_location(location: loc).count
          summary[loc] = {}

          GitHubJobs::Config::DEFAULT_LANGUAGES.each do |lang|
            languages = Request.new.by_location_and_keyword(location: loc, description: lang).count || 0
            summary[loc][lang] = {}

            GitHubJobs::Config::DEFAULT_EXPERIENCE_LEVELS.each do |exp|
              exp_jobs = Request.new.by_location_and_keyword_and_experience(location: loc, description: lang, experience: exp).count || 0
              summary[loc][lang][exp + " years of experience"] = "#{exp_jobs} out of #{jobs_total} jobs"

            end
          end
      end
      return summary.to_json
    end
  end
end
