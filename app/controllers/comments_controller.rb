class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment.post, notice: 'Comment was successfully created.'
    else
      redirect_to @comment.post, alert: 'Comment could not be created.'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.nil?
      redirect_to articles_path, alert: 'Comment not found'
    else
      @comment.destroy
      redirect_to articles_path, notice: 'Comment deleted successfully'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content, :student_id)
  end
end
