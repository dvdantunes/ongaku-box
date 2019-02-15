# frozen_string_literal: true
#
require 'rails_helper'
require 'twilio_api'

RSpec.describe TwilioAPI do
  # Initialize test data
  subject { described_class.new }
  let(:good_phone) { '+56952496480' }
  let(:bad_phone) { '7480' }
  let(:body) { 'test sms' }


  context '#send_sms' do

    context 'when a well-formatted phone is provided' do
      it 'successfully sends a SMS' do
        sent = subject.send_sms(body, good_phone)
        expect(sent).to be
      end
    end

    context 'when a bad-formatted phone is provided' do
      it 'doesn\'t send a SMS' do
        sent = subject.send_sms(body, bad_phone)
        expect(sent).to be_falsey
      end
    end
  end

end
