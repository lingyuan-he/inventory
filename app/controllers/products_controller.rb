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
		@manufacture = Manufacturer.find(@product.manufacturer).name
	end
	
  def create
    @product = Product.new(params[:product])
    if @product.save
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
    if @product.save(params[:product])
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @prodcut = Product.find(params[:id])
    @product.destroy
    redirect_to product_path
  end
  
end
