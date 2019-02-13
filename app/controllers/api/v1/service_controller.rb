#
# Service API controller
#
class API::V1::ServiceController < ActionController::API
  include ResponseHelper

  before_action :allowed_params


  # POST /send_artist_top_track
  #
  # Performs a request to Spotify to search for artist's top track
  # and sends a SMS to
  #
  # @return [String]    json response
  def send_artist_top_track
    music = Music.new
    sent = music.send_artist_top_track(params[:artist_name], params[:phone_number])

    json_response({
      sent: sent
    })
  end


  private


  # Whitelist allowed params
  #
  # @return [void]
  def allowed_params
    if params[:artist_name].blank? || params[:phone_number].blank?
      return json_bad_request_response('Some params not found')
    end

    params.permit(:artist_name, :phone_number)
  end
end
