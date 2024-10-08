# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.6'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'bundler-audit'
gem 'devise'
gem 'factory_bot_rails'
gem 'faker'
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'jbuilder', '~> 2.7'
gem 'jwt'
gem 'net-smtp'
gem 'pg'
gem 'puma', '~> 5.6'
gem 'rack-cors'
gem 'rails', '~> 6.1.7'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'simplecov'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
