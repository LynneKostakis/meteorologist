require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @url="https://maps.googleapis.com/maps/api/geocode/json?address="+@street_address
   
    parsed_data = JSON.parse(open(@url).read)
   
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
   
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
   
    @url="https://api.darksky.net/forecast/2264d4d297f157b8db9fad52eadfd708/"+@latitude.to_s+","+@longitude.to_s
   
    parsed_data = JSON.parse(open(@url).read)

    @current_temperature = parsed_data.dig("currently", "temperature")

    @current_summary = parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_data.dig("daily", "summary")

   
    render("meteorologist/street_to_weather.html.erb")
  end
end
