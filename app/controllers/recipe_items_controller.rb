class RecipeItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_recipe,      only: %i[ index new create ]
  before_action :set_recipe_item, only: %i[ destroy ]

  # GET /recipes/1/recipe_items or /recipes/1/recipe_items.json
  def index
  end

  # GET /recipes/1/recipe_items/new
  def new
    @recipe_item = @recipe.recipe_items.build
  end

  # POST /recipes/1/recipe_items or /recipes/1/recipe_items.json
  def create
    @recipe_item = @recipe.recipe_items.build(recipe_params)

    respond_to do |format|
      if @recipe_item.save

        #レシピの各栄養素の値を更新
        @recipe.add_nutrients(@recipe_item)

        format.html { redirect_to recipe_url(@recipe), notice: "アイテムが追加されました" }
        format.json { render recipe_path(@recipe), status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_items/1 or /recipe_items/1.json
  def destroy
    @recipe = @recipe_item.recipe
    @recipe.sub_nutrients(@recipe_item)
    @recipe_item.destroy

    respond_to do |format|
      format.html { redirect_to @recipe, notice: "RecipeItem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_recipe_item
    @recipe_item = RecipeItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe_item).permit(:item_id, :kcal, :weight)
  end
end
