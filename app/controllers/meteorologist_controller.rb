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
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address.gsub(" ","+")+"&sensor=false"

    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2 = "https://api.darksky.net/forecast/e6a20e1a12761100d0992b101d6408f9/#{@latitude},#{@longitude}"

    raw_data2 = open(url2).read
    parsed_data2 = JSON.parse(raw_data2)



    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
