// Sets "$" and "Stripe" as global variables (removes errors)
/* global $, Stripe */

// Document ready, modified to work with Turbolinks.
$( document ).on('turbolinks:load', function (){
    // Selecting the form and sticking it inside of a Javascript variable "theForm"
    var theForm = $('#pro_form')
    
    // Selecting the submit button and sticking it inside of a Javascript variable "submitBtn"
    var submitBtn = $('#form-submit-btn')
    
    // Set Stripe public key.  
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') )

    // When user clicks form submit button, we will prevent the default submission behavior.
    submitBtn.click(function(event){
        // Prevent default submission behavior
        event.preventDefault()
        
        // Collect CC fields
        var ccNum = $('#card_number').val(), 
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        
        // Send card info to Stripe.
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
    });
    // Stripe to return back card token.

    // Inject card token as hidden field in form
    // Submit form to Rails app.

});