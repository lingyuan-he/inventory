class Manufacturer < ActiveRecord::Base
  has_many :product, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
  validates :contact_email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :contact_phone, presence: true
end
