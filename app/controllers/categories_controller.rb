class CategoriesController < ApplicationController

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(whitelist)
        if @category.save
            flash[:notice] = "Category was created successfully"
            redirect_to @category
        else
            render 'new'
        end
    end

    def show

    end

    def index

    end

    private

    def whitelist
        params.require(:category).permit(:name)
    end

end
