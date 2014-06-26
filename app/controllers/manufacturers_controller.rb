class ManufacturersController < ApplicationController

  def index
    @manufacturers = Manufacturer.order(:name)
  end
  
	def new
		@manufacturer = Manufacturer.new
	end
	
	def show
		@manufacturer = Manufacturer.find(params[:id])
	end
	
  def create
    @manufacturer = Manufacturer.new(params[:manufacturer])
    if @manufacturer.save
      redirect_to @manufacturer
    else
      render 'new'
    end
  end
  
  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(params[:manufacturer])
      redirect_to @manufacturer
    else
      render 'edit'
    end
  end

  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.destroy
      redirect_to manufacturers_path
    else
      flash[:alert] = 'The manufacturer you want to destroy is used as a reference!'
      redirect_to manufacturers_path
    end
  end
  
end
