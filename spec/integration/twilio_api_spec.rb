require 'rails_helper'
require 'TwilioAPI'

describe "Twilio API wrapper" do
  let(:twilio) { TwilioAPI.new }
  let(:good_phone) { '+56952496480' }
  let(:bad_phone) { '7480' }
  let(:body) { 'test sms'}

  context "#send_sms" do

    context 'when a well-formatted phone is specified' do
      it "successfully sends a message" do
        sent = twilio.send_sms(body, good_phone)
        expect(sent).to be
      end
    end

    context 'when a bad-formatted phone is specified' do
      it "doesn't send a message" do
        sent = twilio.send_sms(body, bad_phone)
        expect(sent).to be_falsey
      end
    end
  end

end