class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
   
    @profile = Profile.new
    @profile = Profile.find_or_create_by(:user_id => current_user.id)
    print("***********************************")
    print(@profile)
    redirect_to edit_profile_url(@profile)
    
  end

  # GET /profiles/1/edit
  def edit
    @rooms = Room.all
    id = Profile.find_by(:user_id => current_user.id)
    @room_id = Relation.find_by(user_id: id.user_id)
    if @profile.user_id != current_user.id
      raise ActionController::RoutingError.new("Not authorized")
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @relation = Relation.new
    @profile.update(profile_params)
    respond_to do |format|
      if !params[:room_ids].nil? 
        room_id = params[:room_ids][0]
        user_id = params[:profile][:user_id]
        if !Relation.find_by(user_id: user_id).nil? 
          Relation.find_by(user_id).destroy
        end
        @relation.update({ "room_id" => room_id, "user_id" => user_id })
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { redirect_to edit_profile_url(@profile) }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:name, :line_name, :thumbnail, :user_id)
    end
end
