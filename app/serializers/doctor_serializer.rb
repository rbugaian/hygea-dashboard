class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :auth_token
  has_many :tasks
end
