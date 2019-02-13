require 'rails_helper'

RSpec.describe 'Music API', type: :request do
  # Initialize test data
  let(:existing_artist) { Faker::Music.band }
  let(:fake_artist) { 'blink183' }
  let(:good_phone) { '+56952496480' }
  let(:bad_phone) { '7480' }


  # Test suite for POST /api/v1/music/send_artist_top_track
  describe 'POST /api/v1/music/send_artist_top_track' do

    context 'when the request is valid' do

      context 'when a existing artist is provided' do

        context 'when a well-formatted phone is provided' do
          let(:params) { { artist_name: existing_artist, phone_number: good_phone } }

          before { post '/api/v1/music/send_artist_top_track', params: params }

          it 'successfully sends a SMS message' do
            expect(json).not_to be_empty
            expect(json['sent']).to be
          end

          it 'returns 200 OK HTTP status code' do
            expect(response).to have_http_status(:ok)
          end
        end


        context 'when a bad-formatted phone is provided' do
          let(:params) { { artist_name: existing_artist, phone_number: bad_phone } }

          before { post '/api/v1/music/send_artist_top_track', params: params }

          it 'doesn\'t send a SMS' do
            byebug
            expect(json).not_to be_empty
            expect(json['sent']).to be_falsey
          end

          it 'returns 200 OK HTTP status code' do
            expect(response).to have_http_status(:ok)
          end
        end
      end


      context 'when a fake artist is provided' do
        let(:params) { { artist_name: fake_artist, phone_number: good_phone } }

        before { post '/api/v1/music/send_artist_top_track', params: params }

        it 'doesn\'t send a SMS' do
          expect(json).not_to be_empty
          expect(json['sent']).to be_falsey
        end

        it 'returns 200 OK HTTP status code' do
          expect(response).to have_http_status(:ok)
        end
      end

    end


    context 'when the request is invalid' do

      context 'when some params are not provided' do
        let(:params) { { artist_name: Faker::Music.band } }
        before { post '/api/v1/music/send_artist_top_track', params: params }

        it 'returns 400 Bad Request HTTP status code' do
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns a validation failure message' do
          expect(json).not_to be_empty
          expect(json['message']).to match(/Unable to process your request: Some params not found/)
        end
      end

    end

  end

end
