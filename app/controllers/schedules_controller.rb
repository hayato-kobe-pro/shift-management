class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
    @schedule = Schedule.find_or_create_by(:user_id => current_user.id)
    redirect_to edit_schedule_url(@schedule)
  end

  # GET /schedules/1/edit
  def edit
    @rooms = Room.all
    id = Profile.find_by(:user_id => current_user.id)
    @room_id = Relation.find_by(user_id: id.user_id)
    user = Profile.find_by(:user_id => current_user.id)
    if @schedule.user_id != user.user_id
      raise ActionController::RoutingError.new("Not authorized")
    end
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json


  def update
    @relation = Relation.new
    if params[:room_ids][0].nil?
        params[:schedule]["room_id"] = params[:room_ids][0]
    end
    respond_to do |format|
      if @room.update(schedule_params)
        format.html { redirect_to @schedule, notice: "schedule was successfully updated." }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end





  
  def update
    @relation = Relation.new
    params[:schedule]["room_id"] = params[:room_ids][0]
    @schedule.update(schedule_params)

  
    respond_to do |format|
      if !params[:room_ids].nil? 
        room_id = params[:room_ids][0]
        user_id = params[:schedule][:user_id]
        if !Relation.find_by(user_id: user_id).nil? 
          Relation.find_by(user_id).destroy
        end
        @relation.update({ "room_id" => room_id, "user_id" => user_id })
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { redirect_to edit_schedule_url(@schedule) }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:start_time, :end_time, :user_id, :room_id, :clone_id)
    end
end





