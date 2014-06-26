class VendingMachinesController < ApplicationController

  def index
    @vms = VendingMachine.order(:name)
  end
  
	def new
		@vm = VendingMachine.new
	end
	
	def show
		@vm = VendingMachine.find(params[:id])
		@location = Location.find(@vm.stock_location_id).name
	end
	
  def create
    @vm = VendingMachine.new(params[:vending_machine])
    if @vm.save
      redirect_to @vm
    else
      render 'new'
    end
  end
  
  def edit
    @vm = VendingMachine.find(params[:id])
  end

  def update
    @vm = VendingMachine.find(params[:id])   
    if @vm.update_attributes(params[:vending_machine])
      redirect_to @vm
    else
      render 'edit'
    end
  end

  def destroy
    @vm = VendingMachine.find(params[:id])
    if @vm.destroy
      redirect_to vending_machines_path
    else
      flash[:alert] = 'The vending machine you want to destroy is referenced in purchase!'
      redirect_to vending_machines_path
    end
  end

end
