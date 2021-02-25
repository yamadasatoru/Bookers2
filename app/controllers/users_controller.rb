class UsersController < ApplicationController
before_action :screen_user, only: [:update]

  def new
    @book = Book.new
    @user = User.new(user_params)
    if @user.save
      redirect_to user_params(current_user.id)
    else
      render "users/sign_up"
    end
  end


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def screen_user
    @user = User.find(params[:id])
     if @user != current_user
      redirect_to books_path
     end
  end
end
