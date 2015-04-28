class PatientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :idno, :blood_type,:ward_room
  #has_one :ward
end
