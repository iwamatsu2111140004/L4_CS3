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
    #logger.debug("aaaaaaaaaaa")
    #logger.debug(User.where(id: params[:id]).pluck(:pass))
    user = User.find_by(uid: params[:uid])
    #user.pass = BCrypt::Password.create(パスワードの文字列)
    if user && BCrypt::Password.new(user.pass) == params[:pass]
      session[:login_uid] = params[:uid]
      redirect_to top_main_path
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
