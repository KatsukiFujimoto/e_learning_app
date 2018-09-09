class LessonsController < ApplicationController
  before_action :logged_in_user 
  
  def create 
    @lesson = current_user.lessons.build(lesson_params)
    if @lesson.save 
      redirect_to root_url
    else 
      render 'categories/index'
    end 
  end 
  
  def show 
    
  end 
  
  
  private 
  
    def lesson_params 
      params.require(:lesson).permit(:category_id)
    end 
end
