class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def index
    @categories = Category.paginate(page: params[:page])
  end
  
  def new
    @category = Category.new
  end
  
  def create
  end
  
  def edit
    @category = Category.find(params[:id])
  end

  def update
  end

  def destroy
    @category = Category.find(params[:id])
  end
end
