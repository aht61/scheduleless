source "https://rubygems.org"

gem "rails", "~> 5.0.1"
gem "bcrypt", "~> 3.1.7"
gem "bootstrap", "~> 4.0.0.alpha6"
gem "bourbon"
gem "chewy"
gem "country_select"
gem "devise"
gem "devise_invitable"
gem "doorkeeper"
gem "jquery-rails"
gem "pg"
gem "puma", "~> 3.0"
gem "pundit"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"


# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 3.0"
# Use ActiveModel has_secure_password

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development
source "https://rails-assets.org" do
  gem "rails-assets-tether"
  gem "rails-assets-typeahead.js"
end

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "rspec-rails", "~> 3.5"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "web-console", ">= 3.3.0"
end

ruby "2.3.1"
