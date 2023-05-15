require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinalProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.generators do |g|
      g.test_framework nil
      g.factory_bot false
      g.scaffold_stylesheet false
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    config.action_controller.default_protect_from_forgery = false
    config.active_record.belongs_to_required_by_default = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    Rails.application.config.middleware.insert_after(
      ActionDispatch::Static,
      ActionDispatch::Static,
      Rails.root.join("docs").to_s,
      index: config.public_file_server.index_name,
      headers: config.public_file_server.headers || {},
    )
    config.before_configuration do
      ENV["OPENAI_TOKEN"] = ""
      puts "OPENAI_TOKEN = #{ENV["OPENAI_TOKEN"]}"
      #KeyError - key not found: "OPENAI_TOKEN":
      #app/controllers/messages_controller.rb:23:in `create'
      #Started POST "/__better_errors/525694dfdb775a99/variables" for 98.206.51.40 at 2023-05-13 17:00:46 +0000
      
=begin this is what I see on the terminal
  User Load (0.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? ORDER BY "users"."id" ASC LIMIT ?  [["id", 2], ["LIMIT", 1]]
  ↳ app/controllers/application_controller.rb:10:in `load_current_user'
   (0.1ms)  begin transaction
  ↳ app/controllers/messages_controller.rb:18:in `create'
  User Load (0.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
  ↳ app/controllers/messages_controller.rb:18:in `create'
  Message Create (0.9ms)  INSERT INTO "messages" ("content", "role", "user_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["content", "What is an adjective?"], ["role", "user"], ["user_id", 2], ["created_at", "2023-05-13 17:00:45.804693"], ["updated_at", "2023-05-13 17:00:45.804693"]]
  ↳ app/controllers/messages_controller.rb:18:in `create'
   (33.5ms)  commit transaction
  ↳ app/controllers/messages_controller.rb:18:in `create'
Completed 500 Internal Server Error in 49ms (ActiveRecord: 34.7ms | Allocations: 7791)
=end
    end
  end

end
