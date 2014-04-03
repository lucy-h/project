class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @wishlist = Wishlist.find(session[:wishlist_id])
    params[:item].delete :container
    item = Item.find_by(url: params[:item][:url])
    if !item
      item = Item.new(item_params)
      item.container_type = 'Store'
      item.container_id = @wishlist.store.id
    end
    @item = item

    item2 = Item.new(item_params)
    item2.container_type = 'Wishlist'
    item2.container_id = @wishlist.id
    @item2 = item2

    respond_to do |format|
      if @item.save && @item2.save
        @wishlist.items << @item2
        @wishlist.save
        format.html { redirect_to edit_wishlist_url(@wishlist), notice: 'Item was successfully added to wishlist.' }
        #format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if @item.container_type == 'Wishlist'
      @wishlist = Wishlist.find(@item.container_id)
      @wishlist.items.delete_if{|o| o.id == @item.id}
      @wishlist.save
    elsif @item.container_type == 'Store'
      @store = Store.find(@item.container_id)
      @store.items.delete_if{|o| o.id == @item.id}
      @store.save
    end

    @item.destroy
    respond_to do |format|
      @wishlist = Wishlist.find(session[:wishlist_id])
      format.html { redirect_to edit_wishlist_url(@wishlist) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :url, :price, :container)
    end
end
