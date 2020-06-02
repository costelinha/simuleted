class ApplicationController < ActionController::Base
  layout :resouve_layout

  protected
    def resouve_layout
      if devise_controller? && resource_class == Admin
        'admin_devise'
      else
        'application'
      end
    end
end
