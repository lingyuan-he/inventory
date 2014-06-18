class StocksController < ApplicationController

  def index
    @stocks = Stock.all
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
    if @stock.update_attributes(params[:stock])
      redirect_to @stock
    else
      render 'edit'
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    redirect_to stocks_path
  end

end
