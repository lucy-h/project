class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :admin_only, :only => [:index, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @current_user = User.find(session[:user_id]) if session[:user_id]
    if @user.id != @current_user.id && @current_user.role != "admin"
      redirect_to root_url
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save and session[:user_id] == nil
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
      elsif @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @current_user = User.find(session[:user_id]) if session[:user_id]
        if @current_user.role != "admin"
          format.html { redirect_to root_url }
        else 
          format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    while Wishlist.find_by(user_id: @user.id) != nil do
      w = Wishlist.find_by(user_id: @user.id)
      w.destroy
    end

    if session[:user_id] == @user.id
      @user.destroy
      respond_to do |format|
        format.html { redirect_to logout_path, notice: "You have deleted your account and successfully logged out."}
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :github_url, :website, :building)
    end
end
