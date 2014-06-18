class Location < ActiveRecord::Base
  belongs_to :employee
  belongs_to :stock
  belongs_to :restock
  validates :name, presence: true
  validates :address, presence: true
end
