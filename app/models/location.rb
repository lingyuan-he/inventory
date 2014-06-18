class Location < ActiveRecord::Base
  belongs_to :employee
  validates :name, presence: true
  validates :address, presence: true
end
