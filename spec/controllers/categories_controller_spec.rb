require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do

  describe "GET index" do
    let!(:category) { create(:category) }

    def action
      get :index
    end

    before { action }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:categories)).to match_array(category) }
    it { is_expected.to render_template(:index) }
  end

end
