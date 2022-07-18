class CommentsController < ApplicationController
    before_action :find_post

    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post
        if @comment.save
            redirect_to post_path(@post)
            flash[:Notice] = "Comment Added!"
        else
            @comments = @post.comments.order(created_at: :asc)
            flash[:error] = @comment.errors.full_messages.to_sentence
            redirect_to post_path(@post), status: 303
        end
    end

    def destroy 
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post) 
        flash[:Notice] = "Comment Deleted!"
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end
end
