// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$("#get_assignment_json").click(function()
{
	var link= $("#get_assignment_json")[0];	

    $.ajax({
        dataType: "json",
        url: link.href,
        async:true


    });




    return false;
});



function send_answers(answers)
{
	
	
	
}