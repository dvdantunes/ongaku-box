# frozen_string_literal: true

require 'spotify_api'
require 'twilio_api'

#
# Music tableless model
#
class Music
  include ActiveModel::Model

  # Sends a SMS to provided number with the top track of
  # provided artist
  #
  # @param [String] artist_name     Artist name
  # @param [String] phone_number    Phone number in international format (eg: +14436817535)
  #
  # @return [Array]                 Result with SMS delivery status, message and found artist data
  def send_artist_top_track(artist_name, phone_number)
    artist_data = {}
    sent_sms = false

    # Perform a search of artist's top track
    begin
      spotify = SpotifyAPI.new
      artist_data = spotify.get_artist_data(artist_name)

    rescue Exception => e
      Rails.logger.error 'Spotify error: cannot connect or use API'
      Rails.logger.error e
    end

    # Abort sending if nothing found
    return [false, I18n.t(:no_top_track), {}] unless artist_data.dig(:top_track, :name).present?

    # Send a SMS to the provided number
    begin
      twilio = TwilioAPI.new

      body = "#{artist_data.dig(:name)} top track is: #{artist_data.dig(:top_track, :name)}"
      sent_sms = twilio.send_sms(body, phone_number)

    rescue Exception => e
      Rails.logger.error 'Twilio error: cannot connect or use API'
      Rails.logger.error e
    end

    # Rails.logger.info "sent_sms?: #{sent_sms}"
    message = sent_sms ? I18n.t(:success_message) : I18n.t(:send_sms_error, scope: [:sections, :home])
    [sent_sms, message, artist_data]
  end
end
