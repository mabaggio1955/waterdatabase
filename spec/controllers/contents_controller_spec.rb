require 'rails_helper'

RSpec.describe ContentsController, :type => :controller do
  let!(:content) { create(:content) }
  let(:category) { content.category }

  describe "GET #index" do
    it_should_behave_like "authentication_required_action"

    def action
      get :index, category_id: category.to_param
    end

    context 'signed_in' do
      let!(:category) { create(:category) }
      let!(:content_2) { create(:content, category: category) }

      before { login! }
      before { action }

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:index) }
      it { expect(assigns(:contents)).to match_array([content_2]) }
      it { expect(assigns(:category)).to eq(category) }
    end
  end

  describe "GET #show" do
    it_should_behave_like "authentication_required_action"

    def action
      get :show, id: content.to_param, category_id: category.to_param
    end

    context 'signed_in' do
      before { login! }
      before { action }

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:show) }
      it { expect(assigns(:content)).to eq(content) }
    end
  end

  describe "GET #new" do
    it_should_behave_like "authentication_required_for_admin"

    def action
      get :new, category_id: category.to_param
    end

    context 'signed_in_as_admin' do
      before { login_admin! }
      before { action }

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
      it { expect(assigns(:content)).to be_a_new(Content) }
    end
  end

  describe "GET #edit" do
    it_should_behave_like "authentication_required_for_admin"

    def action
      get :edit, id: content.to_param, category_id: category.to_param
    end

    context 'signed_in_as_admin' do
      before { login_admin! }
      before { action }

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:edit) }
      it { expect(assigns(:content)).to eq(content) }
    end
  end

  describe "POST #create" do
    let(:params) { attributes_for(:content) }
    it_should_behave_like "authentication_required_for_admin"

    def action
      post :create, content: params, category_id: category.to_param
    end

    context 'signed_in_as_admin' do
      before { login_admin! }

      context "with valid params" do
        it do
          expect { action }.to change(Content, :count).by(1)
        end

        it do
          action
          expect(assigns(:content)).to be_persisted
        end

        it do
          action
          expect(assigns(:content)).to be_a(Content)
        end

        it do
          action
          is_expected.to redirect_to([category, Content.last])
        end

        it do
          action
          is_expected.to set_the_flash.to('Content was successfully created.')
        end
      end

      context "with invalid params" do
        before do
          expect_any_instance_of(Content).to receive(:save).and_return(false)
        end

        before { action }

        it { expect(assigns(:content)).to be_a_new(Content) }
        it { is_expected.to render_template("new") }
      end
    end
  end

  describe "PUT #update" do
    let(:params) { attributes_for(:content) }
    it_should_behave_like "authentication_required_for_admin"

    def action
      put :update, id: content.to_param, content: params, category_id: category.to_param
    end

    context 'signed_in_as_admin' do
      before { login_admin! }

      context "with valid params" do
        before { action }

        it { expect(assigns(:content)).to eq(content) }
        it { is_expected.to redirect_to([category, content]) }
        it { is_expected.to set_the_flash.to('Content was successfully updated.') }
      end

      context "with invalid params" do
        before do
          expect_any_instance_of(Content).to receive(:update).and_return(false)
        end

        before { action }

        it { expect(assigns(:content)).to eq(content) }
        it { is_expected.to render_template(:edit) }
      end
    end
  end

  describe "DELETE #destroy" do
    it_should_behave_like "authentication_required_for_admin"

    def action
      delete :destroy, id: content.to_param, category_id: category.to_param
    end

    context 'signed_in_as_admin' do
      before { login_admin! }

      it do
        expect { action }.to change(Content, :count).by(-1)
      end

      it do
        action
        is_expected.to redirect_to([category, :contents])
      end

      it do
        action
        is_expected.to set_the_flash.to('Content was successfully destroyed.')
      end
    end
  end

end
