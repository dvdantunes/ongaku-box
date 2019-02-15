# frozen_string_literal: true

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


  # Get an artist data
  #
  # Perform a search request by provided artist name
  #
  # @param [String] artist_name   Artist name
  # @param [Symbol] country       [Optional] In which country to find top tracks
  #
  # @return [String|nil]          Found artist data or '{}' if it didn't found anything
  def get_artist_data(artist_name, country = :US)
    artist = RSpotify::Artist.search(artist_name).first
    return {} unless artist.present?

    top_track = artist.top_tracks(country).first
    return {} unless top_track.present?

    {
      name: artist.name,
      image: artist.images.dig(2, 'url'),
      href: artist.external_urls['spotify'],
      top_track: {
        name: top_track.name,
        href: top_track.external_urls['spotify'],
        preview_url: top_track.preview_url
      }
    }
  end

end
