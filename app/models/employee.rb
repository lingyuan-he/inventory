class Employee < ActiveRecord::Base
  has_one :location
  validates :name, presence: true
  validates :role, presence: true
  validates :phone, presence: true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end