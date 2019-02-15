require 'rspotify'
require 'twilio-ruby'

RSpotify.authenticate("787fe734ba184da08b4c78ff6504c965", "79051fe89b2a479bbff0f494300b3e9b")

artist = RSpotify::Artist.search("AC/DC").first
track = artist.top_tracks(:US).first

body = "#{artist.name}'s top track: #{track.name}"
puts "body #{body}"

@client = Twilio::REST::Client.new 'ACbb8840b48cc93d4b05e987d82f7a281a', '2f76fe031153c1251a93bcafa64a4980'

@client.accounts.messages.create({
  :from => '+18574454093', :to =>'+56952496480',
  :body => body
})

puts "Texted: #{body}"
