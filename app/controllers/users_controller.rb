class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@users = User.all
		@users = @users.page(params[:page]).per(8)
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.page(params[:page]).per(4)
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

	def search
		@user_or_post = params[:option]
		if @user_or_post == "1"
			@users = User.search(params[:search], @user_or_post)
		else
			@posts = Post.search(params[:search], @user_or_post)
		end
		@users = User.all
		@users = @users.page(params[:page]).per(8)
		@posts = Post.all
		@posts = @posts.page(params[:page]).per(6)
	end

	private
	def user_params
		params.require(:user).permit(:name, :profile, :email, :profile_image)
	end
end