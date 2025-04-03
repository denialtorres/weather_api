require 'httparty'

class ReservamosClient
  include HTTParty
  base_uri 'https://search.reservamos.mx/api/v2'

  def initialize(query, from: nil, to: nil)
    @query = query
    @from = from
    @to = to
  end

  def search_places
    response = self.class.get('/places', query: query_params)
    response.parsed_response
  rescue StandardError => e
    { error: e.message }
  end

  private

  def query_params
    params = { q: @query }
    params[:from] = @from if @from
    params[:to] = @to if @to
    params
  end
end

# Example usage:
# client = ReservamosClient.new("mon")
# puts client.search_places
# client = ReservamosClient.new("mon", from: "ciudad-de-mexico")
# puts client.search_places
# client = ReservamosClient.new("mon", to: "ciudad-de-mexico")
# puts client.search_places
