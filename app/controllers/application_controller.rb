class ApplicationController < ActionController::Base
    def authenticated_user!
        unless user_signed_in?
            flash[:Alert] = "Please Sign In First"
            redirect_to root_path
        end
    end

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end
    helper_method :current_user
end
