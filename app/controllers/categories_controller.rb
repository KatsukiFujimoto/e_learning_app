class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  
  def index
    @categories = Category.paginate(page: params[:page])
  end
  
  def show
    @category = Category.find(params[:id])
  end
end
