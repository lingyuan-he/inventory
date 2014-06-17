class Location < ActiveRecord::Base
  belongs_to :manager
  validates :name, presence: true
  validates :address, presence: true
end
