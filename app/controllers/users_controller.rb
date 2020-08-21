class UsersController < ApplicationController
  #コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, :only => [:show]

  def index
    @users=User.all
  end

  def new
    @Usernew = User.new
    @Usernew.user_images.new
  end

  def create
    @Usernew = User.new(user_params)
    @Usernew.user_id = current_user.id

    if @Usernew.save
      redirect_to users_path
    else
      render('users/new')
    end
  end


  def edit
  end

  def show
    @user=User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id

    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom

      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def destroy
    @User = User.find(params[:id])
    @User.destroy
    redirect_to users_path
  end

  def hashtag
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.users.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      # @user = @hashtag.users.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.users.count}
    end
  end

  private

  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :introduce, :age, :sex,
                                :birthaddress, :hashbody, hashtag_ids: [])
  end

  # def user_params
  #   params.require(:user).permit(:body, :hashbody, :user_id, user_images_images: [], hashtag_ids: [])
  # end

end
