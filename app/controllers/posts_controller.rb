class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@posts = Post.includes(:user) #Post.allから変更
		@posts = @posts.page(params[:page]).per(6).order(id: "DESC")
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.includes(:user).page(params[:page]).per(4).order(id: "DESC") # @post.comments.page(params[:page]).per(4)から変更
		@comment = Comment.new
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post,notice: "投稿に成功しました！"
		else
			@posts = Post.all
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
		if !@post.user.me?(current_user.id)
			redirect_to posts_path, alert:'不正なアクセスです！'
		end
	end

	def update
		@post =Post.find(params[:id])
		if @post.update(post_params)
			redirect_to post_path(@post),notice: '更新に成功しました！'
		else
			render :edit
		end
	end

	def destroy
		post = Post.find(params[:id])
		post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title, :body, :image, :rate)
	end
end
