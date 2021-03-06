class ApplicationController < ActionController::Base
    before_action :basic_auth
    before_action :basic_auth, if: :production?
    
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday,])
    end
  
    private
  
    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.application.credentials[:basic_auth][:user] &&
        password == Rails.application.credentials[:basic_auth][:pass]
      end
    end
  # 以下を追記
    def production?
      Rails.env.production?
    end
  

end