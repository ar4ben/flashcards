source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rubocop', require: false
gem 'pg'
gem 'simple_form'
gem 'interactor'
gem 'sorcery'
gem 'figaro'
gem 'paperclip'
gem 'aws-sdk', '< 2.0'
gem 'levenshtein', '~> 0.2.2'
gem 'whenever', require: false
gem 'http_accept_language'
gem 'rails-i18n', '~> 4.0.0'
gem 'rollbar'
gem 'newrelic_rpm'
gem 'puma'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Access an IRB console on exception pages or by using <%= console %> in views
gem 'web-console', '~> 2.0', group: :development
gem 'rails_12factor', group: :production

group :development do
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'jazz_hands'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem "letter_opener"
end
