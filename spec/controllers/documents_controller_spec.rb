require 'rails_helper'

RSpec.describe DocumentsController, :type => :controller do
  let(:content) { create(:content) }

  describe "POST #create" do
    let(:params) { attributes_for(:document) }

    def action
      post :create, document: params, content_id: content.to_param
    end

    context "with valid params" do
      it do
        expect { action }.to change(Document, :count).by(1)
      end

      it do
        action
        expect(assigns(:document)).to be_persisted
      end

      it do
        action
        expect(assigns(:document)).to be_a(Document)
      end

      it do
        action
        is_expected.to redirect_to(content)
      end

      it do
        action
        is_expected.to set_the_flash.to('Document was successfully created.')
      end
    end

    context "with invalid params" do
      before do
        expect_any_instance_of(Document).to receive(:save).and_return(false)
      end

      before { action }

      it { expect(assigns(:document)).to be_a_new(Document) }
      it { is_expected.to redirect_to(content) }
    end
  end

  describe "DELETE #destroy" do
    let!(:document) { create(:document) }

    def action
      delete :destroy, id: document.to_param, content_id: content.to_param
    end

    it do
      expect { action }.to change(Document, :count).by(-1)
    end

    it do
      action
      is_expected.to redirect_to(content)
    end

    it do
      action
      is_expected.to set_the_flash.to('Document was successfully destroyed.')
    end
  end

end
