class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_teacher? ,:only => [:destroy,:create,:new]
	def index
		@users=User.all
	end
	def show
    @user=User.find(params[:id])
    if @user.id==current_user.id


    elsif @user.role.is 'teacher'
      redirect_to users_path
    end
  rescue
    @users=User.all
    render :index
	end
	def create
    @user=User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end
  def update
    @user=User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save?
      redirect_to users_path
    else
      render 'edit'
    end
  end
	def destroy
    @user=User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_path
	end
	def edit
    @user=User.find(params[:id])

	end

  def score
    @user=User.find_by_id(params[:id])
    @assignment=Assignment.find(params[:as_id])
    render 'assignments/show'
  end
  def new
    @user=User.new
  end
  def is_teacher?
    if current_user.role.is('teacher')
    else
      redirect_to users_path

    end
  end


end
