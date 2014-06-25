class VendingMachine < ActiveRecord::Base
  belongs_to :location
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :address, presence: true
  validates :stock_location_id, presence: true
end
