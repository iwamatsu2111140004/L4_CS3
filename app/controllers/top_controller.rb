require 'bcrypt'
class TopController < ApplicationController
  def main
    if session[:login_uid] != nil
      render "main"
    else
      render "login"
    end
  end

  def login
    if User.find_by(uid: params[:uid]) 
      signup_password = BCrypt::Password.create(params[:pass])
      if BCrypt::Password.new(signup_password) == params[:pass]
        session[:login_uid] = params[:uid]
        redirect_to top_main_path
      else
        render "error"
      end
    else
      render "error"
    end
  end
  
  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
  
  def new
    render "signup"
  end
  
  def signup
    signup_pass = BCrypt::Password.create(params[:pass])
    user = User.new(uid: params[:uid], pass: signup_pass)
    user.save
    session[:login_uid] = params[:uid]
    redirect_to top_main_path
  end
end
