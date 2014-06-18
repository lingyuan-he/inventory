class RestocksController < ApplicationController

  def index
    @restocks = Restock.all
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
    if @restock.update_attributes(params[:restock])
      redirect_to @restock
    else
      render 'edit'
    end
  end

  def destroy
    @restock = Restock.find(params[:id])
    @restock.destroy
    redirect_to restocks_path
  end

end
