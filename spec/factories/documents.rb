# Read about factories at https://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :document do
    file { fixture_file_upload(Rails.root.join("spec", "fixtures", "test.jpg"), "image/jpeg") }
    content nil
  end
end
