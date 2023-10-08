ActsAsTenant.configure do |config|
  config.require_tenant = false # true
end

Rails.application.configure do
  unless Rails.env.production?
    # Re ask on reload!
    ActiveSupport::Reloader.to_complete do
      if defined?(Rails::Console)
        while ActsAsTenant.current_tenant.nil?
          ConsoleExtension::ConsoleRunner.new.switch_company
        end
      end
    end
  end
end