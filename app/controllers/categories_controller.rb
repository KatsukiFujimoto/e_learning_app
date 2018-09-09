class CategoriesController < ApplicationController
  before_action :logged_in_user
  
  def index
    @categories = Category.paginate(page: params[:page])
    @user = current_user
    @lesson = @user.lessons.build
  end
  
  def show
    @category = Category.find(params[:id])
  end
end
