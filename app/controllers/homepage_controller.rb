class HomepageController < ApplicationController

  def index
    @stocks = Stock.joins(:location, :product).includes(:location, :product).order("t1_r1").order("t2_r1").where("stocks.quantity_left <= stocks.alarm_threshold and stocks.active = true")
    @restocks = Restock.order("created_at DESC").limit(10)
    @transfers = Transfer.order("created_at DESC").limit(10)
    @purchases = Purchase.order("created_at DESC").limit(10)
  end

end
