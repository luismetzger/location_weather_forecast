# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    return unless params[:address]

    address = convert_address(params[:address])
    @results = Api::WeatherService.new(address).get_forecast
  end

  private

  def convert_address(address)
    Geocoder.search(address).first.coordinates.join(', ')
  end
end
