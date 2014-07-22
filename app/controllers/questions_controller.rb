class QuestionsController < ApplicationController



def update
  @question=Question.find(params[:id])
  @question.choice_id=params[:question][:choice_id]
  @question.save
  redirect_to "/assignments/#{@question.assignment.id.to_s}/add_answers"
end

end