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
    id = Profile.find_by(:user_id => current_user.id).id
    @schedule = Schedule.new({"user_id" => id})
    @rooms = Room.all
  end

  # GET /schedules/1/edit
  def edit
    @rooms = Room.all
    @user = Schedule.find_by(:user_id => current_user.id)
    user = Profile.find_by(:user_id => current_user.id)
    if @schedule.user_id != user.user_id
      raise ActionController::RoutingError.new("Not authorized")
    end
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule["room_id"] = params[:room_ids][0]
    # ここからfor文を回して複数個のレコードの作成を行う
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
    params[:schedule]["room_id"] = params[:room_ids][0]
    print(@schedule.start_time.since(7.days))
    respond_to do |format|
      if !params[:room_ids].nil? 
        @schedule.update(schedule_params)
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
      params.require(:schedule).permit(:start_time,:user_id, :room_id, :clone_id)
    end
end





