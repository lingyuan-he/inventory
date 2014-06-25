class Location < ActiveRecord::Base
  belongs_to :employee
  has_many :stock
  has_many :restock
  has_many :transfer
  has_many :vending_machine
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :name, presence: true
  validates :address, presence: true
  validates :manager_id, presence: true
end
