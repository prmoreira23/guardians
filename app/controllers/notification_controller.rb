class NotificationController < ApplicationController
  def message_received
    Rails.logger.info("RECEIVED MESSAGE");
  end
end
