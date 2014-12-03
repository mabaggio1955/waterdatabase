Jumpup::Heroku.configure do |config|
  config.app = 'waterdatabase'
end if Rails.env.development?
