class Location < ActiveRecord::Base
  belongs_to :employee
  belongs_to :stock
  belongs_to :restock
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :name, presence: true
  validates :address, presence: true
  validates :manager_id, presence: true
end
