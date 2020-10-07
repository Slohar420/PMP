<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Default/bootstrap.min.css" rel="stylesheet" />
    <link href="Default/font-awesome.min.css" rel="stylesheet" />
    <script src="Default/jquery.min.js"></script>
    <script src="Default/popper.min.js"></script>
    <script src="Default/bootstrap.min.js"></script>
    <script src="Default/sweetalert.min.js"></script>

    <link href="Dashboard/css/Design.css" rel="stylesheet" />
    <style>
        body {
            background-image: url("http://localhost:64591/Dashboard/images/background.png");
            background-repeat: no-repeat;
        }

        .box {
            width: 400px;
            height: 300px;
            background-color: #fff;
            padding: 1em 2em;
            border-bottom: 2px solid #ccc;
        }

        .btn {
            width: 50%;
        }

        .sweet-warning {
            background-color: navy;
            margin-right: 180px;
        }

            .sweet-warning:not([disabled]):hover {
                background-color: red;
            }

        .swal-modal {
            background-color: white;
            border-radius: 20px;
            border: solid 4px;
            border-color: red;
        }

        .sweet-warning1 {
            background-color: green;
            margin-right: 180px;
        }

            .sweet-warning1:not([disabled]):hover {
                background-color: white;
                color: black;
            }

        input.invalid, textarea.invalid {
            border: 2px solid red;
        }

        input.valid, textarea.valid {
            border: 2px solid green;
        }
    </style>

    <script>
        function InCorrectUserName() {
            swal({
                title: "You have entered an invalid username or password",
                icon: "error",
                customClass: 'swal-wide',
                buttons: {
                    confirm: { text: 'Ok', className: 'sweet-warning' },
                    cancel: { text: 'Delete', className: 'sweet-warning' },
                },
            })
        }
        function FirstTimeLogin() {
            swal({
                title: "You Are First Time Login Please Manage Profile Setting",
                icon: "success",
                buttons: {
                    confirm: { text: 'Ok', className: 'sweet-warning1' },
                    cancel: { text: 'Delete', className: 'sweet-warning1' },
                },
            }).then(function () {
                window.location.href = "ProfileSetting_User.aspx";
            })
        }
        function FirstTimeLoginAdmin() {
            swal({
                title: "You Are First Time Login Please Manage Profile Setting",
                icon: "success",
                buttons: {
                    confirm: { text: 'Ok', className: 'sweet-warning1' },
                    cancel: { text: 'Delete', className: 'sweet-warning1' },
                },
            }).then(function () {
                window.location.href = "ProfileSetting.aspx";
            })
        }

        function EmailValidation() {

            debugger;
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            var uname = $("#" + "<%=txtUserName.ClientID%>").val();
            debugger;
            if (!emailReg.test(uname)) {
                $("#lblError").css("display", "block");
                document.getElementById("lblError").innerHTML = "Please Enter Valid Mail Id";
                <%-- $("#" + "<%=txtDescription.ClientID%>").css("border", "2px solid red");--%>
                $("#" + "<%=txtUserName.ClientID%>").removeClass("valid").addClass("invalid");
                return false;
            }
            else {
             $("#" + "<%=txtUserName.ClientID%>").removeClass("invalid");
                $("#lblError").css("display", "none");
                return true;
            }
        }

        function TextValidation() {
            var uname = $("#" + "<%=txtUserName.ClientID%>").val();
            var pwd = $("#" + "<%=txtPwd.ClientID%>").val();
            if ($.trim(uname) == '') {
                $("#lblError").css("display", "block");
                document.getElementById("lblError").innerHTML = "Please Enter  Mail Id";
                <%-- $("#" + "<%=txtDescription.ClientID%>").css("border", "2px solid red");--%>
                $("#" + "<%=txtUserName.ClientID%>").removeClass("valid").addClass("invalid");
                return false;
            }
            else if ($.trim(pwd) == '') {
                $("#lblError").css("display", "block");
                document.getElementById("lblError").innerHTML = "Please Enter  Password";
                <%-- $("#" + "<%=txtDescription.ClientID%>").css("border", "2px solid red");--%>
                $("#" + "<%=txtPwd.ClientID%>").removeClass("valid").addClass("invalid");
                return false;
            }
            else if ($.trim(pwd) == '' && $.trim(uname) == '') {
                $("#lblError").css("display", "block");
                document.getElementById("lblError").innerHTML = "Please Enter Mail Id && Password";
                <%-- $("#" + "<%=txtDescription.ClientID%>").css("border", "2px solid red");--%>
                $("#" + "<%=txtPwd.ClientID%>").removeClass("valid").addClass("invalid");
                return false;
            }
            else {
                <%--$("#" + "<%=txtUserName.ClientID%>").removeClass("invalid").addClass("valid");--%>
                $("#lblError").css("display", "none");
                return true;
            }

        }

        function wrongUserNameAndPwd() {
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "You Are Enterd Wrong Email And Password";

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class=" row col-md-12" style="margin-top: 20px;">
            <div class="col-md-4" style="margin-left: 3%"></div>
            <div class="col-md-4">

                <div class="card" style="margin-top: 30%;">
                    <div class="card-header">
                        <img src="Dashboard/images/logo1.png" />
                        <h3><span style="color: #071176">Project</span><span style="color: #AB2231"> Management</span><span style="color: #071176"> System</span></h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Mail Id</label>
                            <asp:TextBox runat="server" onchange="EmailValidation();" AutoCompleteType="Disabled" autocomplete="off" class="form-control" ID="txtUserName" placeholder="Mail Id" />
                        </div>
                        <div class="form-group" style="margin-top: -10px">
                            <label for="exampleInputPassword1">Password</label>
                            <asp:TextBox runat="server" Type="Password" class="form-control" ID="txtPwd" placeholder="Password" />
                        </div>
                        <label id="lblError" style="color: red; margin-top: 10px"></label>
                        <div style="text-align: center; margin-top: 20px">
                            <asp:Button runat="server" ID="btnSubmit" OnClientClick="javascript:return TextValidation();" OnClick="btnLogin_Click" BackColor="#071176" class="btn btn-primary" Text="Login" />
                        </div>
                    </div>
                </div>
                <%--<h3 style="margin-top: 10px; color: #cc0000"><b><span style="color: #000080!important">Lipi</span></b> Data System <span style="color: #000080!important">Ltd</span> </h3>--%>
            </div>
        </div>
    </form>
</body>
</html>

