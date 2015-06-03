module BetterHelpers
  class Railtie < Rails::Railtie

    initializer "better_helpers.set_configs" do |app|
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, BetterHelpers::Railties::Filter)
      end
    end

  end
end
