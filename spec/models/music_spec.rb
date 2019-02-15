# frozen_string_literal: true

require 'rails_helper'
require 'spotify_api'
require 'twilio_api'

RSpec.describe Music, type: :model do
  # Initialize test data
  subject { described_class.new }
  let(:existing_artist) { Faker::Music.band }
  let(:fake_artist) { 'blink183' }
  let(:good_phone) { '+56952496480' }
  let(:bad_phone) { '7480' }


  context 'when a existing artist is provided' do

    context 'when a well-formatted phone is provided' do
      it 'successfully sends a SMS message' do
        sent_sms, message, artist_data = subject.send_artist_top_track(existing_artist, good_phone)
        expect(sent_sms).to be
        expect(message).to be
        expect(artist_data).to be
      end
    end

    context 'when a bad-formatted phone is provided' do
      it 'doesn\'t send a SMS' do
        sent_sms, message, artist_data = subject.send_artist_top_track(existing_artist, bad_phone)
        expect(sent_sms).to be_falsey
      end
    end
  end


  context 'when a fake artist is provided' do

    it 'doesn\'t send a SMS' do
      sent_sms, message, artist_data = subject.send_artist_top_track(fake_artist, good_phone)
      expect(sent_sms).to be_falsey
    end
  end

end
