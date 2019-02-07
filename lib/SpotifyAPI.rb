require 'rspotify'

#
# Spotify API wrapper
#
class SpotifyAPI

  CLIENT_ID     = '5cae77f4d2ed4693bc8516e296a73986'
  CLIENT_SECRET = '4b0fdfd6e09b4c4d999a0f1bd3fc35e8'


  # Initialization and authentication
  def initialize
    RSpotify::authenticate(CLIENT_ID, CLIENT_SECRET)
  end


  # Get and artist top track
  #
  # Perform a search request by provided artis name
  #
  # @param [String] artist_name   Artist name
  # @param [Symbol] country       [Optional] In which country to find top tracks
  #
  # @return [String|nil]          Top track found or 'nil' if it didn't found anything
  def get_artist_top_track(artist_name, country = :US)
    artist = RSpotify::Artist.search(artist_name).first

    return nil unless artist.present?
    return nil unless artist.top_tracks(country).first.present?

    artist.top_tracks(country).first.name
  end

end
