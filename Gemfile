# Gem sources
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


# Ruby version
ruby '2.5.3'


# Looking to use the Edge version? gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'

# Use RuboCop as a Ruby static code analyzer and code formatter
gem 'rubocop', require: false

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.11'

# Use Redis Rails to set up a Redis backed Cache and / or Session
gem 'redis', '~> 4.0'

# Use Sidekiq as a background job processor through Active Job
gem 'sidekiq', '~> 5.1'

# Use Rack Timeout. Read more: https://github.com/heroku/rack-timeout
gem 'rack-timeout', '~> 0.5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Bootsnap to improve startup times
gem 'bootsnap', '>= 1.1.0', require: false

# Pundit allows to build a simple, robust and scaleable authorization system
# gem "pundit"

# Use Clockwork for recurring background tasks without needing cron
# gem 'clockwork', '~> 2.0'

# Use Kaminari for pagination
# gem 'kaminari', '~> 1.0'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as the compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 4.3'

# Use Turbolinks. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Use Bootstrap SASS for Bootstrap support
gem 'bootstrap-sass', '~> 3.3'

# Use Font Awesome Rails for Font Awesome icons
gem 'font-awesome-rails', '~> 4.7'




group :development, :test do
  # Call 'byebug' anywhere in your code to drop into a debugger console
  gem 'byebug', platform: [:mri, :mingw, :x64_mingw]

  # RSpec tests support
  gem 'rspec-rails', '~> 3.8'
  gem 'faker'
  gem 'ffaker'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15', '< 4.0'
  # gem 'selenium-webdriver'

  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'

  # Test Coverage report
  gem 'simplecov'

  # Useful for RSpec tests
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'

  # Webmock for stubbing and setting expectations on HTTP requests
  gem 'webmock'
end

group :development do
  # Enable a debug toolbar to help profile your application
  gem 'rack-mini-profiler', '~> 1.0'

  # Access an IRB console on exception pages or by using <%= console %>
  gem 'web-console', '~> 3.3.0'

  # Get notified of file changes. Read more: https://github.com/guard/listen
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Preview mail in the browser instead of sending
  # gem "letter_opener"
  # gem "letter_opener_web"

  # Development tools
  gem "better_errors"
  gem "binding_of_caller"
  gem 'bullet'
end




# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Twilio REST API Ruby gem
gem 'twilio-ruby'

# Spotify Web API Ruby wrapper
gem 'rspotify'
