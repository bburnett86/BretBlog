class SessionController < ApplicationController
  include SessionHelper

  def new
    @user = User.new
    p @user
    render :new
  end

  def create
  @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to(:root)
    else
      @errors = ["Incorrect Username / Password combination."]
      render :new
    end
  end

  def delete
    session.delete(:user_id)
    redirect_to(:root)
  end
end
