class Manufacturer < ActiveRecord::Base
  has_many :product
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :address, presence: true
  validates :contact_email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :contact_phone, presence: true
end
