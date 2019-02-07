require 'rails_helper'
require 'SpotifyAPI'

RSpec.describe 'Spotify API wrapper' do
  let(:spotify) { SpotifyAPI.new }
  let(:existing_artist) { Faker::Music.band }
  let(:fake_artist) { 'blink183' }

  context '#get_artist_top_track' do

    context 'when a existing artist is provided' do
      it 'successfully gets its top track' do
        top_track = spotify.get_artist_top_track(existing_artist)
        expect(top_track).to be
      end
    end

    context 'when a fake artist is provided' do
      it 'doesn\'t get anything' do
        top_track = spotify.get_artist_top_track(fake_artist)
        expect(top_track).to be_nil
      end
    end
  end

end
