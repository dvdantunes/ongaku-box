Rails.application.routes.draw do
  root 'home#index'

  # Default resources
  get 'home/index'

  # API resources
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      post '/music/send_artist_top_track'
    end
  end
end
