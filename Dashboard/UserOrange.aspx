<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserOrange.aspx.cs" Inherits="UserOrange" MasterPageFile="~/Dashboard/DSMaster.master" %>

<asp:Content ID="cont1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="cont2" ContentPlaceHolderID="mainContent" runat="server">   
    <link href="css/User/User.css" rel="stylesheet" />
  
    <div id="id01" class="modal  m-c-01">
      <%--  <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>--%>

        <asp:HiddenField runat="server" ID="hiddenID" Value="0" />
        <asp:HiddenField runat="server" ID="hdnfirstname" Value="0" />
        <div class="container">
            <div class="row">
                <div class="card" style="width: 80%; margin: 20px; margin-left: -70px">
                    <div class="card-header" style="background-color: #eee; text-align: left">
                        <h3 id="lblHeading" style="margin-left: 10px"><i class="fa fa-plus" style="margin-left: 10px; padding-left: 10px;"></i>Create New User</h3>
                    </div>
                    <div class="card-body">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw" style="padding-top: 10px"><b>First Name</b></label>
                                <asp:TextBox ID="txtFirstName" class="form-control" onchange="firstName(this);" placeholder="Enter First Name" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b>Last Name</b></label>
                                <asp:TextBox ID="txtLastName" class="form-control " onchange="LastName(this);" placeholder="Enter Last Name" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw" style="padding-top: 10px"><b>Employee Code</b></label>
                                <asp:TextBox ID="txtEmployeecode" class="form-control " onchange="EmployeeCode(this);" placeholder="Enter Employee Code" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b>Desgination</b></label>
                                <asp:TextBox ID="txtDesgination" class="form-control " onchange="Desgination(this);" placeholder="Enter Desgination" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw" style="padding-top: 10px"><b>Date Of Joning</b></label>
                                <asp:TextBox ID="txtDOJ" class="form-control " onchange="DateOfJoining(this);" type="date" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b>Experience</b></label>
                                <asp:TextBox ID="txtExperience" class="form-control " onchange="Experience(this);" placeholder="Enter Experience" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw" style="padding-top: 10px"><b>Skills</b></label>
                                <asp:TextBox ID="txtSkills" class="form-control " onchange="skills(this);" placeholder="Enter Skills" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b>Sallery</b></label>
                                <asp:TextBox ID="txtSallery" class="form-control " onchange="sallary(this);" placeholder="Enter Sallery" runat="server" MaxLength="30" onkeypress="return isNumber(event)" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b>Mail Id</b></label>
                                <asp:TextBox ID="txtMailId" class="form-control " onchange="EmailValidation();"  placeholder="Enter Mail Id" runat="server" MaxLength="30" onkeypress="return RestrictSpace()" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b>Role</b></label>
                                <asp:DropDownList runat="server" ID="ddlType" CssClass="form-control role">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                    <asp:ListItem>Admin</asp:ListItem>
                                    <asp:ListItem>Admin Testing</asp:ListItem>
                                    <asp:ListItem>User</asp:ListItem>

                                </asp:DropDownList>
                            </div>
                        </div>


                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-5 col-lg-5 col-sm-5 col-xs-5">
                                <label for="psw" style="padding-top: 10px"><b>Department</b></label>
                                <div id="divddlCategory">
                                    <asp:DropDownList runat="server" ID="ddlDepartment" CssClass="form-control department">
                                        <asp:ListItem Value="0">Select </asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div id="divtxtDepartment" style="display: none">
                                    <asp:TextBox ID="txtDepartment" class="form-control  " placeholder="Enter Department Name" runat="server"></asp:TextBox>
                                </div>

                            </div>
                            <div class="col-md-1 col-lg-1 col-sm-1 col-xs-1" style="margin-top: 30px;" id="divAddImage">
                                <button onclick="AddDepartment()" id="btnAddDepartment" type="button" class="addDepartment addDepartment1" style="width: auto; float: right; font-size: 15px">
                                    <img src="images/add.png" style="height: 30px; width: 30px;" /></button>
                            </div>
                            <div class="col-md-1 col-lg-1 col-sm-1 col-xs-1" style="margin-top: 30px; display: none" id="divMinusImage">
                                <button onclick="AddDepartmentHide()" id="btnAddDepartmentHide" type="button" class="addDepartment addDepartment1" style="width: auto; float: right; font-size: 15px">
                                    <img src="images/Minuse.png" style="height: 30px; width: 30px;" /></button>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw" style="padding-top: 10px"><b>User Type</b></label>
                                <asp:DropDownList runat="server" ID="ddlUserType" CssClass="form-control utype">
                                    <asp:ListItem Value="0">Select </asp:ListItem>
                                    <asp:ListItem>Project Leader</asp:ListItem>
                                    <asp:ListItem>Team Leader</asp:ListItem>
                                    <asp:ListItem>Developer </asp:ListItem>
                                    <asp:ListItem>Tester</asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <label id="lblError" style="color: red; display: none;    margin-left: 15px;"></label>
                        </div>
                    </div>

                    <div class="taskfooter">
                        <div class="clearfix">
                            <asp:Button runat="server" type="submit" ID="btnsubmit" OnClientClick="javascript:return TextValidation();" OnClick="btnsubmit_Click" UseSubmitBehavior="false" class="buttonTask1" Style="background-color: #337ab7" Text="Add" />
                            <asp:Button runat="server" type="submit" ID="btnupdate" OnClick="btnupdate_Click" UseSubmitBehavior="false" class="buttonTask" Style="background-color: #337ab7; display: none" Text="UPDATE" />
                            <button type="button" class="buttonTask">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
    <div class="slide_rht_con">
        <input type="hidden" id="role" value="">
        <input type="hidden" id="type" value="">
        <input type="hidden" id="user_srch" value="">
        <div class="proj_grids">
            <div class="tab tab_comon tab_task">
                <ul class="nav-tabs mod_wide">
                    <li id="task_li" class="active">
                        <a href="javascript:void(0);" >
                            <div class="usrr_actv fl"></div>
                            <div class="fl">Active<span class="counter">(<asp:Label runat="server" ID="lblUserCount" Text=""></asp:Label>)</span></div>
                            <div class="cbt"></div>
                        </a>
                    </li>
                    <!--<li id="file_li" class="active" >
                <a href="javascript:void(0);" onclick="filterUserRole('invited','');">
                <div class="usrr_invt fl"></div>
                <div class="fl">Invited<span class="counter">()</span></div>
                <div class="cbt"></div>
                </a>
            </li>-->
                  <%--  <li id="task_li">
                        <a href="UserDeativepage.aspx" onclick="filterUserRole(&#39;disable&#39;,&#39;&#39;);">
                            <div class="usrr_disbl fl"></div>
                            <div class="fl">Disabled<span class="counter">(1)</span></div>
                            <div class="cbt"></div>
                        </a>
                    </li>--%>
                    <div class="cbt"></div>
                </ul>
            </div>


            <div class="col-lg-12 user_div m-left-20" id="thumbnail">

                <div class="col-lg-4">
                    <div class="col-lg-12 contain new_prjct user_inv text-centre">
                        <a href="javascript:void(0);" class="adduser" style="display: block !important; padding: 55px;">
                            <div class="icon-projct-gridvw">
                                <img src="images/add.png" style="height: 60px; width: 60px;" />
                            </div>
                            Add Users
                            <%--<button onclick="document.getElementById('id01').style.display='block'" type="button" class="btn btn-block" style="width: auto; float:right; background-color: #337ab7; font-size: 15px">Add<span class="fa fa-plus" style="margin-left: 5px; font-size: 10px; padding: 5px"></span></button>--%>
                        </a>
                    </div>
                </div>


                <input type="hidden" id="is_invited_user" value="0">
            </div>

            <div class="cbt"></div>
            <input type="hidden" id="getcasecount" value="4" readonly="true">
            <div class="tot-cs fr">
                <div class="sh-tot-cs">
                    1 - 4 of 4   
                </div>
                <div class="pg-ntn">
                    <ul class="pagination">
                    </ul>
                </div>
            </div>
            <input type="hidden" id="totalcount" name="totalcount" value="5">
        </div>
        <div id="projectLoader">
            <div class="loadingdata">Sending invitation again...</div>
        </div>
    </div>


    <!--Modal-->
    <div id="id02" class="modal  m-c-02">
       <%-- <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>--%>

        <div class="container" style="margin-top: 30px;">
            <div class="row">
                <div class="card" style="width: 80%; margin-left: -60px">
                    <div class="card-header" style="background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(198,228,255,1) 0%, rgba(229,249,252,1) 58%, rgba(103,231,255,1) 100%); color: Highlight; text-align: left;">
                        <h4 style="margin-left: 10px">Edit User  <small style="color: darkgray">></small><asp:Label runat="server" ID="lblProjectname"></asp:Label></h4>
                    </div>
                    <div class="card-body">
                        <asp:Button ID="btPopupLoad" runat="server" Text="Load"
                            CssClass="button" Style="display: none;" />
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <div class="card" style="overflow-y: auto; max-height: 100px;">
                                    <div class="card-body" style="padding: 0 0;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6">
                                <label for="psw-repeat" style="padding-top: 10px"><b></b></label>
                                <div class="card" style="overflow-y: auto; max-height: 100px;">
                                    <div class="card-body" style="padding: 0 0;">
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>

                    <div class="taskfooter">
                        <div class="clearfix">
                            <asp:Button runat="server" type="submit" ID="btnAddUser" class="buttonTask" Style="background-color: #337ab7" Text="Add" />
                            <button type="button" onclick="document.getElementById('id02').style.display='none'" class="buttonTask">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>





    <!-- Footer ends -->




    <script type="text/javascript" src="Project_files/jquery-ui-1.9.2.custom.min.js.download"></script>
    <script src="js/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="Project_files/script.js.download"></script>
    <script src="js/script.js"></script>

    <!-- Dropbox ends-->

    <!-- Google drive starts-->
    <script type="text/javascript">
        var CLIENT_ID = "XXXXXXXXXXXX.apps.googleusercontent.com";
        var REDIRECT = "http://172.16.4.105:8080/orangescrum-master/users/googleConnect";
        var API_KEY = "xXxXXxxxxxXXXXXXXXXXXXXxXXxxxx";
        var DOMAIN_COOKIE = "172.16.4.105";
    </script>
    <script type="text/javascript" src="Project_files/google_drive.js.download"></script>
    <script src="js/google_drive.js"></script>
    <script type="text/javascript" src="Project_files/google_contact.js.download"></script>
    <script src="js/google_contact.js"></script>
    <script src="Project_files/jsapi"></script>
    <a href="js/jsapi">js/jsapi</a>
    <script src="Project_files/client.js.download" gapi_processed="true"></script>
    <script src="js/client.js"></script>
    <!-- Google drive ends-->

    <script type="text/javascript" src="Project_files/fileupload.js.download"></script>
    <script src="js/fileupload.js"></script>


    <style>
       
    </style>
    <script type="text/javascript" src="Project_files/pace.min.js.download"></script>   
    <script src="js/User/User.js"></script>
</asp:Content>
