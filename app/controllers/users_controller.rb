class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts
		@post = Post.new
	end

	def edit
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to user_path(current_user), alert:'不正なアクセスです！'
		end
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to user_path, notice: "ユーザー情報を更新しました。"
		else
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :profile, :email, :profile_image)
	end
end