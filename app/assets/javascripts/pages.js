// Ensure that alerts fade out nicely on page load
/* global $ */
$(document).on('turbolinks:load', function(){
    $('.alert').delay(2000).fadeOut(3000);
});