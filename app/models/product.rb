class Product < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :item
  has_many :stock
  has_many :restock
  has_many :transfer
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :manufacturer_id, presence: true
  validates :unit_price, :numericality => { :greater_than => 0 }
  validates :quantity_sold, :numericality => { :greater_than_or_equal_to => 0 }
end

