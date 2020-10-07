function OnError(error) {
    swal({
        title: error,
        icon: "error",
        customClass: 'swal-wide',
        buttons: {
            confirm: { text: 'Ok', className: 'sweet-warning' },
            cancel: { text: 'Delete', className: 'sweet-warning' },
        },
    })
}
function Success(add) {
    swal({
        title: add,
        icon: "success",
        customClass: 'swal-wide',
        buttons: {
            confirm: { text: 'Ok', className: 'sweet-warning' },
            cancel: { text: 'Delete', className: 'sweet-warning' },
        }
    }).then(function () {
        window.location = "UserOrange.aspx";
    });
} function Warning(msg) {
    debugger;
    swal({
        title: msg,
        icon: "warning",
        customClass: 'swal-wide',
        buttons: {
            confirm: { text: 'Ok', className: 'sweet-warning' },
            cancel: { text: 'Delete', className: 'sweet-warning' },
        },
    })
} 
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
//User Creation Validation Script Start // 
function firstName(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtFirstName").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter First Name";
        return false;
    }
    else {
        $("#mainContent_txtFirstName").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function LastName(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtLastName").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Last Name";
        return false;
    }
    else {
        $("#mainContent_txtLastName").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function EmployeeCode(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtEmployeecode").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Employee Code";
        return false;
    }
    else {
        $("#mainContent_txtEmployeecode").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function Desgination(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtDesgination").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Desgination";
        return false;
    }
    else {
        $("#mainContent_txtDesgination").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function DateOfJoining(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtDOJ").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Date Of Joining";
        return false;
    }
    else {
        $("#mainContent_txtDOJ").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function Experience(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtExperience").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Experience";
        return false;
    }
    else {
        $("#mainContent_txtExperience").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function skills(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtSkills").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Skills";
        return false;
    }
    else {
        $("#mainContent_txtSkills").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}
function sallary(e) {
    if ($.trim(e.value) == '') {
        $("#mainContent_txtSallery").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Sallry";
        return false;
    }
    else {
        $("#mainContent_txtSallery").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}

function EmailValidation() {  
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    var uname = $("#mainContent_txtMailId").val();
    debugger;
    if (!emailReg.test(uname)) {
        $("#mainContent_txtMailId").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Mail Id";
        return false;
    }
    else {
        $("#mainContent_txtMailId").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
}

$(".role").change(function () {  
    if ($('.role option:selected').val() == 0) {       
        $(".role").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Role";
        return false;
    }
    else {
        $(".role").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
})
$(".department").change(function () {
  
    if ($('.department option:selected').val() == 0) {
        $(".department").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Department";
        return false;
    }
    else {
        $(".department").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
})
$(".utype").change(function () {
    if ($('.utype option:selected').val() == 0) {
        $(".utype").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select User Type";
        return false;
    }
    else {
        $(".utype").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
})
function TextValidation() {   
    debugger;
    var fname = document.getElementById("mainContent_txtFirstName").value;
    var lastname = document.getElementById("mainContent_txtLastName").value;
    var employeecode = document.getElementById("mainContent_txtEmployeecode").value;
    var desgination = document.getElementById("mainContent_txtDesgination").value;
    var DOJ = document.getElementById("mainContent_txtDOJ").value;
    var experince = document.getElementById("mainContent_txtExperience").value;
    var skills = document.getElementById("mainContent_txtSkills").value;
    var sallery = document.getElementById("mainContent_txtSallery").value;
    var mailid = document.getElementById("mainContent_txtMailId").value;
    var role = document.getElementById("mainContent_ddlType").value;
    var department = document.getElementById("mainContent_ddlDepartment").value;
    var usertype = document.getElementById("mainContent_ddlUserType").value;
   
    if ($.trim(fname) == '') {
        $("#mainContent_txtFirstName").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter First Name";
        return false;
    }
    else if ($.trim(lastname) == '') {
        $("#mainContent_txtLastName").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Last Name";
        return false;
    }
    else if ($.trim(employeecode) == '') {
        $("#mainContent_txtEmployeecode").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Employee Code";
        return false;
    }
    else if ($.trim(desgination) == '') {
        $("#mainContent_txtDesgination").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Desgination";
        return false;
    }
    else if ($.trim(DOJ) == '') {
        $("#mainContent_txtDOJ").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Date Of Joining";
        return false;
    }
    else if ($.trim(experince) == '') {
        $("#mainContent_txtExperience").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Experience";
        return false;
    }
    else if ($.trim(skills) == '') {
        $("#mainContent_txtSkills").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Skills";
        return false;
    }
    else if ($.trim(sallery) == '') {
        $("#mainContent_txtSallery").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Sallary";
        return false;
    }
    else if ($.trim(mailid) == '') {
        $("#mainContent_txtMailId").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Mail Id";
        return false;
    }
    else if ($.trim(role) == '0') {
        $("#mainContent_ddlType").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Role";
        return false;
    }
    else if ($.trim(department) == '0') {
        $("#mainContent_ddlDepartment").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Deaprtment";
        return false;
    }
    else if ($.trim(usertype) == '0') {
        $("#mainContent_ddlUserType").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select User Type";
        return false;
    }
    else {
        $("#lblError").css("display", "none");
        return true;
    }
}

//Open Create User on MasterPage Create  Button Click Script Start//
$(document).ready(function () {
    $(".create .createspan").text("Create User");
    var toOpenCUModal = localStorage.getItem("openCreateUserModal");

    if (toOpenCUModal == "true") {

        $(".m-c-01").show("slide", { direction: "left" }, 0);
        localStorage.setItem("openCreateUserModal", "false");
    }
    $(".create .createspan").click(function () {

        if ($(this).text() == "Create User") {
            $(".m-c-01").show("slide", { direction: "left" }, 0);
        }
    });
});
//Open Create User on MasterPage Create  Button Click Script End//
loadUsers();
// Get the modal
var modal = document.getElementById('id01');
$(".m-c-01").hide("slide", { direction: "left" }, 0);
$("#lblHeading").text("Create User");

//Click on Delete User Script Start//
$(document).on("click", ".icon-remprj-usr ", function () {

    var prompt = confirm("Do you want to delete?");
    if (prompt) {
        var id = $(this).parent().parent().parent().parent().find(".hidden").text();
        $.ajax({
            type: "POST",
            url: "USerOrange.aspx/deleteUser", //It calls our web method  
            contentType: "application/json; charset=utf-8",
            data: "{id:'" + id + "'}",
            dataType: "json",
            success: function (data) {
                alert(data.d);
                window.location.href = "UserOrange.aspx";
            },
            failure: function (error) {
                alert(error);
            }
        });
    } else {
        return;
    }
});
//Click on Delete User Script End//

//Click on edit user Script Start//
$(document).on("click", ".icon-edit-temp-task ", function () {  //MARK:- Edit button click
    //$("#id02").css("display", "block");
    debugger;
    $("#lblHeading").text("Edit User");
    var id = $(this).parent().parent().parent().find(".hidden").text();

    $("#mainContent_hiddenID").val(id);
    $.ajax({
        type: "POST",
        url: "USerOrange.aspx/editUser", //It calls our web method  
        contentType: "application/json; charset=utf-8",
        data: "{id:'" + id + "'}",
        dataType: "json",
        success: function (data) {
            debugger;
            var employee = data.d;
            var firstname = employee.FullName.split(" ")[0];
            var lastname = employee.FullName.split(" ")[1];

            $("#id01").show("slide", { direction: "left" }, 0);
            //$("#id01").css("display", "block");
            $("#mainContent_btnsubmit").css("display", "none");
            $("#mainContent_btnupdate").css("display", "inline-grid");
            $("#mainContent_txtFirstName").val(firstname);
            $("#mainContent_txtLastName").val(lastname);
            $("#mainContent_txtSallery").val(employee.Salary);
            $("#mainContent_txtSkills").val(employee.Skills);
            $("#mainContent_txtDesgination").val(employee.Desgination);
            $("#mainContent_txtExperience").val(employee.Experince);
            $("#mainContent_txtMailId").val(employee.Email);
            $("#mainContent_txtEmployeecode").val(employee.EmployeeCode);
            $("#mainContent_ddlType").val(employee.Role);

            var d = new Date(employee.JoningDate);
            $("#mainContent_txtDOJ").val(d.getFullYear() + "-" + zeroPadded(d.getMonth() + 1) + "-" + zeroPadded(d.getDate()));

        },
        failure: function (error) {
            alert(error);
        }
    });
});

//Click on edit user Script Start//
function zeroPadded(val) {
    if (val >= 10)
        return val;
    else
        return '0' + val;
}


$(document).on("mouseenter", ".proj_mng_div .contain ", function () {
    var userrole = $("#userrole").val();
    if (userrole == "admin") {
        $(this).find(".proj_mng").stop(true, true).animate({
            bottom: "0px",
            opacity: 1
        }, 400);
    }
});

$(document).on("mouseleave", ".proj_mng_div .contain ", function () {
    $(this).find(".proj_mng").stop(true, true).animate({
        bottom: "-42px",
        opacity: 0
    }, 400);
});
function loadUsers() {

    $.ajax({
        type: "POST",
        url: "USerOrange.aspx/getUsers", //It calls our web method  
        contentType: "application/json; charset=utf-8",
        data: "{}",
        dataType: "json",
        success: function (data) {
            //var html = document.getElementById("htmlcard1").innerHTML;
            //html = html.replace(/"/g, "'");
            //debugger;
            var i = 0;
            var newhtml = "";
            $.each(data.d, function (key, val) {
                var projects = val.projects.slice(0, -2);
                newhtml += "<div class='col-lg-4 proj_mng_div'><div class='col-lg-12 contain usr_mng_div' style='position: relative;'><span class='hidden' style='display:false' >" + val.id + "</span><div class='usr_block'><div class='label user-usr fl' style='padding: 3px; text-align: center !important; width: 96px;'>" + val.userrole + "</div><div class='fl mgl14'><div class='nm'>" + val.name + "</div><div class='usr_email' title='" + val.email + "'>" + val.email + "</div></div><div class='cbt'></div></div><div class='user-details'><div class='fl usr_lt'><div class='user-image'><img class='lazy'  width='94' height='94' src='Project_files/saved_resource.png' style='display: inline;'></div><div class='user-nm'>" + val.usershortname + "</div></div><div class='fl usr_rt'><div class='border_usr usr_email'>Last Activity:</div><div class='usr_email'>" + val.lastactivity + "</div><div class='border_usr usr_email'></div><div class='usr_email'></div></div><div class='cbt'></div></div><div class='nm_prj' id='remain_prj_4'>Projects: <span class='fnt13' style=font-weight:600;>" + projects.toUpperCase() + "</span></div><div class='proj_mng' style='bottom: -42px; opacity: 0;padding:0;'><div class='col-md-6'><span data-usr-id='4' style='width:100%;padding:19px 0 0px 40px;'  class='icon-edit-temp-task fl edit-user' data-usr-name='Invite'>Edit</span></div><div class='col-md-6' style='padding:0 0 10px 0;'><input id='rmv_allprj_4' type='hidden' value=' Digital Signage'><span id='rmv_prj_4'><br><a class='icon-remprj-usr' href='javascript:void(0);' data-usr-id='4' data-usr-name='Invite' data-total-project='1'>Delete</a></span></div></div></div></div></div>";
            });
            $("#thumbnail").append(newhtml);
        },
        failure: function (error) {
            alert(error);
        }
    });
}
var DepartmentModal = document.getElementById('id02');

window.onclick = function (evnet) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
function AddDepartment() {
    document.getElementById('divtxtDepartment').style.display = 'block';
    document.getElementById('divddlCategory').style.display = 'none';
    document.getElementById('btnAddDepartment').style.display = 'none';
    document.getElementById('divMinusImage').style.display = 'block';
    document.getElementById('divAddImage').style.display = 'none';
}
function AddDepartmentHide() {
    document.getElementById('divtxtDepartment').style.display = 'none';
    document.getElementById('divddlCategory').style.display = 'block';
    document.getElementById('btnAddDepartment').style.display = 'block';
    document.getElementById('divMinusImage').style.display = 'none';
    document.getElementById('divAddImage').style.display = 'block';
}
$(".adduser").click(function () {

    $(".m-c-01").show("slide", { direction: "left" }, 0);
});

$(".icon-edit-temp-task").click(function () {
    alert();
    $(".m-c-02").show("slide", { direction: "left" }, 0);
});

$(".icon-projct-gridvw").click(function () {
    $(".slide_rht_con ").show("slide", { direction: "left" }, 500, function () {
        $(".m-c-01").hide("slide", { direction: "right" }, 500);
    });

});
$(".buttonTask").click(function () {
    $("#lblError").css("display", "none");
    $("#mainContent_txtFirstName").val("").css("border","1px solid #ccc");
    $("#mainContent_txtLastName").val("").css("border", "1px solid #ccc");
    $("#mainContent_txtEmployeecode").val("").css("border", "1px solid #ccc");
    $("#mainContent_txtDesgination").val("").css("border", "1px solid #ccc");
    $("#mainContent_txtExperience").val("").css("border", "1px solid #ccc");
    $("#mainContent_txtSkills").val("").css("border", "1px solid #ccc");
    $("#mainContent_txtSallery").val("").css("border", "1px solid #ccc");
    $("#mainContent_txtMailId").val("").css("border", "1px solid #ccc");
    $("#mainContent_ddlType").val('0').css("border", "1px solid #ccc");
    $("#mainContent_ddlDepartment").val('0').css("border", "1px solid #ccc");
    $("#mainContent_ddlUserType").val('0').css("border", "1px solid #ccc");
    $(".m-c-01").hide("slide", { direction: "right" }, 0);
});
//When Click Out Side the Modal then Stop Exit//
