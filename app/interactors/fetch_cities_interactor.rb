class FetchCitiesInteractor
  include Interactor

  def call
    response = cities_client.search_places

    return context.fail!(error: response['error']) if response.is_a?(Hash) && response.key?('error')

    context.cities = response.uniq { |city| city['city_name'] }.first(1).map do |city|
      { name: city['city_name'], lat: city['lat'], lon: city['long'] }
    end
  rescue StandardError => e
    context.fail!(message: e.message, error_code: :internal)
  end

  delegate :cities_client, :query, to: :context
end
