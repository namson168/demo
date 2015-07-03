class EntriesController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user,   only: [:destroy, :edit, :update]


    def show
      @entry = Entry.find(params[:id])
      @comments = @entry.comments.paginate(page: params[:page], :per_page => 5 )
      @comment = current_user.comments.build if logged_in?
    end

    def create
      @entry = current_user.entries.build(entry_params)
      if @entry.save
          flash[:success] = "Entry created!"
          redirect_to current_user
      else
        @feed_items = []
          flash[:danger] = "Entry can't be created!"
          redirect_to current_user
      end
    end

     def destroy
      @entry.destroy
      flash[:success] = "Entry deleted"
      redirect_to request.referrer || root_url
    end

    def edit
      @entry = Entry.find(params[:id])
    end

    def update
      @entry = Entry.find(params[:id])
      if @entry.update_attributes(entry_params)
        flash[:success] = "Profile updated"
        redirect_to @entry
      else
        render 'edit'
      end
    end

    def index
      @entries = Entry.all.paginate(page: params[:page], :per_page => 10 )
    end

private

    def entry_params
        params.require(:entry).permit(:title, :body, :picture, :id)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
