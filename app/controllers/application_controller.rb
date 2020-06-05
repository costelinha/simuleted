class ApplicationController < ActionController::Base
  layout :resource_layout
  before_action :check_pagination

  protected
    def resource_layout
      devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application'
    end

    def check_pagination
      unless user_signed_in?
        params.extract!(:page)
      end
    end
end
