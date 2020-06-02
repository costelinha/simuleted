class ApplicationController < ActionController::Base
  layout :resource_layout

  protected
    def resource_layout
      devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application'
    end
end
