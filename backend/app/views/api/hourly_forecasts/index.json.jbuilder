# frozen_string_literal: true

json.array! @hourly_forecasts, partial: 'hourly_forecasts/hourly_forecast', as: :hourly_forecast
