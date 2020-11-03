class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    this_day = Date.today
    this_monday = this_day - (this_day.wday - 1) # 今週の月曜日
    
    @date = []
    for num in 1..3 do
     @date.push(this_monday)
     this_monday = this_monday.since(2.days)
    end

    this_monday = this_day - (this_day.wday - 1) # 今週の月曜日 
 
     @users = User.joins(:schedule).select('users.name,schedules.*').where(schedules: { room_id: params[:id] }).where('start_time LIKE ?', "%#{this_monday}%")
    
      @names = Schedule.joins(:user).select('users.name,schedules.*').where(schedules: { room_id: params[:id] }).distinct.pluck(:name)

    # @schedules = Schedule.where('start_time LIKE ?', "%#{this_monday}%")


    
  #   @users.each do |user|
  #     user.start_time = Time.parse(user.start_time).hour 
  #     print("===========")
  #     print(user.name)
  # end

  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:room_id, :name)
  end
end





