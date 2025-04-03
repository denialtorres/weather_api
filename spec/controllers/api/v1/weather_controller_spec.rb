require 'rails_helper'

RSpec.describe Api::V1::WeatherController, type: :controller do
  describe 'GET #fetch_weather' do
    let(:valid_params) { { query: "mon" } }
    let(:invalid_params) { { cities: [] } }

    context 'when the request is valid', :vcr do
      it 'returns a successful response with weather data' do
        get :fetch_weather, params: valid_params

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['success']).to eq(true)
        expected_cities = ['Monterrey']
        actual_cities = json['data'].map { |city| city['city'] }

        expect(actual_cities).to include(*expected_cities)
      end
    end

    # context 'when the request is invalid' do
    #   it 'returns an error response' do
    #     get :fetch_weather, params: invalid_params
    #
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     json = JSON.parse(response.body)
    #     expect(json['success']).to eq(false)
    #     expect(json['error']).to eq('Invalid city query')
    #     expect(json['error_code']).to eq('invalid_request')
    #   end
    # end
  end
end
