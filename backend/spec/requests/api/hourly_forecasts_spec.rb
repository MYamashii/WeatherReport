# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HourlyForecasts', type: :request do
  describe 'GET /api/hourly_forecasts' do
    it 'works! (now write some real specs)' do
      get api_hourly_forecasts_path
      expect(response).to have_http_status(200)
    end
  end
end
