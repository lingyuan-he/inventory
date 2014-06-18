class Stock < ActiveRecord::Base
  has_one :location
  validates :quantity_left, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validates :alarm_threshold, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
end
