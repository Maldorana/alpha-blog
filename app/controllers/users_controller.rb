class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(whitelist)
        if @user.save
            session[:user_id] = @user.id
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
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and all associated articles successfully deleted"
        redirect_to root_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def whitelist
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own account"
            redirect_to @user
        end
    end

end
