class Purchase < ActiveRecord::Base
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, :reject_if => lambda { |a| a[:quantity].blank? }, :allow_destroy => true
  validates :invoice_number, presence: true
  validates :vending_machine, presence: true
  validates :total_amount, presence: true, :numericality => { :greater_than => 0 }
end
