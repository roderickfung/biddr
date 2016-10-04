class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :publish]

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
    @items = Item.where.not(aasm_state: ['draft', 'won', 'canceled']).order(created_at: :desc).page(params[:page]).per(LIMIT)
  end

  def show
    @bids = @item.bids.order(created_at: :desc)
    @bid = Bid.new
  end

  def publish
    if @item.draft?
      @item.publish!
      redirect_to item_path(@item), notice: 'Auction Item Published'
    end
  end

  protected

  def item_params
    params.require(:item).permit(:name, :description, :end_date, :reserve_price)
  end

  def find_item
    @item = Item.find params[:id]
  end
end
