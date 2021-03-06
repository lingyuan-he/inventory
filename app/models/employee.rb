class Employee < ActiveRecord::Base
  has_many :locations
  has_many :restocks
  has_many :transfers
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :name, presence: true
  validates :role, presence: true
  validates :phone, presence: true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => "format invalid, example: jdoe@vengolabs.com" }
  before_destroy :employee_used?
  
  def employee_used?
    @restocks = Restock.where("restock_staff_id = ?", self.id)
    @transfers = Transfer.where("transfer_staff_id = ?", self.id)
    @locations = Location.where("manager_id = ?", self.id)
    if @restocks.empty? == false or @transfers.empty? == false or @locations.empty? == false
      return false
    end
    return true
  end
end
