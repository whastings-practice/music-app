class UsersController < ApplicationController
  include SessionsHelper

  before_action :require_admin, only: [:make_admin, :index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account created! Please check your email for activation."
      UserMailer.activation_email(@user).deliver!
      redirect_to '/'
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    if params[:activation_token]
      user = User.find_by!(activation_token: params[:activation_token])
      user.activate!
      sign_in_user(user)
    end
    redirect_to root_url
  end

  def make_admin
    user = User.find(params[:id])
    user.make_admin!
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
