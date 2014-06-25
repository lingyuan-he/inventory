class Stock < ActiveRecord::Base
  belongs_to :location
  belongs_to :product
  validates :product_id, presence: true
  validates_uniqueness_of :product_id, :scope => :location_id, :message => "and location combination already exist"
  validates :location_id, presence: true
  validates :quantity_left, :numericality => { :greater_than_or_equal_to => 0 }
  validates :alarm_threshold, :numericality => { :greater_than_or_equal_to => 0 }
  validates :active, :inclusion => {:in => [true, false]}
end
