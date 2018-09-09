class LessonsController < ApplicationController
  before_action :logged_in_user 
  
  def create 
    @lesson = current_user.lessons.build(lesson_params)
    @category = Category.find(params[:lesson][:category_id])
    if @lesson.save 
      # @lesson1 = Lesson.find_by(user_id: current_user.id, category_id: @category.id)
      redirect_to new_lesson_word_path(@lesson)
    #elsif Lesson.find_by(user_id: current_user.id, category_id: params[:lesson][:category_id])
    #  @category = Category.find(params[:lesson][:category_id])
    #  @words = @category.words.paginate(page: params[:page])
    #  render 'categories/show'
    else 
      @categories = Category.paginate(page: params[:page])
      flash.now[:danger] = "Sorry, something went wrong"
      render 'categories/index'
    end 
  end 
  
  def show 
    
  end 
  
  
  private 
  
    def lesson_params 
      params.require(:lesson).permit(:user_id, :category_id)
    end 
end
