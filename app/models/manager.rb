class Manager < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
