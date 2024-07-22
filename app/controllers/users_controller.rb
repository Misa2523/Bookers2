class UsersController < ApplicationController

  def show
    #URLに記載されたIDを参考に必要なUserモデルを取得
    @user = User.find(params[:id])

  end


  def index
  end

  def edit
  end

  #ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name)
  end

end
