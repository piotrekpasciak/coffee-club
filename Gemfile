source 'https://rubygems.org'

ruby '2.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7'
gem 'pg', '~> 0.18.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

#Gems added for project
gem 'devise', '~> 3.5.1'
gem "devise_ldap_authenticatable", '~> 0.8.5'
gem 'bower-rails', '~> 0.9.2'
gem 'pry-rails', '~> 0.3.4'
gem 'whenever', '~> 0.9.4', require: false

#Gems required for mailer
gem 'dotenv-rails', '~> 2.0.2'
gem "font-awesome-rails"

#Gems added for angularjs
gem 'angularjs-rails-resource', '~> 2.0.0'
gem 'angular-ui-bootstrap-rails', '~> 0.12.1'
gem 'active_model_serializers', '~> 0.8.3'
gem 'angular_rails_csrf', '~> 1.0.4'
gem 'angular-rails-templates', '~> 0.2.0'

group :development do
  gem 'thin', '~> 1.6.3'
  gem 'annotate', '~> 2.6.10'
  gem 'bullet', '~> 4.14.7'
  gem 'quiet_assets', '~> 1.1.0'
  gem 'better_errors', '~> 2.1.1'
  gem 'rubocop', '~> 0.32.1'
  gem 'magic_encoding', '~> 0.0.2'

  gem "letter_opener"
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'byebug'
  gem 'spring'

  #Gems added for development and test environment
  gem 'rspec-rails', '3.3.2'
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :test do
  #Gems added for test environment
  gem 'faker', '~> 1.4.3'
  gem 'capybara', '~> 2.4.4'
  gem 'launchy', '~> 2.4.3'
  gem 'database_cleaner'
  gem 'capybara-screenshot', '~>1.0.10'
  gem "capybara-webkit"
end