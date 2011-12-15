class ApplicationController < ActionController::Base
  protect_from_forgery

  if Rails.env.staging?
    before_filter :authenticate_staging
    
    def authenticate_staging
      authenticate_or_request_with_http_basic do |username, password|
        username == 'oscar' && password == 'peterson'
      end
    end
  end
  
  if Rails.env.production?
    before_filter :force_landing_page
    
    def force_landing_page
      unless request.path == "/"
        redirect_to "/"
        return false
      end
    end
  end


  protected

  def path_to_searchable(searchable)
    path_to_model(searchable.target)
  end

  def path_to_model(model)
    if model.is_a?(Mode)
      [(model.respond_to?(:key) ? model.key : nil), model.scale, model].compact
    else
      [(model.respond_to?(:key) ? model.key : nil), model].compact
    end
  end

  helper_method :path_to_searchable
  helper_method :path_to_model
  
end
