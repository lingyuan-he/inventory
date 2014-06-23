class PurchasesController < ApplicationController

  def index
    @purchases = Purchase.all
  end
  
  def new
    @purchase = Purchase.new
    2.times { @purchase.items.build }
  end
  
  def show
    @purchase = Purchase.find(params[:id])
    @items = Item.find(:all, :conditions => { :purchase_id => @purchase.id })
  end
  
  def create
    @purchase = Purchase.new(params[:purchase])
    @total = 0
    @purchase.items.each do |item|
      @unit_price = Product.find(item.product_id).unit_price
      @total = @total + item.quantity * @unit_price
    end
    @purchase.total_amount = @total
    if @purchase.save
      redirect_to @purchase
    else
      render 'new'
    end
  end
  
  def edit
    @purchase = Purchase.find(params[:id])
    @purchase.items.build
  end

  def update
    @purchase = Purchase.find(params[:id])  
    if @purchase.update_attributes(params[:purchase])
      @total = 0
      @purchase.items.each do |item|
        @unit_price = Product.find(item.product_id).unit_price
        @total = @total + item.quantity * @unit_price
      end
      @purchase.update_attribute(:total_amount,@total)
      redirect_to @purchase
    else
      render 'edit'
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy
    redirect_to purchases_path
  end

end
