$('document').ready(function()
{
   // name validation
    var nameregex = /^[а-яА-Я]+$/;

   $.validator.addMethod("validname", function( value, element ) {
     return this.optional( element ) || nameregex.test( value );
   });

   // valid email pattern
   var eregex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

   $.validator.addMethod("validemail", function( value, element ) {
     return this.optional( element ) || eregex.test( value );
   });

   // valid phone number
   var phoneregex = /^(25|29|33|44)\d{7}$/;
   $.validator.addMethod("validphone", function( value, element ){
     return this.optional( element ) || phoneregex.test( value );
   });

   $("#register-form").validate({

    rules:
    {
      first_name: {
       required: true,
       validname: true,
       minlength: 2
      },
      second_name: {
       required: true,
       validname: true,
       minlength: 2
      },
      patronymic: {
       required: true,
       validname: true,
       minlength: 5
      },
      email: {
       required: true,
       validemail: true
      },
      phone: {
        required: true,
        validphone: true
      },
      password: {
       required: true,
       minlength: 8,
       maxlength: 15
      },
      cpassword: {
       required: true,
       equalTo: '#password'
      },
    },
    messages:
    {
      first_name: {
        required: "Пожалуйста, введите имя",
        validname: "Имя должно содержать только буквы русского алфавита",
        minlength: "Ваше имя слишком короткое"
      },
      second_name: {
        required: "Пожалуйста, введите фамилию",
        validname: "Фамилия должно содержать только буквы русского алфавита",
        minlength: "Ваша фамилия слишком короткая"
      },
      patronymic: {
        required: "Пожалуйста, введите отчество",
        validname: "Отчество должно содержать только буквы русского алфавита",
        minlength: "Ваше отчество слишком короткое"
      },
      email: {
        required: "Пожалуйста, введите email",
        validemail: "Введите верный email"
      },
      phone: {
        required: "Пожалуйста, введите номер вашего мобильного телефона",
        validphone: "Введите верный номер (формат 29/25/33/44ХХХХХХХ)"
      },
      password:{
        required: "Введите пароль",
        minlength: "Минимальная длина пароля - 8 символов"
      },
      cpassword:{
        required: "Введите пароль еще раз",
        equalTo: "Пароли не совпадают!"
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
