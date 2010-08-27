require 'compass'
require 'compass/app_integration/rails'
Compass::AppIntegration::Rails.initialize!

if RAILS_ENV == 'development'
  Sass::Plugin.options[:always_update] = true
end
