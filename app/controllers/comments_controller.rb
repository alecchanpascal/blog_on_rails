class CommentsController < ApplicationController
    before_action :find_post

    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post
        if @comment.save
            redirect_to post_path(@post), notice: "Comment Added!"
        else
            @comments = @post.comments.order(created_at: :asc)
            flash[:error] = @comment.errors.full_messages.to_sentence
            redirect_to post_path(@post), status: 303
        end
    end

    def destroy 
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        # redirect_to post_path(@post), notice: "Comment Deleted!"
        respond_to do |format|
            format.html { redirect_to post_comments_path(@post) }
            format.xml  { head :ok }
          end
    end

    # def update
    #     @comment = Comment.find(params[:id])
    #     @comment.update({body: @comment.body})
    #     redirect_to post_path(@post), notice: "Comment Updated!"
    # end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end
end
