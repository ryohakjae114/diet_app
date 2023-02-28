class Admins::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items/search or /items.json
  def search
    keyword = params[:keyword]
    @items = Item.where("name LIKE ?", '%'+keyword+'%').paginate(page: params[:page], per_page: 1000)
  end

  # GET /items or /items.json
  def index
    @items = Item.paginate(page: params[:page], per_page: 1000)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to admins_item_url(@item), notice: "アイテムが作成されました" }
        format.json { render :show, status: :created, location: admins_item_url(@item) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/1/edit
  def edit
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to admins_item_url(@item), notice: "アイテムが更新されました" }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to admins_items_url, notice: "アイテムが削除されました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :kcal, :protein, :fat, :carb, :df, :around_qty, :unit, :weight)
    end
end
