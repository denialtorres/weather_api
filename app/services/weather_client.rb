require 'httparty'

class WeatherClient
  include HTTParty
  base_uri 'https://api.tomorrow.io/v4'
  API_KEY = ENV['WEATHER_KEY']

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def get_forecast
    response = self.class.get('/weather/forecast', query: {
                                location: "#{@lat},#{@lon}",
                                fields: 'temperature,temperatureMax,temperatureMin',
                                timesteps: 'daily',
                                units: 'metric',
                                apikey: API_KEY
                              })
    response.parsed_response
  rescue StandardError => e
    { error: e.message }
  end
end

# Example usage:
# client = WeatherClient.new(40.7128, -74.0060) # New York City coordinates
# puts client.get_forecast
