require_relative 'api_key.rb'
require 'net/http'
require 'json'
require 'amadeus'
require 'awesome_print'
require 'byebug'
require 'pry'

class Api

  def amadeus_call(flight_hash)
    # origin = flight_hash["origin"].split(" ")[0]
    destination = flight_hash["destination"].split(" ")[0]
    origin_array = []
    if flight_hash["origin"].is_a?(String)
      origin = flight_hash["origin"].split(" ")[0]
      origin_array << origin
    else
      flight_hash["origin"].each do |o|
        origin_array << o
      end
    end
    departure_date = flight_hash["departure_date"]
    nonstop = flight_hash["nonstop"]
    travel_class = flight_hash["travel_class"]
    # FIX THE REST TO ACCOUNT FOR ORIGIN
    amadeus = Amadeus::Client.new(client_id: API_KEY, client_secret: API_SECRET)
    what = origin_array.map do |origin_element|
      begin
        response = amadeus.shopping.flight_offers.get(origin: origin_element, destination: destination, departureDate: departure_date, nonStop: nonstop, travelClass: travel_class, max: 10)
        hash = response.result
        array = hash["data"].map do |hash|
          flight = FlightOption.new(hash)
          if hash["offerItems"][0]["services"][0]["segments"][0]["flightSegment"]["arrival"]["iataCode"] == destination.upcase
            flight.nonstop = "Yes"
          else
            flight.nonstop = "No"
          end
          flight
        end
      rescue Amadeus::ResponseError => error
      end
      array
    end
    what.flatten
  end

  def maps_call(hash)
    origin = hash[:origin]
    # "1440+G+Street+NW+Washington+DC"
    destination = hash[:destination]
    # "Ronald Reagan National Airport"
    mode = hash[:mode]
    # Airports within 300 miles of Washington DC:
    if mode == "driving"
      url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=#{mode}"
    elsif mode == "transit"
      url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=#{mode}&transit_mode=bus|subway"
    elsif mode == "rail"
      url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{GOOG_API_KEY}&mode=transit&transit_mode=rail"
    end
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
      "Roanoke Regional Woodrum Field", "Newark Liberty International Airport", "LaGuardia Airport","John F. Kennedy International Airport"]

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

    def get_duration(hash)
      if hash["routes"] != []
      return hash["routes"][0]["legs"][0]["duration"]["text"]
      end
    end

    def get_directions_array(hash)
      directions = []
      sentence = []
      if hash["available_travel_modes"]
        sentence << "Sorry, your only available travel modes are "
        hash["available_travel_modes"].each_with_index {|mode, i| sentence << "(#{i+1}) #{mode.downcase}"}
        directions << sentence.join(" ")+"."
      else
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
      end
      directions
    end

    def get_airport_codes(hash)
      distance_hash = get_distance_hash(hash[:origin])
      airport_options = find_airports_within_radius({radius: hash[:radius], hash: distance_hash})
      codes = {"Ronald Reagan Washington National Airport": "DCA",
        "Washington Dulles International Airport": "IAD",
        "Baltimore/Washington International Thurgood Marshal Airport": "BWI",
        "Richmond International Airport": "RIC","Philadelphia International Airport": "PHL",
        "Newport News Williamsburg International Airport": "PHF","Norfolk International Airport":"ORF",
        "Roanoke Regional Woodrum Field": "ROA", "Newark Liberty International Airport": "EWR", "LaGuardia Airport": "LGA","John F. Kennedy International Airport": "JFK"}
        airport_array = []
        airport_options.each do |option|
          airport_array << [option.values[0], codes[option.values[0].to_sym]]
        end
        airport_array
      end

      def get_all_airport_codes
        array = get_airport_codes(origin: "1440 G Street NW Washington DC", radius: 300)
        array
      end

      def get_all_airports
        airports = ["Ronald Reagan Washington National Airport",
          "Washington Dulles International Airport",
          "Baltimore/Washington International Thurgood Marshal Airport",
          "Richmond International Airport","Philadelphia International Airport",
          "Newport News Williamsburg International Airport","Norfolk International Airport",
          "Roanoke Regional Woodrum Field", "Newark Liberty International Airport", "LaGuardia Airport","John F. Kennedy International Airport"]
          airportz = []
          airportz = airports.zip(airports)
          airportz
        end
      end
