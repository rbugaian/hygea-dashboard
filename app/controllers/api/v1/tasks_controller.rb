class Api::V1::TasksController < ApplicationController
  before_action :authenticate_doctor_with_token!, only: [:update, :destroy]
  respond_to :json

  def index
    #respond_with Task.all

    # tasks = params[:task_ids].present? ? Task.find(params[:task_ids]) : Task.all
    # respond_with tasks

    respond_with Task.search(params)
  end

  def list
    doctor = current_doctor
    if doctor
      task_list = current_doctor.tasks

      if task_list
        render json: task_list.as_json(:only => [:id, :title, :date_to_execute, :date_to_execute, :created_at] ), status: 201
      end
    else
      render json: { errors: 'Wrong auth token' }, status: :unauthorized
    end
  end

  def show
    # respond_with Task.find(params[:id])

    if current_doctor
      fetched_task = current_doctor.tasks.find_by(id: params[:id])
      if fetched_task
        render json: fetched_task, status: 201
      else 
        render json: { errors: 'Task with such id not found' }, status: 404
      end
    else
        render json: { errors: 'Wrong auth token' }, status: :unauthorized
    end
  end

  def create
    logger.debug 'Sessions Params: ' + current_doctor.inspect

    if current_doctor
      task = current_doctor.tasks.build(task_params)

      logger.debug 'Task params: ' + task.inspect

      if task.save
        # USING THIS TYPE OF OUTPUT BECAUSE USING SERIALIZERS CAUSES STACK OVERFLOW
        render json: task.as_json(:only => [:id, :title, :description, :personnel_id, :patient_id, :date_to_execute] ), status: 201, location: [:api, task]
      else
        render json: { errors: task.errors }, status: 422
      end
    else
      render json: { errors: 'Wrong auth token' }, status: :unauthorized
    end

    
  end

  def update
    if current_doctor
      task = current_doctor.tasks.find(params[:id])
      if task.update(task_params)
        render json: task.as_json(:only => [:id, :title, :description, :personnel_id, :patient_id, :date_to_execute] ), status: 201, location: [:api, task]
      else
        render json: { errors: task.errors }, status: 422
      end
    else
      render json: { errors: 'Wrong auth token' }, status: :unauthorized
    end
  end

  def destroy
    task = current_doctor.tasks.find(params[:id])
    task.destroy
    head 204
  end

  private

  def task_params
    params.permit(:id, :title, :description, :personnel_id, :patient_id, :date_to_execute, :status )
  end
end
