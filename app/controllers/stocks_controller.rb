class StocksController < ApplicationController

  def index
    @stocks = Stock.joins(:location, :product).includes(:location, :product).order("t1_r1").order("t2_r1")
  end
  
	def new
		@stock = Stock.new
	end
	
	def show
		@stock = Stock.find(params[:id])
		@product = Product.find(@stock.product_id).name
		@location = Location.find(@stock.location_id).name
	end
	
  def create
    @stock = Stock.new(params[:stock])
    if @stock.save
      @product = Product.find(@stock.product_id)
      @product.update_attribute(:quantity_left, @product.quantity_left + @stock.quantity_left)
      redirect_to @stock
    else
      render 'new'
    end
  end
  
  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    @product = Product.find(@stock.product_id)
    @new_product_quantity = @product.quantity_left - @stock.quantity_left + params[:stock][:quantity_left].to_i
    if @stock.update_attributes(params[:stock])
      @product.update_attribute(:quantity_left, @new_product_quantity)
      redirect_to @stock
    else
      render 'edit'
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @product = Product.find(@stock.product_id)
    @product.update_attribute(:quantity_left, @product.quantity_left - @stock.quantity_left)
    @stock.destroy
    redirect_to stocks_path
  end

end
