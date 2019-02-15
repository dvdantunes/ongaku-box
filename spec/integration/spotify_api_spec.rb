# frozen_string_literal: true

require 'rails_helper'
require 'spotify_api'

RSpec.describe SpotifyAPI do
  # Initialize test data
  subject { described_class.new }
  let(:existing_artist) { Faker::Music.band }
  let(:fake_artist) { 'blink183' }


  context '#get_artist_data' do

    context 'when a existing artist is provided' do
      it 'successfully gets its data' do
        artist_data = subject.get_artist_data(existing_artist)
        expect(artist_data).to be
      end
    end

    context 'when a fake artist is provided' do
      it 'doesn\'t get anything' do
        artist_data = subject.get_artist_data(fake_artist)
        expect(artist_data).to be_empty
      end
    end
  end

end
