class Show < ActiveRecord::Base

  def self.reset_shows
    raw_shows = RestClient.get('https://data.sfgov.org/resource/wwmu-gmzc.json')
    shows_json = JSON.parse raw_shows
    shows_json = shows_json.take(10)
    filtered_data = shows_json.map{ |x| [x['title'], x['locations'], x['director']] }
    locations = shows_json.map{ |x| x['locations'] }.uniq
    point_dict = get_location_coordinates(locations.uniq)
    Show.transaction do 
      Show.delete_all
      filtered_data.each do |data|
        Show.create(:title => data[0],
                    :locations => data[1],
                    :director => data[2],
                    :latitude => point_dict[data[1]][:lat],
                    :longitude => point_dict[data[1]][:long])
      end
    end
  end

  def self.get_location_coordinates(locations)
    coordinates = {}
    locations.each_with_index do |location, ind|
      coords = Geocoder::coordinates(location)
      puts ind
      if coords
        coordinates[location] = { :lat => coords[0], :long => coords[1] }
      else
        coordinates[location] = { :lat => nil, :long => nil }
      end
      sleep 0.5
    end
    return coordinates
  end

end
