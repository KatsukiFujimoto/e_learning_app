class WordsController < ApplicationController
  before_action :logged_in_user
  
  def index 
    @category = Category.find(params[:category_id])
    @words = @category.words.paginate(page: params[:page])
  end 
  
end
