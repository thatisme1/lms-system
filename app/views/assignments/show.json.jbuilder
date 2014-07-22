


json.id @assignment.id
json.name @assignment.name
json.questions @assignment.questions, partial: 'questions/question' ,as: :question
#json.questions @assignment.questions do |json, question|
 # json.partial! question
#end

