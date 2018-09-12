class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers, :dashboard,
                                        :category, :word]
  before_action :correct_user, only: [:edit, :update]

  def index 
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @word_count = @user.lesson_words.count
    @lessons = @user.lessons
    @finished_lessons = @lessons.select do |lesson|
      lesson.category.words.count == lesson.lesson_words.count 
    end 
    @category_count = @finished_lessons.count
    #@pre_activities = @user.activities + Activity.where("passive_user_id = ?", @user.id)
    @activities = @user.show_activity.paginate(page: params[:page])
    #@activities = @pre_activities.paginate(page: params[:page])
  end
  
  def dashboard
    @user = current_user
    @word_count = @user.lesson_words.count
    @lessons = @user.lessons
    @finished_lessons = @lessons.select do |lesson|
      lesson.category.words.count == lesson.lesson_words.count 
    end 
    @category_count = @finished_lessons.count
    @activities = @user.activity_feed.paginate(page: params[:page])
  end 
  
  def category 
    @user = User.find(params[:id])
    @lessons = @user.lessons 
    @finished_lessons = @lessons.select do |lesson|
      lesson.category.words.count == lesson.lesson_words.count 
    end 
    @pre_categories = @finished_lessons.map do |lesson|
      lesson.category 
    end 
    @categories = @pre_categories.paginate(page: params[:page])
  end 
  
  def word 
    @user = User.find(params[:id])
    @lesson_words = @user.lesson_words.paginate(page: params[:page])
  end 
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to dashboard_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    
end
