// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){
    submitCard();
    shareLink();
});

function submitCard() {
    $("div.light.stackcard").click(function(){
        var cardText = $(this).find("li").first().text();
        if (confirm("Submit Card?" )) {
          var cardId = $(this).find(":hidden").text()
          var roundId = $("#round").text();
          $.ajax({
              method: "PUT",
              url: "/rounds/" + roundId,
              data: {"cardId" : cardId}
          });
        }
    });
}

function shareLink() {
  var link = window.location.href;
  $("#share").append("<a href='sms:?body=" + link + "'>share via sms</a>");
}