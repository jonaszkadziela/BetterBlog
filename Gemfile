source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'haml', '~> 5.0.4'
gem 'coffee-script-source', '1.8.0'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'autoprefixer-rails', '~> 8.2'
gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'guard', '~> 2.14', '>= 2.14.2'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'guard-cucumber', '~> 2.1', '>= 2.1.2'
end

group :test do
  gem 'capybara', '~> 3.0', '>= 3.0.1'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'warden-rspec-rails', '~> 0.2.0'
end

group :production do
  gem 'redis', '~> 4.0', '>= 4.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
