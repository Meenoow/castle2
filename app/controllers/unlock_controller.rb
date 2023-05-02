class UnlockController < ApplicationController
  def unlock
    if params[:password] == "password"
      session[:unlocked] = true
      redirect_to "/secret"
    else
      flash[:error] = "Invalid password"
      render :new
    end
  end
end
