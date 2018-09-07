class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def index 
    @category = Category.find(params[:category_id])
    @words = @category.words.paginate(page: params[:page])
  end
  
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
      redirect_to admin_category_words_url(@category)
    else
      render 'new'
    end
  end
  
  def edit
    @word = Word.find(params[:id])
  end 
  
  def update 
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:id])
    if @word.update_attributes(word_params)
      flash[:success] = "Word and Answers updated"
      redirect_to admin_category_words_url(@category)
    else 
      render 'edit' 
    end
  end 
  
  def destroy 
    @category = Category.find(params[:category_id])
    Word.find(params[:id]).destroy
    flash[:success] = "Word and Answers deleted"
    redirect_to admin_category_words_url(@category)
  end
  
  
  
  private
  
    def word_params
      params.require(:word).permit(:content, word_answers_attributes: [:id, :content, :correct])
    end
end
