# frozen_string_literal: true

module Api
  class WeatherService
    include HTTParty

    BASE_URI = Rails.application.credentials[:WEATHER_API_BASE_URI]
    API_KEY = Rails.application.credentials[:WEATHER_API_KEY]
    VERSION = 'v1'

    def initialize(location)
      @location = location
    end

    attr_reader :location

    def get_forecast
      endpoint = "#{BASE_URI}/#{VERSION}/forecast.json"
      query = {
        'key' => API_KEY,
        'q' => location,
        'days' => 5,
        'aqi' => 'no',
        'alerts' => 'no'
      }

      # The initial request is cached.
      # new requests are not cached until expiration time is met.
      Rails.cache.fetch('forecast_results', expires_in: 30.minutes) do
        JSON.parse(self.class.get(endpoint, query: query).to_json)
      end
    end
  end
end
