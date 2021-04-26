class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end

    def create
        @user = User.new(whitelist)
        if @user.save
            flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}. Your account has been successfully created."
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @user.update(whitelist)
            flash[:notice] = "Your account information was updated successfully"
            redirect_to root_path
        else
            render 'edit'
        end
    end

    def set_user
        @user = User.find(params[:id])
    end

    def whitelist
        params.require(:user).permit(:username, :email, :password)
    end

end
