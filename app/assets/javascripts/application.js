// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  $(".container").on("click", ".project_links", function(){
    event.preventDefault();
    var that = $(this);
    var id = $(this).attr("id")

    var request = $.ajax({
      url:'/projects/'+id,
      method: "get"
    })
    request.done(function(showPage){
      $(".container").empty();
      $(".container").append(showPage);
    })
  })
  $(".container").on("click", ".blog_links", function(){
    event.preventDefault();
    var that = $(this);
    var id = $(this).attr("id")

    var request = $.ajax({
      url:'/blogs/'+id,
      method: "GET"
    })
    request.done(function(showPage){
      $(".container").empty();
      $(".container").append(showPage);
    })
  })
  $(".container").on("click", ".show_blog_links", function(){
    event.preventDefault();
    var that = $(this);
    var id = $(this).attr("id")

    var request = $.ajax({
      url:'/blogs/'+id,
      method: "GET"
    });
    request.done(function(showPage){
      $(".container").empty();
      $(".container").append(showPage);
    });
  });
  $(".container").on("click", "#commentLink", function(){
    event.preventDefault();
    $("#linkContainer").empty();
    // var that = this
     var request = $.ajax({
      url: $(this).attr("href"),
      method: "GET"
     });
     request.done(function(comment){
      $("#linkContainer").append(comment);
    });
  });
  $(".container").on("submit", "#commentForm", function(){
    event.preventDefault();
    var comment_url = $(this).attr("action");
    var comment_method = $(this).attr("method");
    var comment_data = $(this).serialize();


    var request = $.ajax({
      url: comment_url,
      method: comment_method,
      data: comment_data
    });
    request.done(function(comment){
      console.log(comment)
      $("#commentsContainer").prepend(comment)
    })
    var request = $.ajax({
      url: "/partials/_new_comment_link",
      method: "GET"
    });
    request.done(function(_new_comment_link){
      $("#linkContainer").empty();
      $("#linkContainer").append(_new_comment_link)
    })
  });
});