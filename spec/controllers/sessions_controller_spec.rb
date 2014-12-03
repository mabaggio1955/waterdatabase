require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

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
          "email"          => "email@helabs.com.br",
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


    describe 'create' do
    def do_action
      get :create, provider: "google_oauth2"
    end
    let!(:user) { create(:user, email: "joao@helabs.com.br") }

    context 'sucess' do
      before do
        request.env["omniauth.auth"] = google_auth
        do_action
      end
      it { expect(session[:user_id]).to eq(user.id) }
      it { expect(response).to redirect_to(root_path) }
    end
    context 'error' do
      before do
        request.env["omniauth.auth"] = google_auth.merge({
          "info"     => {
            "name"       =>"João",
            "email"      =>"joao@example.com",
            "first_name" => "João",
            "last_name"  =>"José"
          }
        })
        do_action
      end
      it { expect(session[:user_id]).to be_nil }
      it { expect(flash[:notice]).to be_nil }
      it { expect(flash[:alert]).to eq("Não foi possível autenticar.") }
      it { expect(response).to redirect_to(root_path) }
    end
  end

  describe "GET destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end

end
