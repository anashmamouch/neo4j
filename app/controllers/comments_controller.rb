class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        @post.comments.create(@comment, :created => Time.now.to_i)

        format.html {redirect_to @post, notice: 'Comment was successfully created'}
        format.json {render action: 'show', status: :created, location: @comment}
      else
        format.html {render action: 'new'}
        format.json {render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {redirect_to @comment, notice: 'Comment was successfully created'}
        format.json {head :no_content}
      else
        format.html {render action: 'edit'}
        format.json {render json: @comments.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit

  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @post}
      format.json {head :no_content}
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:posts_id])
    end

    def comment_params
      params[:comment]
    end
end
