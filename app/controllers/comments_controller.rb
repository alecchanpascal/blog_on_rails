class CommentsController < ApplicationController
    before_action :find_post
    before_action :authenticated_user!

    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            redirect_to post_path(@post)
            flash[:Notice] = "Comment Added!"
        else
            @comments = @post.comments.order(created_at: :asc)
            flash[:Error] = @comment.errors.full_messages.to_sentence
            redirect_to post_path(@post), status: 303
        end
    end

    def destroy 
        @comment = Comment.find(params[:id])
        if can?(:crud, @comment) || can?(:crud, @post)
            @comment.destroy
            redirect_to post_path(@post) 
            flash[:Notice] = "Comment Deleted!"
        else
            redirect_to root_path
            flash[:Alert] = "Not Authorized!"
        end
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end
end
