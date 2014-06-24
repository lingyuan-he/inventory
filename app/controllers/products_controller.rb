class ProductsController < ApplicationController

	def index
		@products = Product.all
	end
	
	def new
		@product = Product.new
		@manufacturers = Manufacturer.all
	end
	
	def show
		@product = Product.find(params[:id])
		@manufacturer = Manufacturer.find(@product.manufacturer).name
	end
	
  def create
    @product = Product.new(params[:product])
    if @product.save
      #defaul 0 value for quantity left
      @product.update_attribute(:quantity_left, 0)
      redirect_to @product
    else
      render 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])   
    if @product.update_attributes(params[:product])
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

end
