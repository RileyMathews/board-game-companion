source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "cancancan"
gem "devise"
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "pg", "~> 1.5" # Use postgresql as the database for Active Record
gem "propshaft" # The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "pry"
gem "puma", "~> 6.3" # Use the Puma web server [https://github.com/puma/puma]
gem "rails", "~> 7.0.4", ">= 7.0.4.3" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "redis", "~> 5.0" # Use Redis for Action Cable
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "tailwindcss-rails" # Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "turbo-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

group :development, :test do
  gem "capybara"
  gem "debug", platforms: %i(mri mingw x64_mingw) # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "selenium-webdriver"
end

group :development do
  gem "hotwire-livereload"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers"
  gem "solargraph"
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
end

gem "dockerfile-rails", ">= 1.2", group: :development
