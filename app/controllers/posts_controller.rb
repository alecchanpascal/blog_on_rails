class PostsController < ApplicationController
    before_action :find_post, only: [:show, :destroy, :edit, :update]

    def new 
        @post = Post.new
    end

    def create 
        @post = Post.new(post_params)
        if @post.save
            flash[:Notice] = "Post Created Successfully!"
            redirect_to post_path(@post)
        else
            flash[:Erorr] = @post.errors.full_messages.to_sentence
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
        redirect_to posts_path
        flash[:Notice] = "Post Deleted!"
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
            flash[:Notice] = "Post Updated!"
        else
            flash[:Error] = @post.errors.full_messages.to_sentence
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
