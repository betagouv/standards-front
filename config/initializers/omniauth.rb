
# Rails disables CSRF protection in test (c.f
# config/environments/test.rb), so turn off OmniAuth's
# request_validation_phase middleware which is
# AuthenticityTokenProtection by default[1].

# In other environments, tweak it to use the correct session key,
# which Rails sets to `_csrf_token` when rack-protection expects
# `csrf`[2].
#
# [1]: https://github.com/omniauth/omniauth/blob/master/lib/omniauth.rb#L43
# [2]: https://github.com/sinatra/sinatra/blob/nil/rack-protection/lib/rack/protection/authenticity_token.rb#L101-L103
OmniAuth.config.request_validation_phase =
  if Rails.env.test?
    nil
  else
    OmniAuth::AuthenticityTokenProtection.new(key: :_csrf_token)
  end

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
