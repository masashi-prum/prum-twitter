class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end
  def create
    @user = User.new(user_params)   
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Prum Twitter!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

   private

    def user_params
      params.require(:user).permit(:user_name, :full_name, :email, :image, :password,)
    end
end