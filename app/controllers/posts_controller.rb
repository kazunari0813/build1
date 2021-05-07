class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@posts = Post.all
		@posts = @posts.page(params[:page]).per(6)
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.page(params[:page]).per(4)
		@comment = Comment.new
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post,nitice: "投稿に成功しました！"
		else
			@posts = Post.all
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
		if @post.user != current_user
			redirect_to posts_path, '不正なアクセスです！'
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
