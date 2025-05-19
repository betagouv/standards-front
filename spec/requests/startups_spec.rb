require 'rails_helper'

RSpec.describe "Startups", type: :request do
  let(:user) { FactoryBot.create(:user, :with_active_mission) }
  let(:startup) { FactoryBot.create(:startup) }

  before do
    user.missions.last.startups << startup
  end

  describe "GET /index" do
    before do
      login_as(user.primary_email)
    end

    it "returns http success" do
      get "/startups"

      expect(response).to have_http_status(:success)
    end
  end
end
