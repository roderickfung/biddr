class BidsController < ApplicationController

  def create
    @item = Item.find params[:item_id]
    @bid = Bid.new params.require(:bid).permit(:price)
    @bid.item = @item
    @bid.user = current_user

    if @bid.user == @item.user
      redirect_to item_path(@item), alert: 'Cannot bid on your own items.'
    elsif @bid.price <= @item.current_price
      redirect_to item_path(@item), alert: 'Bid must be higher than current price'
    elsif @bid.save
      @item.update_attribute(:current_price, @bid.price)
      state_change()
      redirect_to item_path(@item), notice: "You have made a bit on #{@item.name.titleize}"
    end

  end

  protected

  def state_change
    if @item.published? && @bid.price >= @item.reserve_price
      @item.reserve_met!
    elsif @item.published? && @bid.price < @item.reserve_price
      @item.reserve_unmet!
    elsif @item.reserve_not_met? && @bid.price > @item.reserve_price
      @item.reserve_met!
    end
  end

end
