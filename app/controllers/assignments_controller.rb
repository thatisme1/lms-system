class AssignmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_teacher? ,:only => [:new,:create,:edit,:add_answers,:destroy,:activate,:expire,:set_answers,:update]

  def index
    @assignments=Assignment.all
  end

  def set_answers
    @assignment=Assignment.find_by_id(params[:id])
    puts @assignment.present?
    puts params
    if @assignment
      @quest=@assignment.questions
      temp=0
      @quest.each do |question|
        question.choice_id=params[:assignment][:questions_attributes][temp.to_s][:choice_id]
        question.save
        temp=temp+1
      end
    end
    @user=current_user
    render 'assignments/show'

  end

  def add_answers
    @assignment=Assignment.find(params[:id])
  end


  def new
    @assignment = Assignment.new
    1.times do
      question = @assignment.questions.build
      4.times { question.choices.build }

    end
  end

  def show
    @assignment=Assignment.find(params[:id])

    @user=User.find(current_user)

  end

  def create
    @assignment=Assignment.new(params[:assignment])


    if @assignment.save
      render :'assignments/add_answers'
    else
      render :action => :new
    end
  end


  def update
    @aa=Assignment.find(params[:id])
    if @aa.update_attributes(params[:assignment])

      redirect_to assignment_path(@aa)

    else
      render :edit
    end
  end

  def is_teacher?
    if current_user.role.is('teacher')

    else
      redirect_to assignments_path
    end
  end
  def download
    @user=User.find(current_user)
    @assignment= Assignment.find(params[:id])
    if @user.role.is('teacher') || @assignment.active
      if @user.role.is('student')

        @att=@user.attempts.find_or_initialize_by_assignment_id(@assignment.id)
        @att.submitted=false
        @att.save
      end
      send_data @assignment.as_file,
                :filename => "#{@assignment.name}.txt",
                :type => "text/plain" and return





    end
    flash[:alert] = 'Assignment not available for download'
    redirect_to assignments_path
  end


  def upload
    @assignments=Assignment.all
    @user=User.find(current_user)
    if !params[:file_upload]
      redirect_to assignments_path and return
    end

    require 'fileutils'
    tmp = params[:file_upload][:my_file].tempfile
    file = File.join("public", params[:file_upload][:my_file].original_filename)
    FileUtils.cp tmp.path, file
    File.open(file,'r') do |infile|
      assignment = infile.gets
      puts assignment
      @assignment=Assignment.find(assignment.to_i)

      @attempt=@user.attempts.find_by_assignment_id_and_submitted(@assignment.id,false)

      @questions=@assignment.questions

      @result=[]

      @questions.each do |question|

        if (que=infile.gets)
            choice=infile.gets
            puts que
            puts choice

            a=question.choices.find_by_text(choice)
            @result.push(QuestionAttempt.new(:attempt_id=>@attempt.id,:question_id=>question.id,:choice_id=>a.id))
            x=infile.gets
        end

      end

      @result.each do |res|

       res.save
      end
      @attempt.submitted=true
      @attempt.save

      infile.close
      FileUtils.rm file
      redirect_to assignments_path and return

    end

  rescue



   # puts '+========================================================++'
    flash[:alert]='Wrong file type'
    render 'assignments/index'




  end
  def edit

    @assignment=Assignment.find(params[:id])
    if @assignment.active || @assignment.expired
      redirect_to assignments_path
    end
  end

  def destroy
    @assignment=Assignment.find(params[:id])
    if @assignment.present? && @assignment.can_destroy
      @assignment.destroy

    end
    redirect_to assignments_path
  end

  def activate
    @assignment=Assignment.find(params[:id])
    if @assignment.set_as_active

      @assignments=Assignment.all
      flash[:notice]="Assignment #{@assignment.name} activated"
      render 'index'
      return
    end
    flash[:alert]="Correct Answers not set"
    redirect_to assignments_path

  end

  def expire
    @assignment=Assignment.find(params[:id])
    if @assignment
      @assignment.expire
    end
    redirect_to assignments_path

  end

  def results
    @assignment=Assignment.find(params[:id])

  end


  def play
    @assignment=Assignment.find(params[:id])
    @attempt=current_user.attempts.find_by_assignment_id(@assignment.id)
    render
  end

end
