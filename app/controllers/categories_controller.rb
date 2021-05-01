class CategoriesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update]
    before_action :require_admin, except: [:show, :index]

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(whitelist)
        if @category.save
            flash[:notice] = "Category was created successfully"
            redirect_to categories_path
        else
            render 'new'
        end
    end

    def show
        @articles = @category.articles.paginate(page: params[:page], per_page: 5)    
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def update
        if @category.update(whitelist)
            flash[:notice] = "Category name was updated successfully"
            redirect_to @category
        else
            render 'edit'
        end
    end

    private

    def set_article
        @category = Category.find(params[:id])
    end

    def whitelist
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "Only admins perform that action"
            redirect_to categories_path
        end
    end


end
