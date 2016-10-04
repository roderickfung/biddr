class BidsController < ApplicationController

  def create
    @item = Item.find params[:item_id]
    @bid = Bid.new params.require(:bid).permit(:price)
    @bid.item = @item
    @bid.user = current_user

    if @bid.user == @item.user
      flash.now.alert = 'Cannot bid on your own items.'
      redirect_to item_path(@item)
    elsif @bid.save
      redirect_to item_path(@item), notice: 'Bid placed'
    end
  end
end
