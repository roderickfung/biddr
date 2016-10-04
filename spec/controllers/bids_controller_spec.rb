require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:item) {FactoryGirl.create :item}
  let(:user) {FactoryGirl.create :user}
  let(:bid) {FactoryGirl.create :bid}

  describe '#create' do
    context 'with signed in user' do
      before {request.session[:user_id] = user.id}
      context 'valid attributes' do
        def valid_request
          post :create, params: { bid: {price: 20}, item_id: item.id, user_id: user.id}
        end

        it 'creates a bid in the database' do
          count_before = Bid.count
          valid_request
          count_after = Bid.count
          expect(count_after).to eq(count_before+1)
        end

        it 'redirect to the item show page' do
          valid_request
          expect(response).to redirect_to item_path(item)
        end

        it 'associate the created Bid with the logged in user' do
          valid_request
          expect(Bid.last.user).to eq(user)
        end

        it 'associate the created Bid with the item' do
          valid_request
          expect(Bid.last.item).to eq(item)
        end

      end
    end
  end

end
