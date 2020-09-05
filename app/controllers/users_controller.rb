class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      session[:user_id] = @user.id
    else
    #renderでなく、redirect_toだとどのような動きになるか試したい: アクションを起こさない（HTTPリクエストなし）
      render :new
    end
  end
  def show
    #パラメータが飛ぶところ、params[:id]をもとに、そのidに紐づく一つのデータをデータベースから取得
    # その一つのデータを変数として定義し、それぞれのshow・edit・updateアクションのviewに渡す。
    # @user = User.find(params[:id])
    # ログインせずに、showのurlダイレクト入力されるとエラーが出てしまうのでこちらで対応
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to new_session_path
    end
  end
    # editアクションは編集する内容を入力させるアクション
  def edit
    # editへのhttpリクエスト（edit画面へのリンク）が押された時のパラメータ（各idの指定あり）で、編集するデータ（データベース内）を特定し、変数に渡す。
    # @user = User.find(params[:id])
  end
    # updateアクションは編集された内容で、データを更新する。機能的には、createと同じ位置付け。アクションがhttp入力で起こるのではなく、form_withのボタンで起こる。
  def update
    # 一行目のparamsで飛んでいる値は、データベース内（Userモデルを使用して作成されたインスタンス）から、取り出した値。取り出し方は、urlのリクエストをリンクなどで押した覚えはないので、editのform_withに入力したパラメーターが飛んでいると思う（パラメーターの中の入力値は異なるが、idは同じなので、そのidだけを使いデータベースから更新対象のデータを特定していると思う）。→binding.pryでparams確かめたところ、その理解でOK。
    # updateアクションの時は、その前に、変数でupdateの対象を特定しないといけない。
    # @user = User.find(params[:id])
    # editのform_withフォームで入力した値のパラメーターが、user_paramsに入っている。その値を変数を挟んで、データベースに登録する。
    if current_user.id == @user.id && @user.update(user_params)
    # idごとのuserのshowページには、下記urlの引数として、そのidが必要
      redirect_to user_path(@user.id), notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
    # idをキーとして値を取得するメソッドを追加
  def set_user
    @user = User.find(params[:id])
  end
end
