class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      session[:user_id] = @user.id
    else
      #renderでなく、redirect_toだとどのような動きになるか試したい => アクションを起こさない（HTTPリクエストなし）
      render :new
    end
  end
  def show
    #パラメータが飛ぶところ、params[:id]をもとに、そのidに紐づくデータをデータベースから取得
    @user = User.find(params[:id])
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
