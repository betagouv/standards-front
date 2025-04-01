require 'rails_helper'

RSpec.describe "Startups", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/startups/index"
      expect(response).to have_http_status(:success)
    end
  end

end
