# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::WeatherService, type: :request do

  context 'when lat and long is given' do
    before do
      latitude = '39.890070'
      longitude = '-104.790330'
      coordinates = "#{latitude}, #{longitude}"
      service = Api::WeatherService.new(coordinates)

      VCR.use_cassette "weather_api/ok_response" do
        @res = service.get_forecast
      end
    end

    it 'returns 200' do
      expect(@res.code).to eq(200)
    end

    it 'returns a forecast object' do
      parsed_body = JSON.parse(@res.body)

      expect(parsed_body['location'].present?).to eq(true)
    end
  end
end