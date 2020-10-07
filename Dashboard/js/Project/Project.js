//In This Js File All Script of Project Page///

$(document).ready(function () {
    function showmodal() {
        var ele = document.getElementById("popup_bg");
        ele.style.display = "block";
    }
    function hidemodal() {
        var ele = document.getElementById("popup_bg");
        ele.style.display = "none";
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
            window.location = "Projects.aspx";
        });
    }
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
});
//Validation Create Project  Script Start//

function TextValidation() {
    debugger;
    var pname = $("#mainContent_txtProjectName").val();
    var ptype = $("#mainContent_ddlptype").val();
    var pstype = $("#mainContent_ddlsubtype").val();
    var pduedate = $("#mainContent_txtduedate").val();
    var pprojectmanager = $("#mainContent_ddlprojectmanager").val();
    var psource = $("#mainContent_txtSource").val();
    var plistmember = $("#mainContent_listmembers").val();
    var pdiscription = $("#mainContent_txtDescription").val();


    if ($.trim(pname) == '') {
        $("#mainContent_txtProjectName").addClass("invalid");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Project Name";
        return false;
    }
    else if ($.trim(ptype) == '0') {
        $("#mainContent_ddlptype").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Project Type";
        return false;
    }
    else if ($.trim(pstype) == '0') {
        $("#mainContent_ddlsubtype").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Project Sub Type";       
        return false;
    }
    else if ($.trim(pduedate) == '') {
        $("#mainContent_txtduedate").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Due Date";
        return false;
    }
    else if ($.trim(pprojectmanager) == '0') {
        $("#mainContent_ddlprojectmanager").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Project Manager";
        return false;
    }
    else if ($.trim(psource) == '') {
        $("#mainContent_txtSource").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Project Source";
        return false;
    }
    else if ($.trim(plistmember) == '') {
        $("#mainContent_listmembers").siblings().find("span").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Select Team Member";
        return false;
    }
    else if ($.trim(pdiscription) == '') {
        $("#mainContent_txtDescription").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Description";

        return false;
    }
    else if (pdiscription.length < 200) {
        $("#mainContent_txtDescription").css("border", "2px solid red");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Minimum 200 word Description";
        return false;
    }
    else {
        return true;
    }
}
function checkLength() {

    var tDescription = $("#mainContent_txtDescription").val();

    if ($.trim(tDescription) == '') {
        $("#mainContent_txtDescription").removeClass("valid").addClass("invalid");
    } else if (tDescription.length < 200) {
        $("#mainContent_txtDescription").removeClass("valid").addClass("invalid");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Minimum 200 word Description";
    }
    else if (tDescription.length > 1500) {
        $("#mainContent_txtDescription").removeClass("valid").addClass("invalid");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Description Between 200 to 1500  Word ";
    }
    else {
        $("#mainContent_txtDescription").removeClass("invalid");
        $("#lblError").css("display", "none");
    }

}

function pname(e) {  
    if ($.trim(e.value) == '') {       
        $(".pname").removeClass("valid").addClass("invalid");        
    }
    else {
        $(".pname").removeClass("invalid");
        $("#lblError").css("display", "none");
    }
}
function psource(e) {
   
    if ($.trim(e.value) == '') {
        $(".p-source").removeClass("valid").addClass("invalid");
    }
    else {
        $(".p-source").removeClass("invalid");
        $(".p-source").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
    }
} 

$('.ptype').change(function () {     
    
    if ($('.ptype option:selected').text() == "Select Project Type") {
        //$(".pname").removeClass("valid").addClass("invalid");
        $(".ptype").css("border", "2px solid red");
    }
    else {
        $(".ptype").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
    }
});

$('.p-s-type').change(function () {

    if ($('.p-s-type option:selected').text() == "Select") {
        //$(".pname").removeClass("valid").addClass("invalid");
        $(".p-s-type").css("border", "2px solid red");
    }
    else {
        $(".p-s-type").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
    }
});

$('.p-manager').change(function () {

    if ($('.p-manager option:selected').text() == "Select Manager") {
        //$(".pname").removeClass("valid").addClass("invalid");
        $(".p-manager").css("border", "2px solid red");
    }
    else {
        $(".p-manager").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
    }
});
$('.due-date').change(function () {
    if ($('.due-date').val() == "") {
        $("#lblError").css("display", "block");
        $(".due-date").css("border", "2px solid red");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Select Due Date";
        return false;
    }
    else {
        $(".due-date").css("border", "1px solid #ccc");
        $("#lblError").css("display", "none");
        return true;
    }
});
$("#team").change(function () {
    if ($("#mainContent_listmembers").siblings().find("span").find("span").text().length != 0)
        $("#mainContent_listmembers").siblings().find("span").css("border", "1px solid #ccc");
    else
        $("#mainContent_listmembers").siblings().find("span").css("border", "2px solid red");
});
//Validation Create Project Script End//

//Project Testing Submit Script Start //
function ProjectTestingSubmit() {
    debugger;
    var tDescription = $("#mainContent_txtExpenseDescriptionTesting").val();
    if ($('.t-leader option:selected').text() == "Select Testing Leader")
    {
        $('.t-leader').css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Select Testing Leader";
        return false;
    }
    else if (tDescription.length > 250) {
        $("#mainContent_txtExpenseDescriptionTesting").removeClass("valid").addClass("invalid");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Description Between 0 to 250  Word ";
        return false;
    }
    else {
        return true;
    }
}
function projectTestingExpenseDesc(e) {
   
    if (e.value.length > 250) {
        $("#mainContent_txtExpenseDescriptionTesting").css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Expense Description Between 0 to 250  Word ";
    }
    else {
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtExpenseDescriptionTesting").css("border", "1px solid #ccc");
        return true;
    }
}
$('.t-leader').change(function () {
    debugger;
    if ($('.t-leader option:selected').text() == "Select Testing Leader") {
        $("#lblErrorSubmitt").css("display", "block");
        $('.t-leader').css("border", "2px solid red");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Select Testing Leader";
      
        return false;
    }
    else {
        $('.t-leader').css("border", "1px solid #ccc");
        $("#lblErrorSubmitt").css("display", "none");
        return true;
    }
})
//Project Testing Submit Script End //

//Project Suspend Script Start //
function ProjectSuspend() {

    var reson = $("#mainContent_txtSuspendReson").val();
    var tExpenseDescription = $("#mainContent_txtExpesneDescription").val();
    if ($.trim(reson) == '') {
        $("#mainContent_txtSuspendReson").css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Reason";
        return false;
    } 
    else if (reson.length < 200) {
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Minimum 200 word Reason";
        $("#mainContent_txtSuspendReson").css("border", "2px solid red");
        return false;
    }
    else if (reson.length > 500) {
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Reason Between 200 to 500  Word";
        $("#mainContent_txtSuspendReson").css("border", "2px solid red");;
        return false;
    }
    else if (tExpenseDescription.length > 250) {
        $("#mainContent_txtExpesneDescription").css("border", "2px solid red");;
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Description Between 0 to 250  Word ";
        return false;
    }
    else {
        return true;
    }
}
function chkLength(e) {
    debugger;
    if (e.value.length < 200 ) {
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Minimum 200 Word Resion";
        $("#mainContent_txtSuspendReson").css("border", "2px solid red");
        return false;
    }
    else if (e.value.length > 500) {
            $("#lblErrorSubmitt").css("display", "block");
            document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Reason Between 200 to 500  Word";
            $("#mainContent_txtSuspendReson").css("border", "2px solid red");
            return false;
        }
    else {
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtSuspendReson").removeClass("invalid").css("border","1px solid #ccc");
        return true;
    }    
}
function projectSuspendExpenseDesc(e) {    
    if (e.value.length > 250) {
        $("#mainContent_txtExpesneDescription").css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Expense Description Between 0 to 250  Word ";
        return false;
    }
    else {
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtExpesneDescription").css("border", "1px solid #ccc");
        return true;
    }
}
//Project Suspend Script End //

//Project Final Submit Script Start //
function ProjectFinalSubmitt() {

    var reson = $("#mainContent_txtFinalSubmisionDescription").val();
    var expense = $("#mainContent_txtFinalSubmisionExpenseDescription").val();
    
    if ($.trim(reson) == '') {
        $("#lblErrorSubmitt").css("display", "block");
        $("#mainContent_txtFinalSubmisionDescription").css("border", "2px solid red");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Conclusion";
        return false;
    }
    else if (reson.length < 200) {
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Minimum 200 Word Conclusion";
        $("#mainContent_txtFinalSubmisionDescription").css("border", "2px solid red");
        return false;
    }
    else if (reson.length > 500) {
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Conclusion Between 200 to 500  Word";
        $("#mainContent_txtFinalSubmisionDescription").css("border", "2px solid red");
        return false;
    }
    else if (expense.length > 250) {
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Expenses Between 0 to 250  Word";
        $("#mainContent_txtFinalSubmisionExpenseDescription").css("border", "2px solid red");
        return false;
    }
    else {
        return true;
    }
}
function chkConclusionLength(e) {
    if (e.value.length < 200) {
        $("#mainContent_txtFinalSubmisionDescription").css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Minimum 200 Word Conclusion";        
        return false;
    }
    else if (e.value.length > 500) {
        $("#mainContent_txtFinalSubmisionDescription").css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Conclusion Between 200 to 500  Word";        
        return false;
    }
    else {
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtFinalSubmisionDescription").removeClass("invalid").css("border","1px solid #ccc");
        return true;
    }
}
function FinalSubmitExpense(e) {
     if (e.value.length > 250) {
         $("#mainContent_txtFinalSubmisionExpenseDescription").css("border", "2px solid red");
        $("#lblErrorSubmitt").css("display", "block");
        document.getElementById("lblErrorSubmitt").innerHTML = "Please Enter Expenses Between 0 to 250  Word";
        return false;
    }
    else {
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtFinalSubmisionExpenseDescription").removeClass("invalid").css("border", "1px solid #ccc");
        return true;
    }
}
//Project Final Submit Script End //
function chkLengthEditProject(e) {
     
    if (e.value.length < 200) {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Enter Minimum 200 Word Description";
        $("#mainContent_txtEditDescription").removeClass("valid").addClass("invalid");
        return false;
    }   
    else {
        $("#lblErrorEdit").css("display", "none");
        $("#mainContent_txtEditDescription").removeClass("invalid").addClass("valid");
        return true;
    }
}
function EditProjectValidate() {
    debugger;
    var reson = $("#mainContent_txtEditDescription").val();
    var ptype = $("#mainContent_ddlEditProjectType").val();
    var pstype = $("#mainContent_ddlEditProjectSubType").val();
    var pduedate = $("#mainContent_txtEditDueDate").val();
    var pmanager = $("#mainContent_ddlEditProjectManager").val();
    var psource = $("#mainContent_txtEditProjectSource").val();
    if (ptype == "0") {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Select Project Type";
        return false;
    }
    else if (pstype == "0") {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Select Project Sub Type";
        return false;
    }
    else if ($.trim(pduedate) == '') {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Enter Due Date";
        return false;
    }
    else if (pmanager == "0") {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Select Project Manager";
        return false;
    }
    else if ($.trim(psource) == '') {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Enter Source";
        return false;
    }
    else if (reson.length < 200) {
        $("#lblErrorEdit").css("display", "block");
        document.getElementById("lblErrorEdit").innerHTML = "Please Enter Minimum 200 word Description";
        $("#mainContent_txtSuspendReson").removeClass("valid").addClass("invalid");
        return false;
    }
    else {
        $("#lblErrorEdit").css("display", "none");
        return true;
    }
}



// Click On Submitt Project Code Start///
    $(document).on("click", ".proj_mng_div .contain .proj_mng .icon-disable-usr", function () {
        
        $("#id05").show("slide", { direction: "left" }, 0);
        $("#divTesting").css("display", "block");
        $("#divSuspend").css("display", "none");
        $("#divFinalSubmit").css("display", "none");      

        $("#tabTesting").addClass("active");
        $("#tabSuspend").removeClass("active");
        $("#tabFinalSubmit").removeClass("active");

        $("#divBtnTestingSubmitt").css("display", "block");
        $("#divBtnSuspend").css("display", "none");
        $("#divBtnFinalSubmitt").css("display", "none");

        var projectname = $(this).parent().parent().parent().parent().find(".prj_name a").text();
        debugger;
        var res = projectname.split("#");

        $("#mainContent_lblHeadProjectName").text(res[0]);
        $("#mainContent_txtheadProjectName").val(res[1]);
        //$("#" + '<%= txtEditProjectName.ClientID%>').val("");
        //$("#" + '<%= ddlEditProjectType.ClientID%>').val("");
        //$("#" + '<%= ddlEditProjectSubType.ClientID%>').val("");
        //$("#" + '<%= txtEditProjectSource.ClientID%>').val("");
        //$("#" + '<%= txtEditDescription.ClientID%>').val("");

        $(function () {

            $.ajax({
                type: "POST",
                url: "Projects.aspx/editProject",
                data: '{"ProjectName":"' + res[1] + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var project = data.d;
                    debugger;
                    $("#id05").show("slide", { direction: "left" }, 0);
                    //$("#id01").css("display", "block");
                    //<%--    $("#" + '<%=btnsubmit.ClientID %>').css("display", "none");
                    //$("#" + '<%=btnupdate.ClientID %>').css("display", "inline-grid");--%>


                    //$("#" + '<%= txtEditProjectName.ClientID%>').val(project.ProjectName);
                    //$("#" + '<%= ddlEditProjectType.ClientID%>').val(project.projectType);
                    //$("#" + '<%= ddlEditProjectSubType.ClientID%>').val(project.ProjectSubType);
                    //$("#" + '<%= txtEditProjectSource.ClientID%>').val(project.ProjectSource);
                    //$("#" + '<%= txtEditDescription.ClientID%>').val(project.ProjectDescription);


                    //var d = new Date(project.ProjectDueDate);
                    //$("#" + '<%= txtEditDueDate.ClientID%>').val(d.getFullYear() + "-" + zeroPadded(d.getMonth() + 1) + "-" + zeroPadded(d.getDate()));

                },
                failure: function (r) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
            function zeroPadded(val) {
                if (val >= 10)
                    return val;
                else
                    return '0' + val;
            }
        });
    });
// Click On Submitt Project Code End///

// Click On TabTesting in Submit Project Code Start///
    $(document).on("click", "#tabTesting", function () {
        $("#divSuspend").css("display", "none");
        $("#divFinalSubmit").css("display", "none");
        $("#divTesting").show("slide", { direction: "left" }, 0);
        $("#lblErrorSubmitt").css("display", "none");

        $("#tabTesting").addClass("active");
        $("#tabSuspend").removeClass("active");
        $("#tabFinalSubmit").removeClass("active");

        $("#divBtnTestingSubmitt").css("display", "block");
        $("#divBtnSuspend").css("display", "none");
        $("#divBtnFinalSubmitt").css("display", "none");
    })
// Click On TabTesting in Submit Project Code End///

// Click On TabSuspend in Submit Project Code Start///
    $(document).on("click", "#tabSuspend", function () {
        $("#divTesting").css("display", "none");
        $("#divFinalSubmit").css("display", "none");
        $("#divSuspend").show("slide", { direction: "left" }, 0);

        $("#tabTesting").removeClass("active");
        $("#tabSuspend").addClass("active");
        $("#tabFinalSubmit").removeClass("active");

        $("#divBtnTestingSubmitt").css("display", "none");
        $("#divBtnSuspend").css("display", "block");
        $("#divBtnFinalSubmitt").css("display", "none");
        $("#lblErrorSubmitt").css("display", "none");
    })
// Click On TabSuspend in Submit Project Code End///

// Click On TabFinalSubmitt in Submit Project Code Start///
    $(document).on("click", "#tabFinalSubmit", function () {
        $("#divTesting").css("display", "none");
        $("#divSuspend").css("display", "none");
        $("#divFinalSubmit").show("slide", { direction: "left" }, 0);

        $("#tabTesting").removeClass("active");
        $("#tabSuspend").removeClass("active");
        $("#tabFinalSubmit").addClass("active");

        $("#divBtnTestingSubmitt").css("display", "none");
        $("#divBtnSuspend").css("display", "none");
        $("#divBtnFinalSubmitt").css("display", "block");
        $("#lblErrorSubmitt").css("display", "none");

        debugger;
        var projectName = document.getElementById('mainContent_lblHeadProjectName').innerHTML;

        $.ajax({
            type: "POST",
            url: "Projects.aspx/GetAllExpensesFinalSubmit",
            data: "{projectname:'" + projectName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: result,
            failure: function (e) {
                alert(r.d);
            },
            error: function (response) {
                alert(r.d);
            }
        });


        function result(r) {
            debugger;
            $("#tableFinalSubmisionDetails tr").detach();
            var table = document.getElementById("#tableFinalSubmisionDetails");
            var htmlstring = "";


            htmlstring += "<tr  style='border-bottom:1px solid darkgray ; ' class='t'>" +
                               "<th colspan='4' style='background-color:white'>Previous Expenses</th>" +
                          "</tr>" +
                          "<tr class='t'>" +
                               "<td>" +
                                  "Man Hour" +
                               "</td>" +
                                "<td style = 'text-align:left'>" +
                                  " " + r.d.MainHours + " HH:mm" +
                               "</td>" +
                                "<td >" +
                                  "Man Hour Expenses" +
                               "</td>" +
                                "<td style = 'text-align:left'>" +
                                  "" + r.d.MainHoursExpense + " <i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i>" +
                               "</td>" +
                         "</tr>" +
                        "<tr class='t'>" +
                               "<td >" +
                                  "Tour Expenses" +
                               "</td>" +
                               "<td style = 'text-align:left'>" +
                                  "" + r.d.TourExpense + " <i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i>" +
                               "</td>" +
                                "<td >" +
                                  "Software Expenses" +
                               "</td>" +
                               "<td style = 'text-align:left'>" +
                                  " " + r.d.Software + " <i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i>" +
                               "</td>" +
                       "<tr/>" +
                       "<tr class='t'>" +
                               "<td >" +
                                  "Hardware Expenses" +
                               "</td>" +
                                "<td >" +
                                  "" + r.d.Hardware + " <i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i>" +
                               "</td>" +
                                 "<td >" +
                                  "Other Expenses" +
                               "</td>" +
                               "<td >" +
                                  "" + r.d.Other + " <i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i>" +
                               "</td>" +
                        "<tr/>" +
                        "<tr  style='border-top:1px solid darkgray ;  ' class='t'>" +
                               "<td>" +
                                  "Total Expenses" +
                               "</td>" +
                               "<td >" +
                                  "" + r.d.totalExpense + " <i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i>" +
                               "</td>" +
                                "<td>" +

                               "</td>" +
                               "<td >" +

                               "</td>" +
                        "<tr/>";
            $("#tableFinalSubmisionDetails").append(htmlstring);
        }
    })
// Click On TabFinalSubmitt in Submit Project Code End///

// Click On add User  Code Start///
    $(document).on("click", ".proj_mng_div .contain .proj_mng .icon-add-usr", function () {

        $("#id02").show("slide", { direction: "left" }, 0);
        var projectname = $(this).parent().parent().parent().find(".prj_name a").text();

        var res = projectname.split("#");
        $("#mainContent_lblProjectname").text(res[0]);
        $("#mainContent_lblProjectId").text(res[1]);
        debugger;
        $(function () {

            $.ajax({
                type: "POST",
                url: "Projects.aspx/GetProjectAddInThisProject",
                data: '{"ProjectName":"' + res[1] + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (r) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
        });

        function OnSuccess(r) {

            $("#table tr").detach();
            var table = document.getElementById("#table");
            var htmlstring = "";
            $("#table").append("<tr><th style='width:10px;'><input type='checkbox' class='chk1' onclick='toggle(this);'/></th><th>Name</th> <th>Email</th></tr>");
            $.each(r.d, function (key, val) {
                var chk = "chk" + key;
                if (key % 2 == 0)
                    htmlstring += "<tr ><td style='width:10px;'><input type='checkbox' id=" + chk + " class='chk1' /></td><td>" + r.d[key].Name + "</td><td>" + r.d[key].Email + "</td><td style='display:none'>" + r.d[key].idlogin + "</td></tr>";
                else
                    htmlstring += "<tr class='tr_col_sec ' ><td style='width:10px;'><input type='checkbox' id=" + chk + " class='chk1' /></td><td>" + r.d[key].Name + "</td><td>" + r.d[key].Email + "</td><td style='display:none'>" + r.d[key].idlogin + "</td></tr>";
            });
            $("#table").append(htmlstring);
        }


        $(function () {
            $.ajax({
                type: "POST",
                url: "Projects.aspx/getuserinthisproject",
                data: '{"ProjectName":"' + res[1] + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess1,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
        });

        function OnSuccess1(e) {
            $("#table2 tr").detach();
            htmlstring = "";
            var table = document.getElementById("#table");
            var htmlstring = "";
            $("#table2").append("<tr><th style='background-color:#ABBAC3; color:white; width:300px'>User(s) in this Project</th> </tr>");

            $.each(e.d, function (key, val) {
                if (key % 2 == 0)
                    htmlstring += "<tr ><td style='width:300px'>" + e.d[key].Name + "</td></tr>";
                else
                    htmlstring += "<tr class='tr_col_sec' ><td style='width:300px'>" + e.d[key].Name + "</td></tr>";
            });
            $("#table2").append(htmlstring);
        }
    });
// Click On add User  Code End///

// Click On remove User  Code Start///
    $(document).on("click", ".proj_mng_div .contain .proj_mng .icon-remove-usr", function () {
        //$("#id03").css("display", "block");
        $("#id03").show("slide", { direction: "left" }, 0);
        var projectname = $(this).parent().parent().parent().parent().find(".prj_name a").text();

        var res = projectname.split("#");

        $("#mainContent_lblRemoveUser").text(res[0]);
        $("#mainContent_lblRemoveUserPID").text(res[1]);
        $(function () {
            $.ajax({
                type: "POST",
                url: "Projects.aspx/getuserinthisproject",
                data: '{"ProjectName":"' + res[1] + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess2,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
        });

        function OnSuccess2(r) {

            $("#table3 tr").detach();
            var table = document.getElementById("#table3");
            var htmlstring = "";
            $("#table3").append("<tr><th style='width:10px;'><input type='checkbox' class='chk3' onclick='toggle(this);'/></th><th>Name</th> <th>Email</th></tr>");
            $.each(r.d, function (key, val) {
                var chk = "chk" + key;
                if (key % 2 == 0)
                    htmlstring += "<tr ><td style='width:10px;'><input type='checkbox' id=" + chk + " class='chk3' /></td><td>" + r.d[key].Name + "</td><td>" + r.d[key].Email + "</td><td style='display:none'>" + r.d[key].idlogin + "</td></tr>";
                else
                    htmlstring += "<tr class='tr_col_sec ' ><td style='width:10px;'><input type='checkbox' id=" + chk + " class='chk3'/></td><td>" + r.d[key].Name + "</td><td>" + r.d[key].Email + "</td><td style='display:none'>" + r.d[key].idlogin + "</td></tr>";
            });
            $("#table3").append(htmlstring);
        }
    });
// Click On remove User  Code End///

// Click On Edit User  Code Start///

    $(document).on("click", ".proj_mng_div .contain .proj_mng .icon-edit-usr", function () {
    
        $("#id04").show("slide", { direction: "left" }, 0);
        var projectname = $(this).parent().parent().parent().parent().find(".prj_name a").text();

        var res = projectname.split("#");

        $("#headingProjectName").text(res[0]);
        $("#mainContent_lblidProject").text(res[1]);

        //$("#" + '<%= lblProjectId.ClientID%>').val("");
        $("#mainContent_txtEditProjectName").val("");
        $("#mainContent_ddlEditProjectType").val("");
        $("#mainContent_ddlEditProjectSubType").val("");
        $("#mainContent_txtEditDueDate").val("");
        $("#mainContent_txtEditProjectSource").val("");
        $("#mainContent_txtEditDescription").val("")
        $(function () {

            $.ajax({
                type: "POST",
                url: "Projects.aspx/editProject",
                data: '{"ProjectName":"' + res[1] + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var project = data.d;
                    debugger;
                    $("#id04").show("slide", { direction: "left" }, 0);                 

                    $("#mainContent_txtEditProjectName").val(project.idProjets);                    
                    $("#mainContent_ddlEditProjectType").val(project.projectType);
                    $("#mainContent_ddlEditProjectSubType").val(project.ProjectSubType);
                    $("#mainContent_txtEditProjectSource").val(project.ProjectSource);
                    $("#mainContent_txtEditDescription").val(project.ProjectDescription);


                    var d = new Date(project.ProjectDueDate);
                    $("#mainContent_txtEditDueDate").val(d.getFullYear() + "-" + zeroPadded(d.getMonth() + 1) + "-" + zeroPadded(d.getDate()));

                },
                failure: function (r) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
            function zeroPadded(val) {
                if (val >= 10)
                    return val;
                else
                    return '0' + val;
            }
        });

    });
// Click On Edit User  Code End///

// GetTable Value in Add User Tab  Code Start///
    function GetTableValues() {

        //Reference the Table.
        var table = document.getElementById("table");
        var ProjectName = "";
        var UserId = new Array();
        //Loop through Table Rows.
        var checkboxes = document.querySelectorAll('.chk1');       

        ProjectName = $("#mainContent_lblProjectId").text();      
        for (var i = 1; i < table.rows.length; i++) {
            var row = table.rows[i];
            ;
            if (checkboxes[i].checked == true)
                UserId[i] = row.cells[3].innerHTML;

        }

        $(function () {
            $.ajax({
                type: "POST",
                url: "Projects.aspx/AddUserInThisProject",
                data: '{"ProjectName":"' + ProjectName + '","UserId":"' + UserId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    if (e.d == "true") {
                        swal({
                            title: "User Add Successfully",
                            icon: "success",
                            customClass: 'swal-wide',
                            buttons: {
                                confirm: { text: 'Ok', className: 'sweet-warning' },
                                cancel: { text: 'Delete', className: 'sweet-warning' },
                            },
                        }).then(function () {
                            window.location = "Projects.aspx";
                        });
                    }
                    else {
                        swal({
                            title: "User Add Failed",
                            icon: "error",
                            customClass: 'swal-wide',
                            buttons: {
                                confirm: { text: 'Ok', className: 'sweet-warning' },
                                cancel: { text: 'Delete', className: 'sweet-warning' },
                            },
                        });
                    }
                },
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
        });
    }
// GetTable Value in Add User Tab  Code End///

// GetTable Value in Remove User Tab  Code Start///
    function GetTableValuesRemoveUser() {
        //Reference the Table  GetTableValuesRemoveUser.
        var table = document.getElementById("table3");
        var ProjectName = "";
        var UserId = new Array();
        //Loop through Table Rows.
        debugger;
        var checkboxes = [];
        checkboxes = document.querySelectorAll('.chk3');
        ProjectName = document.getElementById('mainContent_lblRemoveUserPID').innerHTML;
        //ProjectName = document.getElementById('<%=lblRemoveUser.ClientID %>').innerHTML;
        for (var i = 1; i < table.rows.length; i++) {
            var row = table.rows[i];
            var chkindex = i + 1;
            if (checkboxes[i].checked == true)
                UserId[i] = row.cells[3].innerHTML;

        }

        $(function () {
            $.ajax({
                type: "POST",
                url: "Projects.aspx/RemoveUserInThisProject",
                data: '{"ProjectName":"' + ProjectName + '","UserId":"' + UserId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {

                    if (e.d == "true") {
                        swal({
                            title: "User Remove Successfully",
                            icon: "success",
                            customClass: 'swal-wide',
                            buttons: {
                                confirm: { text: 'Ok', className: 'sweet-warning' },
                                cancel: { text: 'Delete', className: 'sweet-warning' },
                            },
                        }).then(function () {
                            window.location = "Projects.aspx";
                        });
                    }
                    else {

                        swal({
                            title: "User Remove Failed !",
                            icon: "error",
                            customClass: 'swal-wide',
                            buttons: {
                                confirm: { text: 'Ok', className: 'sweet-warning' },
                                cancel: { text: 'Delete', className: 'sweet-warning' },
                            },
                        })
                    }
                },
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });
        });
    }
// GetTable Value in Remove User Tab  Code End///

// Cancel Button Click Code For Close Modal & Display None error Label Code Start///
    $(".buttonTask").click(function () {
      
        $("#lblErrorEdit").css("display", "none");
      
        //Clear All value for Crete Project Start //
        $("input:text").val("");
        $("input:text").removeClass("valid").removeClass("invalid");      
        $("textarea:text").val("");
        $("textarea:text").removeClass("invalid");
        $("textarea:text").css("border", "1px solid #d2d6de");
        $("mainContent_txtProjectName").removeClass("valid").removeClass("invalid");
        $("#mainContent_ddlptype").val('0');
        $("#mainContent_ddlsubtype").val('0');
        $("#mainContent_txtduedate").val("");
        $("#mainContent_ddlprojectmanager").val('0');
        $("#mainContent_txtSource").val("");
        $("#mainContent_listmembers").siblings().find("span").find("span").text("");
        $("#mainContent_txtDescription").val("");
        $("#mainContent_txtDescription").removeClass("invalid");
        $("#mainContent_ddlptype").css("border", "1px solid #d2d6de");
        $("#mainContent_ddlsubtype").css("border", "1px solid #d2d6de");
        $("#mainContent_txtduedate").css("border", "1px solid #d2d6de");
        $("#mainContent_ddlprojectmanager").css("border", "1px solid #d2d6de");
        //Clear All value for Crete Project End //

        //Clear All value for Submit Testing Tab Start //
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_ddlTestingLeader").val('0').removeClass("invalid").css("border", "1px solid #ccc");
        $("#mainContent_ddlExpenseTypeTesting").val('0');
        $("#mainContent_txtExpenseAmountTesting").val("");
        $("#mainContent_txtExpenseDescriptionTesting").val("").css("border", "1px solid #ccc");
        //Clear All value for Submit Testing Tab End //

        //Clear All value for Suspend Tab Start //
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtSuspendReson").val("").removeClass("invalid").css("border", "1px solid #ccc");
        $("#mainContent_ddlExpenseType").val('0');
        $("#mainContent_txtAmount").val("");
        $("#mainContent_txtExpesneDescription").val("").removeClass("invalid").css("border", "1px solid #ccc");;
        //Clear All value for Suspend Tab End //

        //Clear All value for Final Submit Tab Start //
        $("#lblErrorSubmitt").css("display", "none");
        $("#mainContent_txtFinalSubmisionDescription").val("").removeClass("invalid").css("border", "1px solid #ccc");
        $("#mainContent_ddlFinalSubmisionExpenseType").val('0');
        $("#mainContent_txtFinalSubmisionAmount").val("");
        $("#mainContent_txtFinalSubmisionExpenseDescription").val("").removeClass("invalid").css("border", "1px solid #ccc");;
        //Clear All value for Final Submit Tab End //

        $("#id01").hide("slide", { direction: "right" }, 0);  // Add Project Modal //
        $("#id02").hide("slide", { direction: "right" }, 0);  // Add User Modal //
        $("#id03").hide("slide", { direction: "right" }, 0);  // Remove User Modal //
        $("#id04").hide("slide", { direction: "right" }, 0);  // Edit Project Modal //
        $("#id05").hide("slide", { direction: "right" }, 0);  // Submitt Projet Modal //     

        $("#lblError").css("display", "none");

    });
// Cancel Button Click Code For Close Modal & Display None error Label Code Start///
   
    
    
