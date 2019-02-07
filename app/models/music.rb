require 'SpotifyAPI'
require 'TwilioAPI'

#
# Music model
#
class Music
  include ActiveModel::Model

  # Sends a SMS to provided number with the top track of
  # provided artist
  #
  # @param [String] artist_name     Artist name
  # @param [String] phone_number    Phone number in international format (eg: +14436817535)
  #
  # @return [Boolean]     True if SMS message was sent
  def send_artist_top_track(artist_name, phone_number)
    top_track = nil
    sent_message = nil

    # Perform a search of artist's top track
    begin
      spotify = SpotifyAPI.new
      top_track = spotify.get_artist_top_track(artist_name)

    rescue Exception => e
      Rails.logger.error 'Spotify error: cannot connect or use API'
      Rails.logger.error e
    end

    # Abort sending if nothing found
    return false unless top_track.present?

    # Send a SMS to the provided number
    begin
      twilio = TwilioAPI.new

      body = "#{artist_name} top track is: #{top_track}"
      sent_message = twilio.send_sms(body, phone_number)

    rescue Exception => e
      Rails.logger.error 'Twilio error: cannot connect or use API'
      Rails.logger.error e
    end

    Rails.logger.info "sent_message?: #{sent_message}"
    sent_message
  end
end
