class SessionsController < ApplicationController
  include SessionsHelper

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:session][:email],
      params[:session][:password]
    )
    if user
      sign_in_user(user)
      redirect_to '/'
    else
      flash.now[:errors] = ['Invalid email or password.']
      render :new
    end
  end

  def destroy
    current_user && sign_out_user(current_user)
    redirect_to '/'
  end

end
