class Employee < ActiveRecord::Base
  has_one :location
  belongs_to :transfer
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :name, presence: true
  validates :role, presence: true
  validates :phone, presence: true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => "format invalid, example: jdoe@vengolabs.com" }
end
