class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]

  # GET /wishlists
  # GET /wishlists.json
  def index
    @wishlists = Wishlist.all
  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new
  end

  # GET /wishlists/1/edit
  def edit
  end

  # POST /wishlists
  # POST /wishlists.json
  def create
    d = Date.civil(params[:wishlist]['want_by(1i)'].to_i, params[:wishlist]['want_by(2i)'].to_i, params[:wishlist]['want_by(3i)'].to_i)
    params[:wishlist].delete 'want_by(1i)'
    params[:wishlist].delete 'want_by(2i)'
    params[:wishlist].delete 'want_by(3i)'
    wishlist = Wishlist.new
    wishlist.want_by = d
    wishlist.total_cost = 0
    wishlist.store_id = params[:wishlist][:store]

    @current_user = User.find(session[:user_id])
    wishlist.user_id = @current_user.id

    @wishlist = wishlist

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wishlist }
      else
        format.html { render action: 'new' }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlists/1
  # PATCH/PUT /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def browse
    @wishlists = Wishlist.all
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.require(:wishlist).permit(:want_by, :total_cost, :store)
    end
end
