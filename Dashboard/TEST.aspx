<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TEST.aspx.cs" Inherits="Dashboard_TEST" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #contact label{
	display: inline-block;
	width: 100px;
	text-align: right;
}
#contact_submit{
	padding-left: 100px;
}
#contact div{
	margin-top: 1em;
}
textarea{
	vertical-align: top;
	height: 5em;
}
.error{
	display: none;
	margin-left: 10px;
}		

.error_show{
	color: red;
	margin-left: 10px;
}
input.invalid, textarea.invalid{
	border: 2px solid red;
}

input.valid, textarea.valid{
	border: 2px solid green;
}
    </style>
    <script src="js/jquery.min.js"></script>
</head>
   
<body>
    <form id="contact" method="post" action="">
	<!-- Name -->
	<div>
		<label for="contact_name">Name:</label>
		<input type="text" id="contact_name" name="name"></input>
		<span class="error">This field is required</span>
	</div>
	<!-- Email -->
	<div>
		<label for="contact_email">Email:</label>
		<input type="email" id="contact_email" name="email"></input>
		<span class="error">A valid email address is required</span>				
	</div>						
	<!--Website -->
	<div>
		<label for="contact_website">Website:</label>
		<input type="url" id="contact_website" name="website"></input>
		<span class="error">A valid url is required</span>								
	</div>						
	<!-- Message -->
	<div>
		<label for="contact_message">Message:</label>
		<textarea id="contact_message" name="message"></textarea>
		<span class="error">This field is required</span>												
	</div>					
	<!-- Submit Button -->
	<div id="contact_submit">				
		<button type="submit">Submit</button>
	</div>
</form>
    <script>
        $(document).ready(function () {
            //jQuery code goes here
            $('#contact_name').on('input', function () {
                var input = $(this);
                var is_name = input.val();
                if (is_name) { input.removeClass("invalid").addClass("valid"); }
                else { input.removeClass("valid").addClass("invalid"); }
            });
            $('#contact_email').on('input', function () {
                var input = $(this);
                var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                var is_email = re.test(input.val());
                if (is_email) { input.removeClass("invalid").addClass("valid"); }
                else { input.removeClass("valid").addClass("invalid"); }
            });
            $('#contact_website').on('input', function () {
                var input = $(this);
                if (input.val().substring(0, 4) == 'www.') { input.val('http://www.' + input.val().substring(4)); }
                var re = /(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?/;
                var is_url = re.test(input.val());
                if (is_url) { input.removeClass("invalid").addClass("valid"); }
                else { input.removeClass("valid").addClass("invalid"); }
            });
            $('#contact_message').keyup(function (event) {
                var input = $(this);
                var message = $(this).val();
                console.log(message);
                if (message) { input.removeClass("invalid").addClass("valid"); }
                else { input.removeClass("valid").addClass("invalid"); }
            });
            $("#contact_submit button").click(function (event) {
                var form_data = $("#contact").serializeArray();
                var error_free = true;
                for (var input in form_data) {
                    var element = $("#contact_" + form_data[input]['name']);
                    var valid = element.hasClass("valid");
                    var error_element = $("span", element.parent());
                    if (!valid) { error_element.removeClass("error").addClass("error_show"); error_free = false; }
                    else { error_element.removeClass("error_show").addClass("error"); }
                }
                if (!error_free) {
                    event.preventDefault();
                }
                else {
                    alert('No errors: Form will be submitted');
                }
            });
        });
      
        </script>
</body>
</html>
