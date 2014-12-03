require 'rails_helper'

RSpec.describe Category, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to ensure_length_of(:name).is_at_most(255) }
  end

  describe "associations" do
    it { is_expected.to have_many(:contents) }
  end
end
