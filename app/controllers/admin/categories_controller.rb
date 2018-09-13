class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Created a new category"
      redirect_to admin_categories_url
    else
      render 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to admin_categories_url
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @activities = Activity.where('category_id = ?', params[:id])
    @activities.destroy_all
    @lessons = Lesson.where('category_id = ?', params[:id])
    @lessons.destroy_all
    @category.destroy
    flash[:success] = "Category deleted"
    redirect_to admin_categories_url
  end
  
  private
  
    def category_params
      params.require(:category).permit(:title, :description)
    end
end

