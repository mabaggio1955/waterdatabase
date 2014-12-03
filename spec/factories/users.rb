# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    google_uid "MyString"
    name "MyString"
    google_token "MyString"
    oauth_expires_at "2014-12-03 14:28:00"
  end
end
