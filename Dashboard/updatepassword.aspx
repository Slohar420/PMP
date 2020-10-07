<%@ Page Language="C#" AutoEventWireup="true" CodeFile="updatepassword.aspx.cs" Inherits="Dashboard_updatepassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="SweetAlert/sweetalert.min.js"></script>
    <style>
        /*body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}*/

        /* Full-width input fields */
        input[type=text], input[type=password] {
            width: 97%;
            padding: 15px;
            margin: 5px 0 22px 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
        }

            /* Add a background color when the inputs get focus */
            input[type=text]:focus, input[type=password]:focus {
                background-color: #ddd;
                outline: none;
            }

        /* Set a style for all buttons */
        button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            opacity: 0.9;
        }

        .button1 {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            opacity: 0.9;
        }

        button:hover {
            opacity: 1;
        }

        .button1:hover {
            opacity: 1;
        }

        /* Extra styles for the cancel button */
        .cancelbtn {
            padding: 14px 20px;
            background-color: #f44336;
        }

        /* Float cancel and signup buttons and add an equal width */
        .cancelbtn, .signupbtn {
            float: left;
            width: 50%;
        }

        /* Add padding to container elements */
        .container {
            padding: 16px;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: #474e5d;
            padding-top: 50px;
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */
        }

        /* Style the horizontal ruler */
        hr {
            border: 1px solid #f1f1f1;
            margin-bottom: 25px;
        }

        /* The Close Button (x) */
        .close {
            position: absolute;
            right: 35px;
            top: 15px;
            font-size: 40px;
            font-weight: bold;
            color: #f1f1f1;
        }

            .close:hover,
            .close:focus {
                color: #f44336;
                cursor: pointer;
            }

        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

        /* Change styles for cancel button and signup button on extra small screens */
        @media screen and (max-width: 300px) {
            .cancelbtn, .signupbtn {
                width: 100%;
            }
        }
        .hide {
            display:none;
        }
    </style>
    <link href="css/Design.css" rel="stylesheet" />
    <script>

        function Success(add) {
            swal({
                title: add,
                icon: "success",
                customClass: 'swal-wide',
                buttons: {
                    confirm: { text: 'Ok', className: 'sweet-warning' },
                    cancel: { text: 'Delete', className: 'sweet-warning' },
                },
            }).then(function () {
                window.location = "Dashboard.aspx";
            });
        }
        function Failed(add) {
            swal({
                title: add,
                icon: "error",
                customClass: 'swal-wide',
                buttons: {
                    confirm: { text: 'Ok', className: 'sweet-warning' },
                    cancel: { text: 'Delete', className: 'sweet-warning' },
                },
            })
        }
        function Warning(add) {
            swal({
                title: add,
                icon: "warning",
                customClass: 'swal-wide',
                buttons: {
                    confirm: { text: 'Ok', className: 'sweet-warning' },
                    cancel: { text: 'Delete', className: 'sweet-warning' },
                },
            })
        }
    </script>
    <script type="text/javascript">
        function fn_validateNumeric() {
            if (window.event) keycode = window.event.keyCode;
            else if (e) keycode = e.which;
            else return true;
            if (((keycode >= 65) && (keycode <= 90)) || ((keycode >= 97) && (keycode <= 122))) {
                return true;
            }
            else {
                return false;
            }
        }



    </script>
    <script type="text/javascript">
        function RestrictSpace() {
            if (event.keyCode == 32) {
                return false;
            }
        }

    </script>
    <script>
        function Delete(UserId) {
               
            swal({
                title: "Are you sure?",
                text: "Once deleted, you will not be able to recover this Project Type !",
                icon: "warning",
                buttons: true,
                dangerMode: true,               
            })
           .then((willDelete) => {
               if (willDelete) {
                   PageMethods.RegisterUser(UserId, onSucess, onError);
                   function onSucess(result) {
                       swal(result, {
                           icon: "success",
                       }).then(function () {
                           window.location = "UserManage.aspx";
                       })
                   }
                   function onError(result) {
                       swal(result, {
                           icon: "error",
                       }).then(function () {
                           window.location = "UserManage.aspx";
                       })
                   }
               } else {
                   swal("Your File is safe!");
               }
           });         
            //document.location.reload();
          }
      </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <section class="content">
          <div class="container">
                    <div class="row">
                         <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">    
                             
                             <div class="col-lg-6 col-sm-12 col-md-6 col-xs-12" >
                                 <div class="card" style=" margin: 20px; margin-left:-150px">
                            <div class="card-header" style="background-color:#eee; text-align:left; ">
                                <h3 style="margin-left:20px">Reset Password</h3>
                            </div>
                            <div class="card-body">
                                <label for="psw"><b>New Password</b></label>
                                <asp:TextBox ID="txtPwd" class="form-control " style="width:97%" TextMode="Password" placeholder="Enter Password" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>

                                <label for="psw-repeat"><b>Confirm Password </b></label>
                                <asp:TextBox ID="txtConfirmPwd" class="form-control " style="width:97%" TextMode="Password" placeholder="Enter Confirm Password" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                               
                                <div class="clearfix">
                                    <asp:Button runat="server" type="submit" ID="btnsubmit" OnClick="btnsubmit_Click" class="signupbtn button1" Style="background-color: #337ab7" Text="Update" />
                                    <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Clear</button>
                                </div>
                            </div>
                        </div>
                              </div>
                          </div>    
                        
                    </div>

                </div>
      
        <script>
            // Get the modal
            var modal = document.getElementById('id01');

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>
    </section>
    </div>
    </form>
</body>
</html>
