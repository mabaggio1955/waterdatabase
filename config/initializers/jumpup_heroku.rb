Jumpup::Heroku.configure do |config|
  config.app = 'water_database'
end if Rails.env.development?
