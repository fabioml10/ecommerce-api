module StaticTokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    STATIC_TOKEN_AUTH = ENV['JUNO_PAYMENT_CONFIRMATION_TOKEN']
    
    before_action :authenticate!
  
    def authenticate!
      unless params[:token] == STATIC_TOKEN_AUTH
        head :unauthorized
      end
    end
  end
end
