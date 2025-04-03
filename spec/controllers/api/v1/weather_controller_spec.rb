require 'rails_helper'

RSpec.describe Api::V1::WeatherController, type: :controller do
  describe 'GET #fetch_weather' do
    let(:valid_params) { { query: 'mon' } }

    context 'when the request is valid', :vcr do
      it 'returns a successful response with weather data' do
        get :fetch_weather, params: valid_params

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['success']).to eq(true)
        expected_cities = ['Monterrey']
        actual_cities = json['data'].map { |city| city['city'] }
        expect(actual_cities).to include(*expected_cities)

        weather_data = json['data'].first['weather']
        expect(weather_data).to be_an(Array)
        expect(weather_data.first).to include('date', 'temperature_avg', 'temperature_max', 'temperature_min')
        expect(weather_data.first['temperature_avg']).to be_a(Numeric)
        expect(weather_data.first['temperature_max']).to be_a(Numeric)
        expect(weather_data.first['temperature_min']).to be_a(Numeric)
      end
    end

    context 'error handling' do
      before do
        allow_any_instance_of(ReservamosClient).to receive(:search_places).and_raise(StandardError,
                                                                                     'Custom error message')
      end

      it 'returns an error response' do
        get :fetch_weather, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['success']).to eq(false)
        expect(json['error']).to eq('Custom error message')
        expect(json['error_code']).to eq('internal')
      end
    end
  end
end
