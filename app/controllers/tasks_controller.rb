class TasksController < ApplicationController
  def index
    if @current_user
      @tasks = Task.all
      @task = Task.new
    end
  end

  def create
    if @current_user
      @task = Task.new
      @task["description"] = params["task"]["description"]
      @task.save
      redirect_to "/tasks"
    end
  end

  def destroy
    if @current_user
      @task = Task.find_by({ "id" => params["id"] })
      @task.destroy
      redirect_to "/tasks"
    end
  end
end
