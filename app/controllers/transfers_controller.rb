class TransfersController < ApplicationController

  def index
    @transfers = Transfer.all
  end
  
  def new
    @transfer = Transfer.new
  end
  
  def show
    @transfer = Transfer.find(params[:id])
  end
  
  def create
    @transfer = Transfer.new(params[:transfer])
    if @transfer.save
    #change stock quantity of the locations involved in transfer
      @stock_out = Stock.find_by_location_id_and_product_id(@transfer.from_location_id, @transfer.product_id)
      @stock_in = Stock.find_by_location_id_and_product_id(@transfer.to_location_id, @transfer.product_id)
      @stock_out.update_attribute(:quantity_left, @stock_out.quantity_left - @transfer.quantity)
      @stock_in.update_attribute(:quantity_left, @stock_in.quantity_left + @transfer.quantity)
      redirect_to @transfer
    else
      render 'new'
    end
  end
  
  def edit
    @transfer = Transfer.find(params[:id])
  end

  def update
    @transfer = Transfer.find(params[:id])
    @stock_out = Stock.find_by_location_id_and_product_id(@transfer.from_location_id, @transfer.product_id)
    @stock_in = Stock.find_by_location_id_and_product_id(@transfer.to_location_id, @transfer.product_id)
    #rollback quantity changes on stock
    @stock_out.update_attribute(:quantity_left, @stock_out.quantity_left + @transfer.quantity)
    @stock_in.update_attribute(:quantity_left, @stock_in.quantity_left - @transfer.quantity)
    if @transfer.update_attributes(params[:transfer])
      #apply new changes on stock
      @stock_out.update_attribute(:quantity_left, @stock_out.quantity_left - @transfer.quantity)
      @stock_in.update_attribute(:quantity_left, @stock_in.quantity_left + @transfer.quantity)
      redirect_to @transfer
    else
      #restore values when action failed
      @stock_out.update_attribute(:quantity_left, @stock_out.quantity_left - @transfer.quantity)
      @stock_in.update_attribute(:quantity_left, @stock_in.quantity_left + @transfer.quantity)
      render 'edit'
    end
  end

  def destroy
    @transfer = Transfer.find(params[:id])
    @stock_out = Stock.find_by_location_id_and_product_id(@transfer.from_location_id, @transfer.product_id)
    @stock_in = Stock.find_by_location_id_and_product_id(@transfer.to_location_id, @transfer.product_id)
    #rollback quantity changes on stock
    @stock_out.update_attribute(:quantity_left, @stock_out.quantity_left + @transfer.quantity)
    @stock_in.update_attribute(:quantity_left, @stock_in.quantity_left - @transfer.quantity)
    @transfer.destroy
    redirect_to transfers_path
  end

end
