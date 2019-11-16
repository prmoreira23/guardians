class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  TOKEN = 'MYDUMBTOKEN'

  def verify_webhook
    mode = params['hub.mode']
    token = params['hub.verify_token'];
    challenge = params['hub.challenge'];

    if mode && token
      if mode == 'subscribe' && token == TOKEN
        Rails.logger.info('WEBHOOK_VERIFIED');
        render json: challenge, status: :ok
      else
        head :forbidden
      end
    end
  end
end
