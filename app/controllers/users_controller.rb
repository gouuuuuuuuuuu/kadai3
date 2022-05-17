class UsersController < ApplicationController
  def show
     @user =User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user==current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end


  def index
    @users=User.all
  end


  def update
  @user = User.find(params[:id])
  if @user.update(user_params)
  flash[:notice] = "You have updated book successfully."
  redirect_to user_path(@user.id)
  else
  render :edit
  end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
