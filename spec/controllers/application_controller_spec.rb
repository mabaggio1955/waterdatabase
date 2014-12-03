require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

  describe 'helpers' do
    let(:user) { create(:user) }
    describe 'current_user' do
      context 'logged_in' do
        context 'valid_id' do
          before { session[:user_id] = user.id }

          it { expect(controller.send(:current_user)).to eq(user) }
        end
      end
      context ':logged_out' do
        before { session[:user_id] = nil }

        it { expect(controller.send(:current_user)).to be_nil }
      end
    end
  end
end