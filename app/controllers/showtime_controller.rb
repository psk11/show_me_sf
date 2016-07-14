class ShowtimeController < ApplicationController
  def index
    file = File.open("#{Rails.root}/tmp/data.json", "r")
    data = file.read
    puts data.class
    @showtime = JSON.parse data
  end

  def show
    
  end
end
