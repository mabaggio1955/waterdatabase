# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "email#{n}@helabs.com.br" }
  factory :user do
    email
    name "Mollis Ullamcorper"
    google_uid "54321"
    google_token "GDRIVE-TOKEN"
    oauth_expires_at "2014-12-03 14:28:00"
  end
end
