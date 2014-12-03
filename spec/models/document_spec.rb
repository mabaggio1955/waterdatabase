require 'rails_helper'

RSpec.describe Document, :type => :model do
  describe "validations" do
    it { is_expected.to have_attached_file(:file) }
    it { is_expected.to validate_attachment_content_type(:file) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:content) }
  end
end
