require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, :type => :controller do

<% unless options[:singleton] -%>
  describe "GET #index" do
    let!(:<%= file_name %>) { create(:<%= file_name %>) }

    def action
      get :index
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:index) }
    it { expect(assigns(:<%= table_name %>)).to eq([<%= file_name %>]) }
  end

<% end -%>
  describe "GET #show" do
    let!(:<%= file_name %>) { create(:<%= file_name %>) }

    def action
      get :show, id: <%= file_name %>.to_param
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:show) }
    it { expect(assigns(:<%= file_name %>)).to eq(<%= file_name %>) }
  end

  describe "GET #new" do
    def action
      get :new
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }
    it { expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>) }
  end

  describe "GET #edit" do
    let!(:<%= file_name %>) { create(:<%= file_name %>) }

    def action
      get :edit, id: <%= file_name %>.to_param
    end

    before { action }

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:<%= file_name %>)).to eq(<%= file_name %>) }
  end

  describe "POST #create" do
    let(:params) { attributes_for(:<%= file_name %>) }

    def action
      post :create, <%= file_name %>: params
    end

    context "with valid params" do
      it do
        expect { action }.to change(<%= class_name %>, :count).by(1)
      end

      it do
        action
        expect(assigns(:<%= ns_file_name %>)).to be_persisted
      end

      it do
        action
        expect(assigns(:<%= ns_file_name %>)).to be_a(<%= class_name %>)
      end

      it do
        action
        is_expected.to redirect_to(<%= class_name %>.last)
      end

      it do
        action
        is_expected.to set_the_flash.to('<%= class_name %> was successfully created.')
      end
    end

    context "with invalid params" do
      before do
        expect_any_instance_of(<%= class_name %>).to receive(:save).and_return(false)
      end

      before { action }

      it { expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>) }
      it { is_expected.to render_template("new") }
    end
  end

  describe "PUT #update" do
    let!(:<%= file_name %>) { create(:<%= file_name %>) }
    let(:params) { attributes_for(:<%= file_name %>) }

    def action
      put :update, id: <%= file_name %>.to_param, <%= file_name %>: params
    end

    context "with valid params" do
      before { action }

      it { expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>) }
      it { is_expected.to redirect_to(<%= file_name %>) }
      it { is_expected.to set_the_flash.to('<%= class_name %> was successfully updated.') }
    end

    context "with invalid params" do
      before do
        expect_any_instance_of(<%= class_name %>).to receive(:update).and_return(false)
      end

      before { action }

      it { expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>) }
      it { is_expected.to render_template(:edit) }
    end
  end

  describe "DELETE #destroy" do
    let!(:<%= file_name %>) { create(:<%= file_name %>) }

    def action
      delete :destroy, id: <%= file_name %>.to_param
    end

    it do
      expect { action }.to change(<%= class_name %>, :count).by(-1)
    end

    it do
      action
      is_expected.to redirect_to(<%= index_helper %>_url)
    end

    it do
      action
      is_expected.to set_the_flash.to('<%= class_name %> was successfully destroyed.')
    end
  end

end
<% end -%>
