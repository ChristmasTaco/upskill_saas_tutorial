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
        event.preventDefault();
        submitBtn.val("Processing").prop('disabled', true);
        
        // Collect CC fields
        var ccNum = $('#card_number').val(), 
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        // Use stripe.js library to check for card errors
        var error = false;
        
        // Validate card number:
        if(!Stripe.card.validateCardNumber(ccNum)) {
            error = true;
            alert('The credit card number appears to be invalid')
        }
        
        // Validate CVC number:
        if(!Stripe.card.validateCVC(cvcNum)) {
            error = true;
            alert('The CVC number appears to be invalid')
        }
        
        // Validate expiration date:
        if(!Stripe.card.validateEpiry(expMonth, expYear)) {
            error = true;
            alert('The expiration date appears to be invalid')
        }
        
        if (error) {
            // If there are card errors, don't send to Stripe
            submitBtn.prop('disabled', false).val("Sign Up");
        } else {
            // Send card info to Stripe.
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
        }
        // Exit out of the function
        return false;
    });
    
    // Stripe to return back card token.
    function stripeResponseHandler(status, response){
        // Get the token from the response
        var token = response.id
        
        // Inject card token as hidden field in form
        theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    }

    // Submit form to Rails app.
    // Use "get(0)" to get the first item in the "theForm" array
    theForm.get(0).submit();
});