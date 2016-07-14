Rails.application.routes.draw do
  # application status
  get '/status', :to => 'application#server_status'
  # # Entry point of the application
  # root 'shows#index'
  # get '/', :to => 'shows#index'
  get '/detailed_shows', :to => 'shows#index'
  post '/reset_shows', :to => 'shows#refresh_data'
  get '/show_shows', :to => 'shows#get_shows'
end
