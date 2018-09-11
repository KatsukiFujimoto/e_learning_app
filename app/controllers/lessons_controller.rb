class LessonsController < ApplicationController
  before_action :logged_in_user 
  
  def create 
    @lesson = current_user.lessons.build(lesson_params)
    @category = Category.find(params[:lesson][:category_id])
    @existing_lesson = Lesson.find_by(user_id: current_user.id, category_id: @category.id)
    if @existing_lesson
      @count = @existing_lesson.category.words.count
      @answer_count = @existing_lesson.lesson_words.count
    end
    if @lesson.save 
      redirect_to new_lesson_word_path(@lesson)
    elsif @existing_lesson && @count != @answer_count
      flash[:success] = "You are back to where you left last time in this lesson"
      redirect_to new_lesson_word_path(@existing_lesson)
    else 
      @categories = Category.paginate(page: params[:page])
      @lesson = Lesson.find_by(user_id: current_user.id, category_id: @category.id)
      redirect_to lesson_path(@lesson)
    end 
  end 
  
  def show 
    @lesson = Lesson.find(params[:id])
    @category = @lesson.category
    @words = @category.words.paginate(page: params[:page])
    @count = @words.count 
    @lesson_words = @lesson.lesson_words.paginate(page: params[:page])
    @correct_count = @lesson.word_answers.where("correct = ?", true).count
  end 
  
  
  private 
  
    def lesson_params 
      params.require(:lesson).permit(:user_id, :category_id)
    end 
end
