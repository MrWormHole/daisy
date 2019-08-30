$(document).ready(function() {
    console.log("LOADED Jquery");
    $(".tester").click(function () {
        $(this).replaceWith("<h1>JQuery is Great</h1>");
    });

    $(".photoButton").click(function() {
       $(".foo").click();
    });
});