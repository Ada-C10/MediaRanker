# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email"
end

# env vars are in .env
# This tells Rails to use OmniAuth for authentication.
# Specifically, it tells Rails that it will be communicating with GitHub,
# and where it can find the application credentials that GitHub expects:
# in the ENV variable we populated earlier
