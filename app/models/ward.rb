class Ward < ActiveRecord::Base
  has_many :patients

  def caption
  	'Room: ' + self.room_number.to_s
  end

  def caption_plus_capacity
  	caption + " Capacity: " + self.capacity.to_s
  end

  def full_info
  	free_space = self.capacity - self.patients.all.count
  	caption_plus_capacity + " Free: " + free_space.to_s
  end
end
