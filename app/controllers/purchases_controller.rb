class PurchasesController < ApplicationController

  def index
    @purchases = Purchase.order("created_at DESC")
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
    if @purchase.save
      @purchase.items.each do |item|
        @product = Product.find(item.product_id) 
        @total = @total + item.quantity * @product.unit_price #calculate total amount
        #apply quantity changes to product
        @product.update_attribute(:quantity_left, @product.quantity_left - item.quantity)
        @product.update_attribute(:quantity_sold, @product.quantity_sold + item.quantity)
        #apply quantity change to stock
        @stock = Stock.find_by_location_id_and_product_id(VendingMachine.find(@purchase.vending_machine_id).stock_location_id, item.product_id)
        @stock.update_attribute(:quantity_left, @stock.quantity_left - item.quantity)
      end
      @purchase.update_attribute(:total_amount, @total)
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
    @purchase.items.each do |item|
      #rollback quantity changes on product
      @product = Product.find(item.product_id)
      @product.update_attribute(:quantity_left, @product.quantity_left + item.quantity)
      @product.update_attribute(:quantity_sold, @product.quantity_sold - item.quantity)
      #rollback quantity changes on stock
      @stock = Stock.find_by_location_id_and_product_id(VendingMachine.find(@purchase.vending_machine_id).stock_location_id, item.product_id)
      @stock.update_attribute(:quantity_left, @stock.quantity_left + item.quantity)
    end
    if @purchase.update_attributes(params[:purchase])
      @total = 0
      @purchase.items.each do |item|
        #update quantity changes on stock
        @product = Product.find(item.product_id)
        @product.update_attribute(:quantity_left, @product.quantity_left - item.quantity)
        @product.update_attribute(:quantity_sold, @product.quantity_sold + item.quantity)
        #update quantity changes on stock
        @stock = Stock.find_by_location_id_and_product_id(VendingMachine.find(@purchase.vending_machine_id).stock_location_id, item.product_id)
        @stock.update_attribute(:quantity_left, @stock.quantity_left - item.quantity)
        #calculate new total amount
        @total = @total + item.quantity * @product.unit_price 
      end
      @purchase.update_attribute(:total_amount,@total)
      redirect_to @purchase
    else
      #recover changes
      @product.update_attribute(:quantity_left, @product.quantity_left - item.quantity)
      @product.update_attribute(:quantity_sold, @product.quantity_sold + item.quantity)
      @stock.update_attribute(:quantity_left, @stock.quantity_left - item.quantity)
      render 'edit'
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.items.each do |item|
      #rollback quantity changes on product
      @product = Product.find(item.product_id)
      @product.update_attribute(:quantity_left, @product.quantity_left + item.quantity)
      @product.update_attribute(:quantity_sold, @product.quantity_sold - item.quantity)
      #rollback quantity changes on stock
      @stock = Stock.find_by_location_id_and_product_id(VendingMachine.find(@purchase.vending_machine_id).stock_location_id, item.product_id)
      @stock.update_attribute(:quantity_left, @stock.quantity_left + item.quantity)
    end
    @purchase.destroy
    redirect_to purchases_path
  end

end
