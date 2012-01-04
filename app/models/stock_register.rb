class StockRegister
  include DataMapper::Resource
  before :save, :convert_blank_to_nil
  
  property :id,               Serial
  property :name,             String,    :length => 100,  :required => false,  :index => true
  property :stock_code,       String,    :length => 10,   :required => true,  :index => true
  property :stock_name,       String,    :length => 100,  :required => false,   :index => true
  property :stock_quantity,   Integer,                    :required => false
  property :bill_number,      String,                     :required => true,  :index => true
  property :bill_date,        Date,                       :required => true
  property :date_of_entry,    Date,      :default => Date.today, :required => true
  property :branch_name,      String,    :required => false,     :index => true
  property :branch_id,        Integer,   :required => true,    :index => true


  belongs_to  :manager,  :child_key => [:manager_staff_id],  :model => 'StaffMember'
  belongs_to  :branch,   :child_key => [:branch_id],         :model => 'Branch'

  validates_present       :manager
  validates_with_method   :manager,   :manager_is_an_active_staff_member?
  
  private
  def manager_is_an_active_staff_member?
    return true if manager and manager.active
    [false, "Managing staff member is currently not active"]
  end
  
  def convert_blank_to_nil
    self.attributes.each{|k, v|
      if v.is_a?(String) and v.empty? and self.class.properties.find{|x| x.name == k}.type==Integer
        self.send("#{k}=", nil)
      end
    }
  end
  
end
