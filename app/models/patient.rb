class Patient < ActiveRecord::Base
  belongs_to :doctors
  # belongs_to :personnels
  belongs_to :ward

  has_many :tasks
  
  def name
    self.first_name.to_s + ' ' + self.last_name.to_s
  end

  def ward_room
    fetched_ward = Ward.all.find_by(id: self.ward_id)
    result = { :id => fetched_ward.id, :room_number => fetched_ward.room_number}
  end
  
  def blood_type_label
    case self.blood_type
    when 1
      'Type I'
      
    when 2
      'Type II'
      
    when 3
      'Type III'
      
    when 4
      'Type IV'
      
    else
      'Undefined'
    end
  end
end
