class Purchase < ActiveRecord::Base
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, :reject_if => lambda { |a| a[:quantity].blank? }, :allow_destroy => true
  validates :invoice_number, presence: true
  validates_uniqueness_of :invoice_number, :message => "already exists in the database"
  validates :vending_machine_id, presence: true
  validates :total_amount, :numericality => { :greater_than => 0 }
end
