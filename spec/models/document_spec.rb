require 'rails_helper'

RSpec.describe Document, :type => :model do
  include ActionDispatch::TestProcess

  describe "validations" do
    it { is_expected.to have_attached_file(:file) }
    it { is_expected.to validate_attachment_content_type(:file) }
    it { is_expected.to validate_presence_of(:content) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:content) }
  end

  describe "file_direct_url=" do
    let(:file_path) do
      Rails.root.join("spec", "fixtures", "test.jpg")
    end

    before do
      subject.file_direct_url = file_path
    end

    it { expect(subject.file_file_name).to eq("test.jpg") }
  end
end
