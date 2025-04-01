# frozen_string_literal: true

OmniAuth.config.test_mode = true

After do
  OmniAuth.config.mock_auth[:developer] = nil
end
