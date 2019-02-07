require 'twilio-ruby'

#
# Twilio API wrapper
#
class TwilioAPI

  ACCOUNT_SID = 'ACbbe2dc3ba80ab057cd8001d6246cb6fd'
  AUTH_TOKEN  = 'c1c90f221e5b70e9e993de0e752e091e'
  TWILIO_FROM_NUMBER = '+14436817535'


  # Initialization and authentication
  def initialize
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end


  # Send a SMS message to the provided phone number
  #
  # @return [Boolean]    If message was sent or not
  def send_sms(body, to_number)

    begin
      message = @client.messages.create({
        :from => TWILIO_FROM_NUMBER,
        :to   => to_number,
        :body => body
      })

    rescue Twilio::REST::RestError => e
      return false
    end

    is_sent message
  end


  # Return the list of SMS already sent
  #
  # @return [Array]
  def list_sms
    @client.api.account.messages.list
  end



  private


  # Determine if a message was sent or not
  #
  # @return [Boolean]
  def is_sent(message)
    message.sid.present? &&
      (message.status == 'delivered' ||
        message.error_code.zero?)
  end

end
