Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    env = ENV.fetch("BETA_STANDARDS_ENV")

    config = %i[
      client_id
      client_secret
      proconnect_domain
      redirect_uri
      post_logout_redirect_uri
    ].map { |key| [ key, Rails.application.credentials.dig(env, :auth, :proconnect, key) ] }.to_h

    provider Omniauth::Proconnect, config
  else
    provider :developer
  end
end
