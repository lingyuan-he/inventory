class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :item
  validates :name, presence: true
  validates :quantity_sold, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validates :quantity_left, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validates :archieved, :inclusion => {:in => [true, false]}
end
