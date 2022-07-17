class PostsController < ApplicationController
    before_action :find_post, only: [:show, :destroy, :edit, :update]

    def new 
        @post = Post.new
    end

    def create 
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "Post Created Successfully!"
            redirect_to post_path(@post)
        else
            flash[:erorr] = @post.errors.full_messages.to_sentence
            render :new
        end
    end

    def index
        @posts = Post.order(created_at: :desc)
    end

    def show
        @comments = @post.comments.order(created_at: :asc)
        @comment = Comment.new
    end

    def destroy
        @post.destroy
        redirect_to posts_path, notice: "Post Deleted!"
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post), notice: "Post Updated!"
        else
            flash[:error] = @post.errors.full_messages.to_sentence
            render :edit
        end
    end

    private

    def find_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end
end
