class WardSerializer < ActiveModel::Serializer
  attributes :id
  has_many :patient
end
