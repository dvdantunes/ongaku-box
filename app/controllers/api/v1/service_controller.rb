# frozen_string_literal: true

#
# Service API controller
#
class API::V1::ServiceController < ActionController::API
  include ResponseHelper

  before_action :allowed_params, only: [:send_artist_top_track]


  # POST /send_artist_top_track
  #
  # Performs a request to Spotify to search for artist's top track
  # and sends a SMS to
  #
  # @return [String]    json response
  def send_artist_top_track
    music = Music.new
    sent_sms, message, artist_data = music.send_artist_top_track(params.dig(:artist_name), params.dig(:phone_number))

    json_response({
      sent_sms: sent_sms,
      message: message,
      artist_data: artist_data
    })
  end


  # POST /echo
  #
  # Echoes the sent params
  #
  # @return [String]    json response
  def echo
    json_response({
      echo: params
    })
  end


  private


  # Whitelist allowed params
  #
  # @return [void]
  def allowed_params
    return json_bad_request_response('Some params not found') unless params.dig(:artist_name).present? && params.dig(:phone_number).present?

    params.permit(:artist_name, :phone_number)
  end
end
