require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:google_auth) {
    OmniAuth::AuthHash.new({
      "provider" => "google_oauth2",
      "uid"      =>"54321",
      "info"     => {
        "name"       =>"João",
        "email"      =>"joao@helabs.com.br",
        "first_name" => "João",
        "last_name"  =>"José"
      },
      "credentials" => {
        "token"         => "GDRIVE-TOKEN",
        "refresh_token" => "54321",
        "expires_at"    => 1348517217,
        "expires"       => true
      },
      "extra" => {
        "raw_info" => {
          "id"             => "54321",
          "email"          => "joao@helabs.com.br",
          "verified_email" => true,
          "name"           => "João",
          "given_name"     => "João",
          "family_name"    => "José",
          "link"           => "https://plus.google.com/1",
          "gender"         => "male",
          "birthday"       => "0000-10-10",
          "locale"         => "pt-BR"
        }
      }
    })
  }

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
    end
    context 'uniqueness' do
      let!(:user) { FactoryGirl.create(:user) }
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to validate_uniqueness_of(:google_uid) }
    end
  end

  describe 'find_or_create_with_omniauth' do
    context 'new_user' do
      it {
        expect {
          User.find_or_create_with_omniauth(google_auth)
        }.to change(User, :count).by(1)
      }
      context 'data' do
        subject { User.find_or_create_with_omniauth(google_auth) }

        describe '#name' do
          subject { super().name }
          it { is_expected.to eq("João") }
        end

        describe '#email' do
          subject { super().email }
          it { is_expected.to eq("joao@helabs.com.br") }
        end

        describe '#google_uid' do
          subject { super().google_uid }
          it { is_expected.to eq("54321") }
        end

        describe '#google_token' do
          subject { super().google_token }
          it { is_expected.to eq("GDRIVE-TOKEN") }
        end
      end
    end
  end
end
