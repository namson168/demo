class StaticPagesController < ApplicationController
  def home
      @entries = Entry.all.paginate(page: params[:page], :per_page => 10 )
  end

  def help
  end

  def about
  end

  def contact
  end
  	
end
