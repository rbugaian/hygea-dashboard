class TasksController < ApplicationController

	def show_task
		logger.debug "SHOWING TASK WITH PARAMS: " + task_params.inspect

		@task = Task.find_by(id: task_params[:id])

		doctor = Doctor.find_by(id: @task.doctor_id)
		logger.debug "DOCTOR: " + doctor.inspect.to_s
		@doctor_name = doctor.first_name.to_s + ' ' + doctor.last_name.to_s

		personnel = Doctor.find_by(id: @task.personnel_id)
		logger.debug "PERSONNEL: " + personnel.inspect.to_s
		@personnel_name = personnel.name
	end

	def edit_task
		@task_to_edit = Task.find_by(id: task_params[:id])

		logger.debug "TASK TO EDIT: " + @task_to_edit.inspect
	end

	def edit
		task = Task.find_by(id: task_params[:id])

		if (params.has_key?(:date_to_execute)) 
			start_date = Time.zone.local(*params[:date_to_execute].sort.map(&:last).map(&:to_i)) 
			logger.debug "DATE TO SET: " + start_date.inspect
			task_params.store(:date_to_execute, start_date)
			task.date_to_execute = start_date
		end

		if task.update(task_params)
			redirect_to :controller => 'tasks', :action => 'show_task', :id => task.id
		end
	end

	def submit 
		logger.debug "TASK CREATE PARAMS: " + params.inspect

	    task = current_doctor.tasks.build(task_params)
	    task.status = 0

	    if (params.has_key?(:date_to_execute)) 
			start_date = Time.zone.local(*params[:date_to_execute].sort.map(&:last).map(&:to_i)) 
			logger.debug "DATE TO SET: " + start_date.inspect
			task_params.store(:date_to_execute, start_date)
			task.date_to_execute = start_date
		end

	    logger.debug 'Task params: ' + task_params.inspect

	    if task.save  
	      redirect_to root_path
	    else
	      render json: { errors: task.errors }, status: 422
	    end
	end

	private

	def task_params
		received_hash = params.permit(:id, :title, :status, :personnel_id, :date_to_execute, :patient_id)

		if params.has_key? 'description'
			received_hash.store(:description, params['description'].join(","))
		end

		received_hash.with_indifferent_access
	end

end
