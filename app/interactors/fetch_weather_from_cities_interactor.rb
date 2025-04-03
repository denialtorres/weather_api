class FetchWeatherFromCitiesInteractor
  include Interactor

  def call
    context.weather_cities = cities.map do |city|
      weather_data = fetch_weather(city[:lat], city[:lon])
      { city: city[:name], weather: weather_data }
    end
  end

  private

  delegate :cities, to: :context

  def fetch_weather(lat, lon)
    response = WeatherClient.new(lat, lon).get_forecast
    return [] if response.is_a?(Hash) && response.key?('error') || rate_limer(response)

    response['timelines']['daily'].map do |day|
      {
        date: day['time'],
        temperature_avg: day['values']['temperatureApparentAvg'],
        temperature_max: day['values']['temperatureApparentMax'],
        temperature_min: day['values']['temperatureApparentMin']
      }
    end
  end

  def rate_limer(response)
    response["code"] == 429001
  end
end
