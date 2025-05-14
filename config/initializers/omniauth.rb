Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production? || Rails.env.staging?
    keys = %i[
      client_id
      client_secret
      proconnect_domain
      redirect_uri
      post_logout_redirect_uri
    ]

    provider Omniauth::Proconnect, *keys.map do |key|
      Rails.application.credentials.dig(:auth, :proconnect, key)
    end
  else
    provider :developer
  end
end
