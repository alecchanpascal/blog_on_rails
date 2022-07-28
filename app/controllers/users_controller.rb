class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :change_password, :update_password]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:Notice] = "Logged In!"
            redirect_to root_path
        else
            flash[:Error] = @user.errors.full_messages.to_sentence
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to root_path
            flash[:Notice] = "User Updated!"
        else 
            flash[:Error] = @user.errors.full_messages.to_sentence
            render :edit
        end
    end

    def change_password
    end

    def update_password
        if @user && @user.authenticate(params[:current_password])
            if params[:new_password] != params[:current_password]
                if @user.update({password: params[:new_password], password_confirmation: params[:new_password_confirmation]})
                    redirect_to root_path
                    flash[:Notice] = "Password Updated!"
                else
                    flash[:Error] = @user.errors.full_messages.to_sentence
                    render :change_password
                end
            else
                flash[:Error] = "Cannot Use Old Password"
                render :change_password
            end
        else
            flash[:Error] = "That Is Not Your Current Password"
            render :change_password
        end
    end

    private 

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
