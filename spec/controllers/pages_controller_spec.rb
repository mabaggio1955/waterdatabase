require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET home" do
    def do_action
      get :home
    end

    it "returns http success" do
      do_action
      expect(response).to have_http_status(:success)
    end

    context 'logged_out' do
      before do
        do_action
      end
      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:home) }
    end
    context 'logged_in' do
      before do
        user = create(:user, email: "joao@helabs.com.br")
        session[:user_id] = user.id
        do_action
      end
      it { expect(response).to redirect_to(contents_path) }
    end
  end

  describe "GET dashboard" do
    it "returns http success" do
      get :dashboard
      expect(response).to have_http_status(:success)
    end
  end

end
