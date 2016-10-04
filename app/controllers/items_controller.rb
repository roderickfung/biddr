class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show]

  LIMIT = 20

  def new
    @item = Item.new
  end

  def create
    @item = Item.new item_params
    @item.user_id = current_user.id
    if @item.save
      redirect_to items_path, notice: 'New Auction Item Created'
    else
      flash.now.alert = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    @items = Item.order(created_at: :desc).page(params[:page]).per(LIMIT)
  end

  def show
    @bids = @item.bids
    @bid = Bid.new
  end

  protected

  def item_params
    params.require(:item).permit(:name, :description, :end_date, :reserve_price)
  end

  def find_item
    @item = Item.find params[:id]
  end
end
