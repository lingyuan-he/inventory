class ManagersController < ApplicationController

  def index
    @managers = Manager.all
  end

  def new
    @manager = Manager.new
  end

  def show
    @manager = Manager.find(params[:id])
  end

  def create
    @manager = Manager.new(params[:manager])
    if @manager.save
      redirect_to @manager
    else
      render 'new'
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update_attributes(params[:manager])
      redirect_to @manager
    else
      render 'edit'
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy
    redirect_to managers_path
  end

end
