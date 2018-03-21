require 'minitest/autorun'
require 'minitest/pride'
require 'webmock/minitest'

module TestHelper

  TEST_ROOT = File.dirname(__FILE__)

  def stub_request_for(query)
    stub_request(:get, GitHubJobs::Config::BASE_URL + query)
      .to_return(status: 200, body: file_for(query))
  end

  def file_for(query)
    File.open("#{TEST_ROOT}/fixtures/#{query}.json")
  end

end
