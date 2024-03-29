class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @entry  = current_user.entries.build
    @feed_items = @user.feed.paginate(page: params[:page])
  end

   def create
    @user = User.new(user_params)
    if @user.save
      #@user.send_activation_email
        message  = "Please check your email to activate your account.  "
        message += edit_account_activation_url(@user.activation_token, email: @user.email)
      flash[:info] = message
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user

    else
      render 'edit'
    end
  end


  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

private
	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation)
	end

  
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

        # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
