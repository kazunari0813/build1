class UsersController < ApplicationController

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
		@user =User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render :edit
		end
	end
	private
	def user_params
		params.require(:user).permit(:name, :profile_image)
	end
	end