require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) {FactoryGirl.create :user}

  describe "#new" do
    before { request.session[:user_id] = user.id}

    it 'renders a new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'instantiates a new item instance variable' do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
    end

  end

  describe '#create' do
    before { request.session[:user_id] = user.id}

    def valid_request
      post :create, params: { item: {
                              name: 'Auction Item Name',
                              description: 'Item Description',
                              end_date: Time.now + 7.days,
                              reserve_price: rand(1..50)
      }}
    end

    context 'with valid parameters' do
      it 'saves a record to the database' do
        count_before = Item.count
        valid_request
        count_after = Item.count
        expect(count_after).to eq(count_before +1)
      end

      it 'redirects to the item index page' do
        valid_request
        expect(response).to redirect_to(items_path)
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context 'with invalid parameters' do
      def invalid_request
        post :create, params: {item: {name: ''}}
      end

      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "doesn't save the record to the database" do
        count_before = Item.count
        invalid_request
        count_after = Item.count
        expect(count_after).to eq(count_before)
      end
    end

  end
end
