Rails.application.routes.draw do
  root 'home#index'

  # Default resources
  get 'home/index'

  # API resources
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      post '/service/send_artist_top_track'
      post '/service/echo'
    end
  end
end
