source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'haml'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'autoprefixer-rails'
gem 'devise'
gem 'will_paginate'
gem 'redcarpet'
gem 'pygments.rb'
gem 'truncate_html'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'ragnarson-stylecheck'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :test do
  gem 'capybara', '~> 3.0', '>= 3.0.1'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end

group :production do
  gem 'redis', '~> 4.0', '>= 4.0.1'
end
