source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


gem 'activeadmin'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'haml-rails'
gem 'jbuilder', '~> 2.7'
gem 'kaminari', '~> 1.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search', '~> 2.2'
gem 'puma', '~> 4.3.12'
gem 'rails', '~> 6.1.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.4.3'
gem 'pagy', '~> 3.7.4'
gem 'shrine', '~> 3.3.0'
gem 'pundit', '~> 2.1.0'
gem 'fast_jsonapi'
gem 'rack-cors'
gem 'bootstrap-datepicker-rails'
gem 'chart-js-rails'
gem 'razorpay'
gem 'city-state'
gem 'activemerchant'
gem 'actionpack', '>= 6.0.3.1'
gem 'stripe'
gem 'countries'
gem 'money', '~> 6.9'
gem 'jmespath', '>= 1.6.1' # fix security vulnerability
gem 'rubocop', '~> 1.32', require: false 

# gem 'ros-apartment', require: 'apartment'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'database_cleaner'
  gem 'simplecov'
  #gem 'codecov', require: false
end

group :production do
  gem 'aws-sdk-s3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
