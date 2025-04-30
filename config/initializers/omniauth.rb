Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider Omniauth::Proconnect, {
             client_id: ENV.fetch("BETA_STANDARDS_PC_CLIENT_ID"),
             client_secret: ENV.fetch("BETA_STANDARDS_PC_CLIENT_SECRET"),
             proconnect_domain: ENV.fetch("BETA_STANDARDS_PC_HOST"),
             redirect_uri: ENV.fetch("BETA_STANDARDS_PC_REDIRECT_URI"),
             post_logout_redirect_uri: ENV.fetch("BETA_STANDARDS_PC_POST_LOGOUT_REDIRECT_URI"),
           }
end
