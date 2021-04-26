class UsersController < ApplicationController

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

    def whitelist
        params.require(:user).permit(:username, :email, :password)
    end

end
