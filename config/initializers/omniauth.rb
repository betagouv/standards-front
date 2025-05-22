Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    config = Rails
             .application
             .credentials
             .dig(ENV.fetch("BETA_STANDARDS_ENV"), :auth, :proconnect)

    provider :proconnect, config
  else
    provider :developer
  end
end
