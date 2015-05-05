class Task < ActiveRecord::Base
  validates :title, :doctor_id, presence: true
  after_initialize :defaults

  belongs_to :doctor
  # belongs_to :personnel 
  belongs_to :patient

  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%")
  }

  scope :recent, -> {
    order(:date_to_execute)
  }

  def defaults
    self.was_shown = false if self.was_shown.nil?
  end

  def self.search(params = {})

    logger.debug 'Task params: ' + params.inspect

    tasks = params[:task_ids].present? ? Task.find(params[:task_ids]) : Task.all

    tasks = tasks.filter_by_title(params[:keyword]) if params[:keyword]

    tasks = tasks.recent(params[:recent]) if params[:recent].present?
  end

  def patient_name
    fetched_patient = Patient.find_by(id: self.patient_id)
    result = fetched_patient.first_name + ' ' + fetched_patient.last_name
  end

  def doctor
    fetched_doctor = Doctor.find_by(id: self.doctor_id)
    result = { :id => fetched_doctor.id, :first_name => fetched_doctor.first_name, :last_name => fetched_doctor.last_name }
  end

  def patient
    fetched_patient = Patient.find_by(id: self.patient_id)
    result = { :id => fetched_patient.id, :first_name => fetched_patient.first_name, :last_name => fetched_patient.last_name}
  end

  def get_unix_time
    
    time_string = self.date_to_execute.strftime("%s")
    time_string.to_i * 1000
  end



  def should_execute

    time_of_execution = self.date_to_execute.utc.strftime("%s").to_i

    moment = Time.now

    current_time = moment.localtime.to_i

    logger.debug "Time of execution: " + time_of_execution.to_s + " Current_time: " + current_time.to_s

    if ((time_of_execution > current_time - 600) && (time_of_execution < current_time + 600) && (self.status == 0))
      logger.debug 'TASK is READY'
      true
    else
      logger.debug 'TASK IS NOT READY'
      false
    end
  end

  def self.STATUS_UNDEFINED
    0
  end

  def self.STATUS_INITIALIZED
    1
  end

  def self.STATUS_STARTED
    2
  end

  def self.STATUS_IN_PROGRESS
    3
  end

  def self.STATUS_FINISHED
    4
  end


end
