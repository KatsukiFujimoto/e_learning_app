class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def index 
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url 
  end
  
  def update
    @user = User.find(params[:id])
    if @user.admin?
      @user.admin = false
      if @user.save
        flash[:success] = "#{@user.name} became an normal user"
        redirect_to admin_users_url
      else
        render 'index'
      end
    else
      @user.admin = true
      if @user.save
        flash[:success] = "#{@user.name} became an adminuser"
        redirect_to admin_users_url
      else
        render 'index'
      end
    end
  end
end
