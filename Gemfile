# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'pg', '>= 0.18'
gem 'puma', '~> 3.12'
gem 'rails', '5.2.3'
gem 'sass-rails', '~> 5.0'

gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'rails-i18n'

gem 'sidekiq'
gem 'sidekiq-failures'

gem 'bootstrap', '~> 4.3.1'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-rails'
gem 'friendly_id'
gem 'haml'
gem 'haml-rails', git: 'https://github.com/indirect/haml-rails.git'
gem 'jenkins_api_client'
gem 'jquery-rails'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate'
  gem 'awesome_print'
  gem 'bullet'
  gem 'rails-erd'

  gem 'brakeman', require: false
  gem 'overcommit'
  gem 'rubocop', require: false

  gem 'guard'
  gem 'guard-bundler' # , require: false
  gem 'guard-livereload' # , require: false
  gem 'rack-livereload'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails_layout'
  gem 'web-console', '>= 3.3.0'
end
