class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
        # If the user is not found, redirect to the users index page
        redirect_to users_path if @user.nil?
    end
end