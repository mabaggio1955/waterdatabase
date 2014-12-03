require 'rails_helper'

RSpec.describe Content, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:locale) }
    it { is_expected.to ensure_length_of(:title).is_at_most(255) }
    it { is_expected.to ensure_length_of(:locale).is_at_most(255) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:documents).dependent(:destroy) }
  end

  describe "#locale" do
    it "has the current locale by default" do
      expect(subject.locale).to eq(I18n.locale)
    end
  end
end
