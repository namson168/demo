class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    @comment = @current_user.comments.build(comment_params)
    @comment.entry_id=params[:entry_id]
    @comment.save 
    @entry=@comment.entry
    @comments = @comment.entry.comments.paginate(page: params[:page], :per_page => 5 )

  #  if @comment.save
  #     flash[:success] = "Comment created!"
  #     redirect_to @comment.entry
       respond_to do |format|
                    format.html { redirect_to @comment.entry }
                    format.js
    end

  #  else
  #    flash[:danger] = "Cannot create comment!"
  #    redirect_to request.referrer || root_url
  #  end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
