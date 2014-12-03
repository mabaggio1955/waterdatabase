require 'rails_helper'

RSpec.describe Document, :type => :model do
  describe "associations" do
    it { is_expected.to belong_to(:content) }
  end
end
