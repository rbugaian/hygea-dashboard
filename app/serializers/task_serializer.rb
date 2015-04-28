class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :created_at, :date_to_execute, :doctor, :patient
  # has_one :doctor
end
