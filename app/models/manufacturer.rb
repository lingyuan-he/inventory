class Manufacturer < ActiveRecord::Base
  has_many :products
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :address, presence: true
  validates :contact_email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :contact_phone, presence: true
  before_destroy :manufacturer_used?
  
  def manufacturer_used?
    @products = Product.where("manufacturer_id = ?", self.id)
    if @products.empty? == false
      return false
    end
    return true
  end
end
