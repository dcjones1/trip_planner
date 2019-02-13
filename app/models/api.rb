require_relative 'api_key.rb'
require 'net/http'
require 'json'
require 'amadeus'
require 'awesome_print'
require 'byebug'
require 'pry'

class Api

  def amadeus_call(flight_hash)
    origin = flight_hash["origin"]
    destination = flight_hash["destination"]
    departure_date = flight_hash["departure_date"]
    travel_class = flight_hash["travel_class"]
    nonstop = flight_hash["nonstop"]

    amadeus = Amadeus::Client.new(client_id: API_KEY, client_secret: API_SECRET)
    response = amadeus.shopping.flight_offers.get(origin: origin, destination: destination, departureDate: departure_date, nonStop: nonstop, travelClass: travel_class, max: 10)

    hash = response.result
    hash["data"].map do |hash|
      flight = FlightOption.new(hash)
      if hash["offerItems"][0]["services"][0]["segments"][0]["flightSegment"]["arrival"]["iataCode"] == destination.upcase
        flight.nonstop = "Yes"
      else
        flight.nonstop = "No"
      end
      flight
    end
  end

  def maps_call(hash)
    origin = hash[:origin]
    # "1440+G+Street+NW+Washington+DC"
    destination = hash[:destination]
    # "Ronald Reagan National Airport"
    mode = hash[:mode]

    # Airports within 200 miles of Washington DC:

     url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=#{mode}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
  end

  def get_distance_hash(address)
    airports = ["Ronald Reagan Washington National Airport",
      "Washington Dulles International Airport",
      "Baltimore/Washington International Thurgood Marshal Airport",
      "Richmond International Airport","Philadelphia International Airport",
      "Newport News Williamsburg International Airport","Norfolk International Airport",
      "Roanoke Regional Woodrum Field", "Newark Liberty International Airport"]

    hash = {}
    hash = Hash[airports.map do |airport|
      origin = address
      destination = airport
      mode = Api.new
      hash = mode.maps_call({origin: origin, destination: destination, mode: "driving"})
       hash["routes"][0]["legs"][0]["distance"]["text"].split(" ")[0].to_f
    end.zip(airports)]
    hash
  end

  def find_airports_within_radius(radius: origin_radius, hash: a_hash)
    radius = radius.to_f
    airport_options = []
    hash.each do |distance, airport|
      if distance < radius
        airport_options << {distance => airport}
      end
    end
    airport_options
  end

  # origin = "1440+G+Street+NW+Washington+DC"
  # destination = "Ronald Reagan National Airport"

  def get_transit_directions_hash(origin, destination)
    mode = Api.new
    mode.maps_call(origin, destination, "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=transit&transit_mode=subway|bus")
  end
  def get_rail_directions_hash(origin, destination)
    mode = Api.new
    mode.maps_call(origin, destination,"https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=transit&transit_mode=rail")
  end

  # def get_driving_directions(origin, destination)
  # end

  def get_directions_array(hash)
    # hash = {"geocoded_wayp  oints"=>[{"geocoder_status"=>"OK", "place_id"=>"ChIJWX1T0pe3t4kRunc5sZ_8zr0", "types"=>["street_address"]}, {"geocoder_status"=>"OK", "place_id"=>"ChIJleAvQDG3t4kRrWsHbQGvaEE", "types"=>["airport", "establishment", "point_of_interest"]}], "routes"=>[{"bounds"=>{"northeast"=>{"lat"=>38.901366, "lng"=>-77.0279474}, "southwest"=>{"lat"=>38.8494691, "lng"=>-77.07195399999999}}, "copyrights"=>"Map data ©2019 Google", "legs"=>[{"arrival_time"=>{"text"=>"10:13pm", "time_zone"=>"America/New_York", "value"=>1549941198}, "departure_time"=>{"text"=>"9:45pm", "time_zone"=>"America/New_York", "value"=>1549939540}, "distance"=>{"text"=>"6.6 mi", "value"=>10613}, "duration"=>{"text"=>"28 mins", "value"=>1658}, "end_address"=>"Ronald Reagan Washington National Airport (DCA), Arlington, VA 22202, USA", "end_location"=>{"lat"=>38.8494691, "lng"=>-77.0414382}, "start_address"=>"1440 G St NW, Washington, DC 20005, USA", "start_location"=>{"lat"=>38.8983286, "lng"=>-77.03287949999999}, "steps"=>[{"distance"=>{"text"=>"0.2 mi", "value"=>349}, "duration"=>{"text"=>"4 mins", "value"=>260}, "end_location"=>{"lat"=>38.8976506, "lng"=>-77.0297095}, "html_instructions"=>"Walk to Metro Center Station", "polyline"=>{"points"=>"qillFnnduM?oD@i@@}D?}C?eApA@F?h@?"}, "start_location"=>{"lat"=>38.8983286, "lng"=>-77.03287949999999}, "steps"=>[{"distance"=>{"text"=>"0.2 mi", "value"=>275}, "duration"=>{"text"=>"3 mins", "value"=>205}, "end_location"=>{"lat"=>38.8983127, "lng"=>-77.0297022}, "html_instructions"=>"Head <b>east</b> on <b>G St NW</b> toward <b>14th St NW</b>", "polyline"=>{"points"=>"qillFnnduM?oD@i@@}D?}C?eA"}, "start_location"=>{"lat"=>38.8983286, "lng"=>-77.03287949999999}, "travel_mode"=>"WALKING"}, {"distance"=>{"text"=>"243 ft", "value"=>74}, "duration"=>{"text"=>"1 min", "value"=>55}, "end_location"=>{"lat"=>38.8976506, "lng"=>-77.0297095}, "html_instructions"=>"Turn <b>right</b> onto <b>13th St NW</b>", "maneuver"=>"turn-right", "polyline"=>{"points"=>"millFrzcuMpA@F?h@?"}, "start_location"=>{"lat"=>38.8983127, "lng"=>-77.0297022}, "travel_mode"=>"WALKING"}], "travel_mode"=>"WALKING"}, {"distance"=>{"text"=>"6.1 mi", "value"=>9888}, "duration"=>{"text"=>"19 mins", "value"=>1140}, "end_location"=>{"lat"=>38.8533825, "lng"=>-77.0439868}, "html_instructions"=>"Metro rail towards Franconia-Springfield", "polyline"=>{"points"=>"qillFppcuMW[_Q`XC~PC~[^vNdBdq@N`Ax^~dCF\\raDqpB^Xtf@t_@d\\}p@|A_DxZuf@AA"}, "start_location"=>{"lat"=>38.8983281, "lng"=>-77.0280918}, "transit_details"=>{"arrival_stop"=>{"location"=>{"lat"=>38.8533825, "lng"=>-77.0439868}, "name"=>"Ronald Reagan Washington National Airport"}, "arrival_time"=>{"text"=>"10:09pm", "time_zone"=>"America/New_York", "value"=>1549940940}, "departure_stop"=>{"location"=>{"lat"=>38.8983281, "lng"=>-77.0280918}, "name"=>"Metro Center Station"}, "departure_time"=>{"text"=>"9:50pm", "time_zone"=>"America/New_York", "value"=>1549939800}, "headsign"=>"Franconia-Springfield", "line"=>{"agencies"=>[{"name"=>"WMATA", "phone"=>"1 (202) 637-7000", "url"=>"http://www.wmata.com/"}], "color"=>"#0d7bba", "name"=>"Metrorail Blue Line", "short_name"=>"Blue", "vehicle"=>{"icon"=>"//maps.gstatic.com/mapfiles/transit/iw2/6/metro.png", "name"=>"Metro rail", "type"=>"SUBWAY"}}, "num_stops"=>8}, "travel_mode"=>"TRANSIT"}, {"distance"=>{"text"=>"0.2 mi", "value"=>376}, "duration"=>{"text"=>"4 mins", "value"=>257}, "end_location"=>{"lat"=>38.8494691, "lng"=>-77.0414382}, "html_instructions"=>"Walk to Ronald Reagan Washington National Airport (DCA), Arlington, VA 22202, USA", "polyline"=>{"points"=>"_kclFfnfuMVIh@QNEp@Sl@OXIVI`@Kb@OLOr@WZKDCf@OPCBCBCDCFEFE@KBKHSJUJSHGDEDCDAFCLAL?J@"}, "start_location"=>{"lat"=>38.852481, "lng"=>-77.0430799}, "steps"=>[{"distance"=>{"text"=>"0.2 mi", "value"=>268}, "duration"=>{"text"=>"3 mins", "value"=>178}, "end_location"=>{"lat"=>38.8502021, "lng"=>-77.0421071}, "html_instructions"=>"Head <b>south</b> on <b>Aviation Cir</b>", "polyline"=>{"points"=>"_kclFfnfuMVIh@QNEp@Sl@OXIVI`@Kb@OLOr@WZKDCf@OPC"}, "start_location"=>{"lat"=>38.852481, "lng"=>-77.0430799}, "travel_mode"=>"WALKING"}, {"distance"=>{"text"=>"354 ft", "value"=>108}, "duration"=>{"text"=>"1 min", "value"=>79}, "end_location"=>{"lat"=>38.8494691, "lng"=>-77.0414382}, "html_instructions"=>"Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>", "maneuver"=>"turn-left", "polyline"=>{"points"=>"w|blFdhfuMBCBCDCFEFE@KBKHSJUJSHGDEDCDAFCLAL?J@"}, "start_location"=>{"lat"=>38.8502021, "lng"=>-77.0421071}, "travel_mode"=>"WALKING"}], "travel_mode"=>"WALKING"}], "traffic_speed_entry"=>[], "via_waypoint"=>[]}], "overview_polyline"=>{"points"=>"qillFnnduMBuP?eApA@p@?gCcIW[_Q`XC~PC~[^vNdBdq@N`A`_@|eCraDqpB^Xtf@t_@d\\}p@|A_DxZuf@AArDuD`A[hCs@x@Ub@OLOnAc@l@STGHGNKDWTi@T[JILEZAJ@"}, "summary"=>"", "warnings"=>["Walking directions are in beta.    Use caution – This route may be missing sidewalks or pedestrian paths."], "waypoint_order"=>[]}], "status"=>"OK"}
    directions = []
    puts "Duration:" + hash["routes"][0]["legs"][0]["duration"]["text"]
    hash["routes"][0]["legs"][0]["steps"].each do |main|
      directions << main["html_instructions"]
      if main["steps"]
        if main["steps"][0]
          if main["steps"][0]["html_instructions"]
            main["steps"].each do |inner|
              directions << inner["html_instructions"]
            end
          end
        end
      end
    end
    directions
  end
end

# hash["routes"][0]["legs"][0]["distance"]["text"].split(" ")[0].to_f
# put me into rails console
# mode = Api.new
# hash = mode.maps_call
# ap hash
