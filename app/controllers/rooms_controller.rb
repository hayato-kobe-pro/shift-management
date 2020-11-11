class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    today = DateTime.current
    this_monday = today - (today.wday - 1) # 今週の月曜日
    next_monday = this_monday.since(7.days)

    @schedules = Schedule.joins(:user).select('users.*,schedules.*').where("start_time >= ? AND start_time < ?", this_monday, next_monday).where(:room_id => params[:id])


    @users = @schedules.map{|schedule| schedule.user}.uniq
   
    @start_times = @schedules.map{|schedule| schedule.start_time}.uniq.sort { |a,b|  (a) <=> (b) }
  
    @dates = []
    for num in 1..3 do
     @dates.push(this_monday)
     this_monday = this_monday.since(2.days)
    end

    
    # this_day = Date.today
    # this_monday = this_day - (this_day.wday - 1) # 今週の月曜日
    # this_wednesday = this_day - (this_day.wday - 3)
    # this_friday =  this_day - (this_day.wday - 5)

    # # orで3曜日分の配列を取得
    # @schedules = User.joins(:schedule).select('users.name,schedules.*').where(schedules: { room_id: params[:id] })
    # table = @schedules.where('start_time LIKE ?', "%#{this_monday}%").or(@schedules.where('start_time LIKE ?', "%#{this_wednesday}%")).or(@schedules.where('start_time LIKE ?', "%#{this_friday}%"))

    # @date = []
    # for num in 1..3 do
    #  @date.push(this_monday)
    #  this_monday = this_monday.since(2.days)
    # end
    # @names = Schedule.joins(:user).select('users.name,schedules.*').where(schedules: { room_id: params[:id] }).distinct.pluck(:name)

    


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



