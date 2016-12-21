class TasksController < ApplicationController
  before_action :authorize
  after_action :broadcast, only: [:create, :update, :update_all, :destroy, :remove_completed]

  def index
    @task = Task.new
  end

  def create
    @task = current_list.tasks.build(task_params)
    render(:new) && return unless @task.save
  end

  def update
    @task = current_list.tasks.find(params[:id])
    render(:edit) && return unless @task.update(task_params)
  end

  def edit
    @task = current_list.tasks.find(params[:id])
  end

  def update_all
    current_list.tasks.update_all(done: params[:done].present?)
  end

  def destroy
    @task = current_list.tasks.find(params[:id])
    @task.destroy
  end

  def remove_completed
    current_list.tasks.where(done: true).delete_all
  end

  private

  def task_params
    params.fetch(:task).permit(:title, :done)
  end

  def tasks
    @tasks ||= current_list.tasks.filtered(params[:type]).order("#{sort_column} #{sort_direction}")
  end
  helper_method :tasks

  def broadcast
    ActionCable.server.broadcast("lists_channel_#{current_list.id}", user: current_user.id, action: render_to_string(params[:action]))
  end

  def sortable_columns
    %w(title created_at)
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'created_at'
  end
  helper_method :sort_column

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'desc'
  end
  helper_method :sort_direction
end
