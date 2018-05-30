ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.

# Load environment config
require "dotenv/load" if ENV["RUBY_ENV"] == "development" || ENV["RUBY_ENV"] == "test"
