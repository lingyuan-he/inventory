class Restock < ActiveRecord::Base
  has_one :product
  has_one :location
  has_one :employee
  validates :quantity, :numericality => { :greater_than => 0 }, presence: true
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
end
