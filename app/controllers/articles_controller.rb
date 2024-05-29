class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @comment = Comment.new
  end

  def create
    puts "article_params: #{article_params}"
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "Article created successfully"
    else
      render :new , notice: "Article not created"
    end
  end

  def update

  end

  def index
    if session[:teacher_id]
      @articles = Article.where(teacher_id: TeacherActiveSession.find_by(session_id: session[:teacher_id]).teacher_id)
    end
  end

  def add_comment


    puts "comment_params: #{comment_params} ------>sjdushdus"
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path, alert: "Article not found"
    else


      @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to @article, notice: "Comment created successfully"
      else
        redirect_to @article, alert: "Comment not created"
      end
    end


  end


  def destroy
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path, alert: "Article not found"
    else
      @article.destroy
      redirect_to articles_path, notice: "Article deleted successfully"
    end
  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to articles_path, alert: "Article not found"
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content,:teacher_id)
  end

  def comment_params
    params.require(:comment).permit(:article_id, :content, :student_id)
  end
end
