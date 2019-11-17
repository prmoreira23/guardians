class NotificationController < ApplicationController
  URL = "https://graph.facebook.com/v5.0/me/messages?access_token=#{Rails.application.credentials.FB_TOKEN}"

  def message_received
    body = JSON.parse(request.raw_post)

    if body["object"] == 'page'
      body["entry"].each do |entry|
        message = entry["messaging"].first

        text = message["message"]["text"]

        user = User.find_by(token: text)

        options = {}

        if user
          ec = EmergencyContact.find_by(psid: message["sender"]["id"])

          if ec
            options = get_options(message["sender"]["id"], "You're already listed as an emergency contact for #{user.email}")
          else
            EmergencyContact.create(psid: message["sender"]["id"], user: user)
            options = get_options(message["sender"]["id"], "Success! You're now an emergency contact for #{user.email}")
          end
          Rails.logger.info("RECEIVED MESSAGE");
        else
          options = get_options(message["sender"]["id"], "Invalid Token! Try again.")
        end
        response = HTTParty.post(URL, options.to_json)
      end

      render json: 'EVENT_RECEIVED', status: :ok
    else
      head :not_found
    end
  end

  def crash_report
    token = params[:token]
    user = User.find_by(token: token)
    if user
      #notify emergency_contacts
      Rails.logger.info("SENDING NOTIFICATIONS TO YOUR EMERGENCY LIST. U##{user.id}");
      head :ok
    else
      head :not_found
    end
  end


  private
  def get_options(id, message)
    {
      "messaging_type": "RESPONSE",
      "recipient": {
        "id": id
      },
      "message": {
        "text": message
      }
    }
  end
end

=begin
  message.sender      # => { 'id' => '1008372609250235' }
  # message.sent_at     # => 2016-04-22 21:30:36 +0200
  # message.text        # => 'Hello, bot!'
=end
