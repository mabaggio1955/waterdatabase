require 'rails_helper'

RSpec.describe ContentsController, :type => :controller do

  describe "GET #index" do
    let!(:content) { create(:content) }

    def action
      get :index
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:index) }
    it { expect(assigns(:contents)).to eq([content]) }
  end

  describe "GET #show" do
    let!(:content) { create(:content) }

    def action
      get :show, id: content.to_param
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:show) }
    it { expect(assigns(:content)).to eq(content) }
  end

  describe "GET #new" do
    def action
      get :new
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }
    it { expect(assigns(:content)).to be_a_new(Content) }
  end

  describe "GET #edit" do
    let!(:content) { create(:content) }

    def action
      get :edit, id: content.to_param
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:content)).to eq(content) }
  end

  describe "POST #create" do
    let(:params) { attributes_for(:content) }

    def action
      post :create, content: params
    end

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
        is_expected.to redirect_to(Content.last)
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

  describe "PUT #update" do
    let!(:content) { create(:content) }
    let(:params) { attributes_for(:content) }

    def action
      put :update, id: content.to_param, content: params
    end

    context "with valid params" do
      before { action }

      it { expect(assigns(:content)).to eq(content) }
      it { is_expected.to redirect_to(content) }
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

  describe "DELETE #destroy" do
    let!(:content) { create(:content) }

    def action
      delete :destroy, id: content.to_param
    end

    it do
      expect { action }.to change(Content, :count).by(-1)
    end

    it do
      action
      is_expected.to redirect_to(contents_url)
    end

    it do
      action
      is_expected.to set_the_flash.to('Content was successfully destroyed.')
    end
  end

end