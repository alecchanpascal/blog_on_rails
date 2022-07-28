class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:Notice] = "Logged In!"
            redirect_to root_path
        else 
            flash[:Error] = "User Not Found!"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:Notice] = "Logged Out!"
        redirect_to root_path
    end
end
