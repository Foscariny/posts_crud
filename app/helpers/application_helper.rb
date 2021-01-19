module ApplicationHelper

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end
    
    def current_username
        @current_username ||= User.find_by_id(session[:user_id]).username if !!session[:user_id]
    end

    def current_email
        @current_email ||= User.find_by_id(session[:user_id]).email if !!session[:user_id]
    end

    def admin?
        current_user.admin if !!session[:user_id]
    end
end