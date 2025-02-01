require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  config.filter_sensitive_data("<GITHUB_PERSONAL_TOKEN>") { ENV["GITHUB_PERSONAL_TOKEN"] }
  config.ignore_localhost = true
  config.ignore_hosts "chromedriver.storage.googleapis.com"
end
