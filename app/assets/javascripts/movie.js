$(function() {
  $("a.all_comments").on("click", function(e){
    $.ajax({
      method: "GET",
      url: `${this.href}.json`
    }).done(function(response){
      const result = response.filter(resp => resp.body.length > 4)

      $("div.comments").html(result.map(resp => {
        return `<p><strong> ${resp.user.username} </strong>: ${resp.body} </p>`
      }))
    })
    e.preventDefault();
   })
  });

$(function() {
  $("a.show_genre").on("click", function(e){
    $.ajax({
     method: "GET",
     url: `${this.href}.json`
    }).done(function(response){
      $("div.show_movies").html(response.movies.map(resp => {
        return `<h3><strong> ${resp.title} </strong></h3>
                <p> by ${resp.director}</p>
                <a href="movies/${resp.id}">View movie</a>`
      }))
    })
    e.preventDefault();
  })
});
//Comment Object
function Comment(json) {
  //object methods
  this.id = json.id
  this.body = json.body
  this.username = json.user.username
  } 
  //Created a comment prototype using the comment object that will save the comment attributes and return those attribute in a paragraph.
Comment.prototype.renderP = function() {    return "<p>" + this.body + " " +
"by" + " " + "<strong>" +  this.username + "</strong>" + "</p>" //this.name  }
}
 $(function() {
  $("form#new_comment").on("submit", function(e) {
    e.preventDefault();
    var $form = $(this);//this is referring to the entire form and storing it in the $form variable
    var action = $form.attr("action");//returning the action attrible from the form
    var params = $form.serialize();//serialize the form data --- the data is then stored in the params variable

     $.ajax({
        url: action,
        data: params,
        dataType: "json",
        method: "POST"
      })
      .done(function(json) {
        $('form#new_comment').trigger('reset');
        //$("#new_comment > p > input[type="submit"]").trigger('reset');
        //#new_comment > p > input[type="submit"]

        
       var comment = new Comment(json)
       var commentP = comment.renderP()

       $(".new").append(commentP)
  
     })

    .error(function(response) {
      console.log("error!", response)
    })
  })
});




