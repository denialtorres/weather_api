class FetchWeatherOrganizer
  include Interactor::Organizer

  organize FetchCitiesInteractor,
           FetchWeatherFromCitiesInteractor

  before do
    context.cities_client = ReservamosClient.new(context.query)
  end
end

# result = FetchWeatherOrganizer.call(query: "mon")
