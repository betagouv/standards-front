Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :openid_connect, {
    name: :proconnect,
    scope: "openid email",
    response_type: :code,
    issuer: ENV.fetch("BETA_STANDARDS_PC_HOST"),
    discovery: true,
    client_options: {
      redirect_uri: ENV.fetch("BETA_STANDARDS_PC_REDIRECT_URI"),
      identifier: ENV.fetch("BETA_STANDARDS_PC_CLIENT_ID"),
      secret: ENV.fetch("BETA_STANDARDS_PC_CLIENT_SECRET")
    }
  }
end
