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
    @stocks = Stock.where("stocks.location_id = ?", params[:id])
    @restocks = Restock.where("restocks.location_id = ?", params[:id]).order("created_at DESC")
    @transfers = Transfer.where("transfers.from_location_id = ? or transfers.to_location_id = ?", params[:id], params[:id]).order("created_at DESC")
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
  
  def report
    @location = Location.find(params[:id])
		@manager = Employee.find(@location.manager_id).name
    @stocks = Stock.where("stocks.location_id = ?", params[:id])
    @restocks = Restock.where("restocks.location_id = ?", params[:id]).order("created_at DESC")
    @transfers = Transfer.where("transfers.from_location_id = ? or transfers.to_location_id = ?", params[:id], params[:id]).order("created_at DESC")
		@time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    render :pdf => @location.name.gsub(' ','_') + '_' + Time.now.strftime("%Y%m%d"),
      :template => 'locations/report.pdf.erb',
      :footer => {
        :center => '[page] of [topage]',
        :left => @location.name,
        :right => @time
      }
  end

end
