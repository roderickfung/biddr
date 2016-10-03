class UsersController < ApplicationController

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: "Successfully Signed Up"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @user = User.new
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end
