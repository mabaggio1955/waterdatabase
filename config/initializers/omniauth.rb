# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], { scope: "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email", approval_prompt: '' }
end