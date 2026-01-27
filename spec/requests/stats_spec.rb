require 'rails_helper'

RSpec.describe "Stats", type: :request do
  before { FactoryBot.create(:evaluation) }

  describe "GET /index" do
    it "returns http success" do
      get "/stats"

      expect(response).to have_http_status(:success)
    end
  end
end
