require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    require 'open-uri'
    open(url).read
    parsed_data = JSON.parse(open(url).read)
    @latitude = {@streetaddress=>parsed_data["results"][0]["geometry"]["location"]["lat"]}


    @longitude = "wtf."

    render("geocoding/street_to_coords.html.erb")
  end
end
