#
# Home controller
#
class HomeController < ApplicationController

  # Displays a form to allow users to search for
  # an artist top track and request to send it to her/his phone
  #
  # @return [void]
  def index
    @props = {
      artist: 'Muse'
    }
  end
end
