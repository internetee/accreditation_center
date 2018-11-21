module Admin
  class CategoriesController < BaseController
    before_action :set_category, only: %i[edit update destroy]

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to admin_categories_url, notice: t('.created')
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        redirect_to admin_categories_url, notice: t('.updated')
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to admin_categories_url, notice: t('.deleted')
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
