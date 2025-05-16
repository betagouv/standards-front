# frozen_string_literal: true

module LoginHelper
  def login_as(email)
    OmniAuth.config.mock_auth[:developer] = OmniAuth::AuthHash.new(
      { provider: "developer",
        info: {
          email:
        }
      }
    )

    get "/auth/developer/callback"
  end
end

RSpec.configure do |config|
  OmniAuth.config.test_mode = true

  config.after(:each) do
    OmniAuth.config.mock_auth[:developer] = nil
  end

  config.include(LoginHelper, type: :request)
end
