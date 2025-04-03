module Api
  module V1
    class WeatherController < ApplicationController
      def fetch_weather
        payload = FetchWeatherOrganizer.call(params: params)

        if payload.success?
          render json: { success: true, data: payload.weather_cities }, status: :ok
        else
          render json: { success: false, error: payload.message, error_code: payload.error_code },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
