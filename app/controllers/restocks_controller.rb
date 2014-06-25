class RestocksController < ApplicationController

  def index
    @restocks = Restock.order("created_at DESC")
  end
  
	def new
		@restock = Restock.new
	end
	
	def show
		@restock = Restock.find(params[:id])
		@product = Product.find(@restock.product_id).name
		@location = Location.find(@restock.location_id).name
		@staff = Employee.find(@restock.restock_staff_id).name
	end
	
  def create
    @restock = Restock.new(params[:restock])
    if @restock.save
      #apply quantity changes for stock and product
      @stock = Stock.find_by_product_id_and_location_id(@restock.product_id, @restock.location_id)
      @stock.update_attribute(:quantity_left, @stock.quantity_left + @restock.quantity)
      @product = Product.find(@restock.product_id)
      @product.update_attribute(:quantity_left, @product.quantity_left + @restock.quantity)
      redirect_to @restock
    else
      render 'new'
    end
  end
  
  def edit
    @restock = Restock.find(params[:id])
  end

  def update
    @restock = Restock.find(params[:id])
    #update quantity changes for stock and product
    @stock = Stock.find_by_product_id_and_location_id(@restock.product_id,@restock.location_id)
    @new_stock_quantity = @stock.quantity_left - @restock.quantity + params[:restock][:quantity].to_i
    @product = Product.find(@restock.product_id)
    @new_product_quantity = @product.quantity_left - @restock.quantity + params[:restock][:quantity].to_i
    if @restock.update_attributes(params[:restock])
      @stock.update_attribute(:quantity_left, @new_stock_quantity)
      @product.update_attribute(:quantity_left, @new_product_quantity)
      redirect_to @restock
    else
      render 'edit'
    end
  end

  def destroy
    @restock = Restock.find(params[:id])
    #remove quantity changes for stock and product
    @stock = Stock.find_by_product_id_and_location_id(@restock.product_id,@restock.location_id)
    @product = Product.find(@restock.product_id)
    @stock.update_attribute(:quantity_left, @stock.quantity_left - @restock.quantity)
    @product.update_attribute(:quantity_left, @product.quantity_left - @restock.quantity)
    @restock.destroy
    redirect_to restocks_path
  end

end
