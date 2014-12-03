require 'rails_helper'

RSpec.describe Content, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:locale) }
    it { is_expected.to ensure_length_of(:title).is_at_most(255) }
    it { is_expected.to ensure_length_of(:locale).is_at_most(255) }
  end
end
