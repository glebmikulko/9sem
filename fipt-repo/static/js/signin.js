$('document').ready(function()
{
   // valid email pattern
   var eregex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

   $.validator.addMethod("validemail", function( value, element ) {
     return this.optional( element ) || eregex.test( value );
   });

   $("#signin-form").validate({

    rules:
    {
      email: {
       required: true,
       validemail: true
      },
      password: {
       required: true,
       minlength: 8,
       maxlength: 15
      }
    },
    messages:
    {
      email: {
        required: "Пожалуйста, введите email",
        validemail: "Введите верный email"
      },
      password:{
        required: "Введите пароль",
        minlength: "Минимальная длина пароля - 8 символов"
      }
    },
    errorPlacement : function(error, element) {
      $(element).closest('.form-group').find('.help-block').html(error.html());
    },
    highlight : function(element) {
      $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    },
    unhighlight: function(element, errorClass, validClass) {
      $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
      $(element).closest('.form-group').find('.help-block').html('');
    },

    submitHandler: function(form) {
                  form.submit();
    alert('ok');
              }
    });
 })
