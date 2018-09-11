class WordsController < ApplicationController
  before_action :logged_in_user 
  
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @lesson_word = @lesson.lesson_words.build(lesson_word_params)
    if @lesson_word.save 
      redirect_to new_lesson_word_path(@lesson)
    else 
      flash.now[:danger] = "Sorry, something went wrong"
      render 'new'
    end 
  end

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @category = @lesson.category 
    @words = @category.words
    @count = @words.count
    unless @lesson.lesson_words.count == @count
      @current_count = @lesson.lesson_words.count + 1
      @word = @words[@lesson.lesson_words.count]
      @word_answers = @word.word_answers
      @word_answer1 = @word_answers.first
      @word_answer2 = @word_answers.second 
      @word_answer3 = @word_answers.third
      @lesson_word = @lesson.lesson_words.build
    else
      @correct_count = @lesson.word_answers.where("correct = ?", true).count
      current_user.activities.create!(action_type: "learned",
                             count: @count,
                             answer_count: @correct_count,
                             category_id: @category.id)
      redirect_to lesson_path(@lesson)
    end 
  end
  
  
  private
    
    def lesson_word_params
      params.require(:lesson_word).permit(:lesson_id, :word_id, :word_answer_id)
    end
end
