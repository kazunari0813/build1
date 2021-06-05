class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
		@users = @users.page(params[:page]).per(8)
	end

	def show
		@user = User.find(params[:id])
		@current_user_entries = current_user.entries
		@user_entries = @user.entries
		unless @user.me?(current_user.id)
			room_ids = @current_user_entries.pluck(:room_id)
			@user_entries.each do |cu|
				if room_ids.include?(cu.room_id)
						@is_room = true         #既にroomが作成されているか否か。否の場合新規作成。
						@room_id = cu.room_id
					end
				end
			unless @is_room
				@room = Room.new
				@entry = Entry.new
			end
		end
			@posts = @user.posts.page(params[:page]).per(4)
			@post = Post.new
		end

		def edit
			@user = User.find(params[:id])
			if !@user.me?(current_user.id)
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
				@users = @users.page(params[:page]).per(8)
			else
				@posts = Post.search(params[:search], @user_or_post).includes(:user)
				@posts = @posts.page(params[:page]).per(6)
			end
		end

		private
		def user_params
			params.require(:user).permit(:name, :profile, :email, :profile_image)
		end
	end