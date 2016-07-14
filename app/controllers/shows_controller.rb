class ShowsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    file = File.open("#{Rails.root}/tmp/data.json", "r")
    data = file.read
    @json_data = JSON.parse data
  end

  def get_shows
    if params[:field] and params[:query]
      condition = '#{params[:field]} REGEXP "#{params[:query]}"'
      available_shows = Show.where(condition)
    else
      available_shows = Show.all
    end
    shows_flattened = available_shows.collect{ |show|
      {
        'locations' => show.locations,
        'latitude' => show.latitude,
        'longitude' => show.longitude,
        'title' => show.title
      }
    }
    render :json => {
      :payload => shows_flattened,
      :staus => "OK"
    }
  end

  def get_autocomplete_data
    
  end

  def refresh_data
    Show.reset_shows
    data = {payload: {service: 'SF Shows'}, meta: {message: 'Data Refreshed Successfully!!'}}
    render json: data, status: :ok
  end
end
