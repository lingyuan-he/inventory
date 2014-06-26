class LocationsController < ApplicationController

  def index
    @locations = Location.order(:name)
  end
  
	def new
		@location = Location.new
		@employees = Employee.all
	end
	
	def show
		@location = Location.find(params[:id])
		@manager = Employee.find(@location.manager_id).name
	end
	
  def create
    @location = Location.new(params[:location])
    if @location.save
      redirect_to @location
    else
      render 'new'
    end
  end
  
  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])   
    if @location.update_attributes(params[:location])
      redirect_to @location
    else
      render 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      redirect_to locations_path
    else
      flash[:alert] = 'The location you want to destroy is used as a reference!'
      redirect_to locations_path
    end
  end

end
