# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    title "MyString"
    description "MyText"
    category_id { create(:category).id }
  end
end
