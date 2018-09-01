class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
    3.times { @word.word_answers.build }
  end
  
  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.new(word_params)
    if @word.save
      flash[:success] = "words and answers have been created"
      render 'new'
    else
      render 'new'
    end
  end
  
  
  
  private
  
    def word_params
      params.require(:word).permit(:content, word_answers_attributes: [:id, :content, :correct])
    end
end
