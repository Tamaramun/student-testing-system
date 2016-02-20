$(document).ready(function(){
    $(".answers").on("click", function(){
        var checked = this.checked;
        var resultId = $(this).attr("id");
        var answerId = $(this).attr("answer-id");
        var questionId = $(this).attr("question-id");

        $.ajax({
            type: "POST",
            beforeSend: function (request)
            {
                request.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
            url: "/answers/" + resultId,
            data: {answer: checked, answerId: answerId, questionId: questionId},
            success: function(response){
            },
            error: function(error){
                console.log(error)
            }
        })
    });
});
