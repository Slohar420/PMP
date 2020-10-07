<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateTask.aspx.cs" MasterPageFile="~/Dashboard/DSMaster.master" Inherits="Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="head" ContentPlaceHolderID="mainContent" runat="server">

    <style>
        .modal.fade:not(.in) .modal-dialog {
            -webkit-transform: translate3d(+25%, 0, 0);
            transform: translate3d(+25%, 0, 0);
        }

        .buttonTask {
            background-color: #ff9600;
            color: white;
            padding: 6px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 30%;
            opacity: 0.9;
            margin-left: 5px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
        }

        .buttonTask1 {
            background-color: #ff9600;
            color: white;
            padding: 6px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 30%;
            opacity: 0.9;
            margin-left: 5px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
        }

        .button1:hover {
            opacity: 1;
            background-color: #2C7D57;
        }

        .taskfooter {
            margin-top: 10px;
            background-color: #eee;
            border-top: 1px solid rgba(0,0,0,.125);
        }
        .t:hover {
            background-color:#fff;
        }
    </style>

    <div class="container-fluid" style="padding-left: 146px">


        <div class="row">
            <div class="col-md-11 col-sm-11 text-left">
                <table class="text-left m-btm-25">
                    <tr>
                        <td align="right">
                            <label style="float: right; font-size: 1.2vw; font-family: Georgia, 'Times New Roman', Times, serif">PROJECT  : </label>
                        </td>
                        <td class="" style="padding-left: 10px;">
                            <asp:DropDownList ID="ddlprojects" Font-Names="times new roman" runat="server" OnSelectedIndexChanged="ddlprojects_SelectedIndexChanged" CssClass="select-css"></asp:DropDownList>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
        <div class="row" id="filter_div_menu " style="display: none">
            <div class="col-md-12">
                <div class="filters float-rt">
                    <!--		<i class="db-filter-icon fl"></i>
		<div class="fl ftext">Filters:&nbsp;</div>-->
                    <div class="filter_btn_section fl" id="savereset_filter" style="display: none;">
                        <!--				<div style="display:none;" id="savefilter_btn" class="fl"  >
                                                        <div class="db-filter-save-icon fl" onClick="showSaveFilter();" title="Save Filter" rel="tooltip"></div>
                                                         <div id="inner_save_filter" class="sml_popup_bg">
                                                                <div>
                                                                        <div class="popup_title smal">
                                                                                <span>Save Custom Filter</span>
                                                                        </div>
                                                                        <div class="popup_form smal_form">
                                                                            <table cellpadding="0" cellspacing="0" class="col-lg-12" id="inner_save_filter_td">
                                                                                        <tr>
                                                                                                <td colspan="2">
                                                                                                        <span id="loaderpj" style="display:block;">
                                                                                                                <center>
                                                                                                                <img src="http://172.16.4.105:8080/orangescrum-master/img/images/case_loader2.gif" alt="Loading..." title="Loading..." />
                                                                                                                </center>
                                                                                                        </span>
                                                                                                </td>
                                                                                        </tr>
                                                                            </table>
                                                                        </div>
                                                                </div>
                                                         </div>
                                                </div>-->
                        <div style="display: none; padding-top: 5px; margin-right: 3px;" id="reset_btn" title="Reset Filters" rel="tooltip" onclick="resetAllFilters(&#39;all&#39;);">
                            <img src="./Task_files/reset.png">
                        </div>
                        <!--<div class="fl db-filter-reset-icon" style="display:none;" id="reset_btn" title="Reset Filters" rel="tooltip" onClick="resetAllFilters('all');"></div>-->
                    </div>
                    <div class="fl task_section case-filter-menu" data-toggle="dropdown" title="Task Filter" onclick="openfilter_popup(0,&#39;dropdown_menu_all_filters&#39;);" style="display: block;">
                        <button type="button" class="btn tsk-menu-filter-btn flt-txt">
                            <i class="icon_flt_img"></i>
                            Filters
				
                            <i class="caret"></i>
                        </button>
                        <ul class="dropdown-menu" id="dropdown_menu_all_filters" style="position: absolute; display: none;">
                            <li class="pop_arrow_new"></li>
                            <li>
                                <a href="javascript:jsVoid();" title="Time" data-toggle="dropdown" onclick="allfiltervalue(&#39;date&#39;);">Time</a>
                                <div class="dropdown_status" id="dropdown_menu_date_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_date" style="display: none;"></ul>
                                </div>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Due Date" data-toggle="dropdown" onclick="allfiltervalue(&#39;duedate&#39;);">Due Date</a>
                                <div class="dropdown_status" id="dropdown_menu_duedate_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_duedate" style="display: none;"></ul>
                                </div>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Status" data-toggle="dropdown" onclick="allfiltervalue(&#39;status&#39;);">Status</a>
                                <div class="dropdown_status" id="dropdown_menu_status_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_status" style="display: none;"></ul>
                                </div>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Types" data-toggle="dropdown" onclick="allfiltervalue(&#39;types&#39;);">Types</a>
                                <div class="dropdown_status" id="dropdown_menu_types_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_types" style="display: none;"></ul>
                                </div>

                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Priority" data-toggle="dropdown" onclick="allfiltervalue(&#39;priority&#39;);">Priority</a>
                                <div class="dropdown_status" id="dropdown_menu_priority_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_priority" style="display: none;"></ul>
                                </div>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Users" data-toggle="dropdown" onclick="allfiltervalue(&#39;users&#39;);">Created by </a>
                                <div class="dropdown_status" id="dropdown_menu_users_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_users" style="display: none;"></ul>
                                </div>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Assign To" data-toggle="dropdown" onclick="allfiltervalue(&#39;assignto&#39;);">Assign To</a>
                                <div class="dropdown_status" id="dropdown_menu_assignto_div" style="display: none;">
                                    <i class="status_arrow_new"></i>
                                    <ul class="dropdown-menu" id="dropdown_menu_assignto" style="display: none;"></ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- Filter options ends-->
                    <div class="fl task_section case-filter-menu taskgroupby-div" data-toggle="dropdown" title="Task Group By" onclick="openfilter_popup(0,&#39;dropdown_menu_groupby_filters&#39;);" style="display: block;">
                        <button type="button" class="btn tsk-menu-sortgroup-btn flt-txt">
                            <i class="icon_groupby_img"></i>Group by<i class="caret"></i>
                        </button>
                        <ul class="dropdown-menu" id="dropdown_menu_groupby_filters" style="position: absolute; display: none;">
                            <li class="pop_arrow_new"></li>
                            <!--				<li>
					<a href="javascript:jsVoid();" title="Time" data-toggle="dropdown" onclick="groupby('crtdate');"> Created Date</a>
				</li>-->
                            <li>
                                <a href="javascript:jsVoid();" title="Due Date" data-toggle="dropdown" onclick="groupby(&#39;duedate&#39;);">Due Date</a>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Status" data-toggle="dropdown" onclick="groupby(&#39;status&#39;);">Status</a>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Priority" data-toggle="dropdown" onclick="groupby(&#39;priority&#39;);">Priority</a>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" title="Priority" data-toggle="dropdown" onclick="groupby(&#39;assignto&#39;);">Assigned to</a>
                            </li>
                        </ul>
                    </div>
                    <div class="fl task_section case-filter-menu tasksortby-div" data-toggle="dropdown" style="display: block;">
                        <button type="button" class="btn tsk-menu-sortgroup-btn flt-txt sortby_btn  " onclick="openfilter_popup(0,&#39;dropdown_menu_sortby_filters&#39;);">
                            <i class="icon_sortby_img"></i>Sort by<i class="caret"></i>
                        </button>
                        <ul class="dropdown-menu" id="dropdown_menu_sortby_filters" style="position: absolute; display: none;">
                            <li class="pop_arrow_new"></li>
                            <li>
                                <a href="ja:jsVoid();" data-toggle="dropdown" onclick="ajaxSorting(&#39;title&#39;);">Title</a>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" data-toggle="dropdown" onclick="ajaxSorting(&#39;caseno&#39;);">Task#</a>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" data-toggle="dropdown" onclick="ajaxSorting(&#39;duedate&#39;);">Due Date</a>
                            </li>
                            <li>
                                <a href="javascript:jsVoid();" data-toggle="dropdown" onclick="ajaxSorting(&#39;caseAt&#39;);">Assigned to</a>
                            </li>

                        </ul>
                    </div>
                    <div class="cb"></div>
                </div>
            </div>
        </div>
        <div class="cb">
        </div>
        <!--Filter div end-->
        <table cellpadding="0" cellspacing="0" width="96%" class="task_section dashbod_tbl_m10 fixed_layout" style="display: table;">
            <tbody>
                <tr class="t">
                    <td id="topaction" class="">
                        <!--Tabs section starts -->
                        <div style="display: block; border: 0px solid #FF0000;" class="tab" id="topactions">
                            <ul id="myTab4" class="nav-tabs">
                                <li class="active" id="firstli">
                                    <a class="cattab active_tab" id="cases_id" data-toggle="tab">
                                        <div class="fl cases"></div>
                                        <div class="fl">All Tasks<span id="tskTabAllCnt"> </span></div>
                                        <div class="cbt"></div>
                                    </a>
                                </li>
                                <li class="" id="secondli">
                                    <a class="cattab" id="assigntome_id" data-toggle="tab">
                                        <div class="fl assigntome"></div>
                                        <div class="fl  mytsktab">My Tasks<span id="tskTabMyCnt"> </span></div>
                                        <div class="cbt"></div>
                                    </a>
                                </li>
                                <%-- <li class="pop_li">

                                    <a href="javascript:void(0);" class="select_button_ftop" onclick="newcategorytab();" rel="tooltip" original-title="Tab Settings">
                                        <div class="tab_pop">+</div>
                                    </a>
                                </li>--%>
                                <div style="clear: both"></div>
                            </ul>
                        </div>
                        <!--Tabs section ends -->
                    </td>
                </tr>
                <tr class="t">
                    <td>
                        <!--Task listing section starts here-->
                        <div id="caseViewSpanUnclick" style="display: block;">
                            <div id="caseViewDetails" style="display: none"></div>
                            <div id="caseViewSpan" style="display: block">
                                <style type="text/css">
                                    .pr_low {
                                        background: none !important;
                                    }

                                    .pr_medium {
                                        background: none !important;
                                    }

                                    .pr_high {
                                        background: none !important;
                                    }

                                    .label {
                                        font-weight: normal;
                                    }

                                    .tsk_tbl td {
                                        border-right: 0px solid #FFF !important;
                                        border-bottom: 0px solid #FFF !important;
                                        font-size: 1.2rem;
                                        font-family: 'Times New Roman';
                                        font-weight: 800;
                                    }
                                </style>
                                <table width="100%" class="tsk_tbl firstt" id="tsk_tbl">
                                    <tbody>
                                        <tr style="" class="tab_tr">
                                            <td width="18%" class="all_td">
                                                <div class="dropdown fl">
                                                    <%-- <input type="checkbox" class="fl chkAllTsk" id="chkAllTsk">--%>
                                                    <div class="all_chk" data-toggle=""></div>
                                                    <ul class="dropdown-menu" id="dropdown_menu_chk">
                                                        <li><a href="javascript:void(0);" onclick="multipleCaseAction(&#39;caseStart&#39;)">
                                                            <div class="act_icon act_start_task fl" title="Start"></div>
                                                            Start</a></li>
                                                        <li><a href="javascript:void(0);" onclick="multipleCaseAction(&#39;caseResolve&#39;)">
                                                            <div class="act_icon act_resolve_task fl" title="Resolve"></div>
                                                            Resolve</a></li>
                                                        <li><a href="javascript:void(0);" onclick="multipleCaseAction(&#39;caseId&#39;)">
                                                            <div class="act_icon act_close_task fl" title="Close"></div>
                                                            Close</a></li>
                                                        <li id="mvTaskToProj"><a href="javascript:void(0);" onclick="mvtoProject(&#39; &#39;,&#39; &#39;,&#39;movetop&#39;)">
                                                            <div class="act_icon pro_mov fl" title="Move to roject"></div>
                                                            Move to project</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                            <td class="task_cn" style="width: 10%;"><a href="javascript:void(0);" title="Task#" onclick="ajaxSorting(&#39;caseno&#39;, 2, this);" class="sortcaseno">
                                                <div class="fl">Assigned To</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="task_wd" style="width: 40%;"><a class="sorttitle" href="javascript:void(0);" title="Title" onclick="ajaxSorting(&#39;title&#39;, 2, this);">
                                                <div class="fl">Title</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="assign_wd_td"><a class="sortcaseAt" href="javascript:void(0);" title="Assigned to" onclick="ajaxSorting(&#39;caseAt&#39;, 2, this);">
                                                <div class="fl">Assigned By</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="tsk_due_dt"><a class="sortduedate" href="javascript:void(0);" title="Download Document" onclick="ajaxSorting(&#39;duedate&#39;, 2, this);">
                                                <div class="fl">Attachment</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="" style="width: 8%;"><a class="sortduedate" href="javascript:void(0);" title="Download Document" onclick="ajaxSorting(&#39;duedate&#39;, 2, this);">
                                                <div class="fl"></div>
                                            </a></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <table width="100%" class="tsk_tbl secondt" id="mtask" style="display: none;">
                                    <tbody>
                                        <tr style="" class="tab_tr">
                                            <td width="18%" class="all_td">
                                                <div class="dropdown fl">
                                                    <%--<input type="checkbox" class="fl chkAllTsk" id="mchkAllTsk">--%>
                                                    <div class="all_chk" data-toggle=""></div>
                                                    <ul class="dropdown-menu" id="mdropdown_menu_chk">
                                                        <li><a href="javascript:void(0);" onclick="multipleCaseAction(&#39;caseStart&#39;)">
                                                            <div class="act_icon act_start_task fl" title="Start"></div>
                                                            Start</a></li>
                                                        <li><a href="javascript:void(0);" onclick="multipleCaseAction(&#39;caseResolve&#39;)">
                                                            <div class="act_icon act_resolve_task fl" title="Resolve"></div>
                                                            Resolve</a></li>
                                                        <li><a href="javascript:void(0);" onclick="multipleCaseAction(&#39;caseId&#39;)">
                                                            <div class="act_icon act_close_task fl" title="Close"></div>
                                                            Close</a></li>
                                                        <li id="mvTaskToProj"><a href="javascript:void(0);" onclick="mvtoProject(&#39; &#39;,&#39; &#39;,&#39;movetop&#39;)">
                                                            <div class="act_icon pro_mov fl" title="Move to roject"></div>
                                                            Move to project</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                            <%-- <td class="task_cn" style="width: 10%;"><a href="javascript:void(0);" title="Task#" onclick="ajaxSorting(&#39;caseno&#39;, 2, this);" class="sortcaseno">
                                                <div class="fl">Assigned To</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>--%>
                                            <td class="task_wd" style="width: 40%;"><a class="sorttitle" href="javascript:void(0);" title="Title" onclick="ajaxSorting(&#39;title&#39;, 2, this);">
                                                <div class="fl">Title</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="assign_wd_td"><a class="sortcaseAt" href="javascript:void(0);" title="Assigned to" onclick="ajaxSorting(&#39;caseAt&#39;, 2, this);">
                                                <div class="fl">Assigned By</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="tsk_due_dt"><a class="sortduedate" href="javascript:void(0);" title="Download Document" onclick="ajaxSorting(&#39;duedate&#39;, 2, this);">
                                                <div class="fl">Attachment</div>
                                                <div class="tsk_sort fl "></div>
                                            </a></td>
                                            <td class="" style="width: 8%;"><a class="sortduedate" href="javascript:void(0);" title="Download Document" onclick="ajaxSorting(&#39;duedate&#39;, 2, this);">
                                                <div class="fl"></div>
                                            </a></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="col-md-12">
                                    <label class='lblerror' style="width: 100%; background-color: orange; color: white; font-size: 14px; text-align: center; margin: 20px 0 0 0; display: none;">No Task Found</label>
                                </div>
                                <div class="col-md-12">
                                    <label class='lblerrormytask' style="width: 100%; background-color: orange; color: white; font-size: 14px; text-align: center; margin: 20px 0 0 0; display: none;">No Task Found</label>
                                </div>
                                <input type="hidden" name="hid_cs" id="hid_cs" value="2">
                                <input type="hidden" name="totid" id="totid" value="3|2|">
                                <input type="hidden" name="chkID" id="chkID" value="">
                                <input type="hidden" name="slctcaseid" id="slctcaseid" value="">
                                <input type="hidden" id="getcasecount" value="2" readonly="true">
                                <input type="hidden" id="openId" value="">
                                <input type="hidden" id="email_arr" value="[object HTMLInputElement]">
                                <input type="hidden" id="curr_sel_project_id" value="1 ">
                            </div>
                            <div id="task_paginate" style="display: block;">
                                <table cellpadding="0" cellspacing="0" border="0" align="right">
                                    <tbody>
                                        <tr>
                                            <td align="center" style="padding-top: 5px;">
                                                <div class="show_total_case" style="font-weight: normal; color: #000; font-size: 12px;"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="padding-top: 5px">
                                                <ul class="pagination"></ul>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--Task listing section ends here-->
                    </td>
                </tr>
            </tbody>
        </table>
        <style>
            input.invalid, textarea.invalid {
                border: 2px solid red;
            }

            input.valid, textarea.valid {
                border: 2px solid green;
            }
        </style>
        <script>
            //validation script for submit task
            function TextValidation() {

                debugger;
                var tDescription = $("#" + "<%=txtDescription.ClientID%>").val();
                var tduedate = $("#" + "<%=txtDueDate.ClientID%>").val();
                var tAssignedTo = $("#ddlAssignTo").val();
                var tType = $("#" + "<%=ddlTaskType.ClientID%>").val();


        if ($.trim(tDescription) == '') {
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "Please Enter Task Description";
            <%-- $("#" + "<%=txtDescription.ClientID%>").css("border", "2px solid red");--%>
            $("#" + "<%=txtDescription.ClientID%>").removeClass("valid").addClass("invalid");
            return false;
        }
        else if (tDescription.length < 200) {
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "Please Enter Minimum 200 word Description";
            $("#" + "<%=txtDescription.ClientID%>").removeClass("valid").addClass("invalid");
            return false;
        }
        else if ($.trim(tduedate) == '') {
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "Please Enter due date";
            $("#" + "<%=txtDueDate.ClientID%>").removeClass("valid").addClass("invalid");
            $("#" + "<%=txtDescription.ClientID%>").removeClass("invalid").addClass("valid");
            return false;
        }
        else if ($.trim(tAssignedTo) == '0') {
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "Please Select Employee";          
            $("#ddlAssignTo").css("border", "2px solid red");
            $("#" + "<%=txtDueDate.ClientID%>").removeClass("invalid").addClass("valid");
            return false;
        }
        else if ($.trim(tType) == 'Select') {
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "Please Select Task Type";
            $("#" + "<%=ddlTaskType.ClientID%>").css("border", "2px solid red");
            $("#ddlAssignTo").css("border", "2px solid green");
            return false;
        }
        else {
            $("#lblError").css("display", "none");
            return true;
        }
}
function validateDescription() {
    var tDescription = $("#" + "<%=txtDescription.ClientID%>").val();

    if ($.trim(tDescription) == '') {
        $("#" + "<%=txtDescription.ClientID%>").removeClass("valid").addClass("invalid");
    } else if (tDescription.length < 200) {
        $("#" + "<%=txtDescription.ClientID%>").removeClass("valid").addClass("invalid");
        $("#lblError").css("display", "block");
        document.getElementById("lblError").innerHTML = "Please Enter Minimum 200 word Description";
    }
    else {
        $("#" + "<%=txtDescription.ClientID%>").removeClass("invalid").addClass("valid");
        $("#lblError").css("display", "none");
    }
}
            
        </script>
        <div class="row" style="margin-left: 40px; top: -5px; position: relative; margin-right: 0px;">
            <div class="card" id="card" style="width: 80%; margin: 20px; margin-left: 60px">
                <div class="card-header" style="text-align: left; background-color: #eee">
                    <b>
                        <h3>
                            <label class="taskname" runat="server" id="lbltaskname" style="padding-left: 10px;"></label>
                        </h3>
                    </b>
                </div>
                <div class="card-body">

                    <label for="psw-repeat" style="padding-top: 10px"><b>Desciption</b></label>
                    <asp:TextBox ID="txtDescription" onchange="validateDescription();" runat="server" CssClass="form-control" TextMode="MultiLine" Height="100"></asp:TextBox>

                    <label for="psw-repeat" style="padding-top: 10px"><b>Due Date</b></label>
                    <asp:TextBox ID="txtDueDate"  class="form-control t-due-date"   Type="Date" runat="server"></asp:TextBox>

                    <label for="psw-repeat" style="padding-top: 10px"><b>Assign To</b></label>
                    <div runat="server" id="divAssignTo">
                        <select id="ddlAssignTo" class="form-control s-assign-to">
                         </select>
                    </div>
                     <div runat="server" id="divAssignToTesting">
                        <asp:DropDownList runat="server" id="ddlAssignToTesting" class="form-control s-assign-to">
                         </asp:DropDownList>
                    </div>

                    <asp:HiddenField runat="server" ID="teamMemberID" Value="0" />

                    <label for="psw-repeat" style="padding-top: 10px"><b>Priority</b></label>
                    <div class="custom-control custom-radio">
                        <input type="radio" id="rdLow" runat="server" group="d" name="customRadio" class="custom-control-input" />
                        <label class="custom-control-label" for="customRadio1">Low</label>


                        <input type="radio" runat="server" id="rdMedium" group="d" name="customRadio" class="custom-control-input" />
                        <label class="custom-control-label" for="customRadio1">Medium</label>


                        <input type="radio" runat="server" id="rdHigh" group="d" name="customRadio" class="custom-control-input" />
                        <label class="custom-control-label" for="customRadio1">High</label>
                    </div>
                    <div id="divTaskType" runat="server">
                        <label for="psw-repeat" style="padding-top: 10px"><b>Task Type</b></label>
                    <asp:DropDownList runat="server" ID="ddlTaskType" CssClass="form-control s-task-type">
                        <asp:ListItem>Select </asp:ListItem>
                        <asp:ListItem>New Development </asp:ListItem>
                        <asp:ListItem>Bug Fixing </asp:ListItem>
                        <asp:ListItem>Update </asp:ListItem>
                        <asp:ListItem>Change Request </asp:ListItem>
                        <asp:ListItem>New Idea </asp:ListItem>
                        <asp:ListItem>Feature Enhancement </asp:ListItem>
                        <asp:ListItem>Maintenance </asp:ListItem>
                        <asp:ListItem>Others </asp:ListItem>
                    </asp:DropDownList>

                    </div>
                    
                    <label for="psw-repeat" style="padding-top: 10px"><b>Attachment</b></label>
                    <asp:FileUpload runat="server" ID="attachmentfile" CssClass="form-control" />

                    <label id="lblError" style="color: red; margin-top: 10px"></label>

                </div>
                <div class="taskfooter">
                    <div class="clearfix">
                        <asp:Button runat="server" OnClientClick="javascript:return TextValidation();" OnClick="btnsubmit_Click" type="button" ID="btnsubmit" UseSubmitBehavior="true" class="cancelbtn buttonTask1" Style="background-color: #337ab7" Text="Create" />
                        <button type="button" class="buttonTask">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal: modalPoll -->
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="modal fade right" id="modalPoll-1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                aria-hidden="true" data-backdrop="false">
                <div class="modal-dialog modal-full-height  modal-notify" role="document" style="width: 100%;">
                    <div class="modal-content" style="right: 60px; position: absolute; width: 20%; border-radius: 20px; max-height: 536px;">
                        <!--Header-->
                        <div class="modal-header text-center">
                            <div class="row">
                                <div class="col-md-3 col-sm-3 col-xs-3">
                                    <img src="images/logo1.png" alt="Logo" width="40px" height="40px" />
                                </div>
                                <div class="col-md-9 col-sm-9 col-xs-9">
                                    <p class="" style="position: absolute; right: 20px; top: 10px; font-size: 20px;">
                                        <i class="timertaskname" style="font-weight: 700; font-size: 18px; width: 100%;"></i>
                                        <%--<i style="font-size: 14px; font-weight: 400;">&nbsp;&nbsp;Submission</i>--%>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!--Body-->
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 text-center mtop-10">
                                    <button class="btn btn-sm " title="Click To Start Task" style="width: 44px; height: 44px; background-color: transparent; border-radius: 0px; font-size: 12px; background-image: url('images/start.png'); background-repeat: no-repeat" type="button" id="startTask"></button>
                                    <button class="btn btn-sm btn-warning" title="Click To Suspend Task" style="height: 60px; width: 60px; border-radius: 30px; display: none; padding-left: 6px; font-size: 12px" type="button" id="suspendTask">SUSPEND</button>
                                </div>
                                <div class="col-md-12 col-sm-12 text-center" style="background-color: #0e4e93; margin: 0px 0px 2px 0px">
                                    <label class="form-control timerlabel" style="display: none; text-align: center; color: white; background-color: transparent; border: none; font-size: 15px; font-weight: 600;"></label>
                                </div>

                                <div class="col-md-12 col-sm-12 text-center " style="">
                                    <input class="btn btn-sm btn-warning" type="button" id="dailysubmission" style="" value="WORK SUBMISSION" />
                                </div>
                                <div class="col-md-12 col-sm-12 text-center " style="">
                                    <label  id="lblWorkSubmisionError" style="color:red ; display:none" />
                                </div>
                                <div class="col-md-12 col-sm-12 text-center " style="padding: 5px;">
                                    <div class="text-center" style="height: 70px; border: 2px dotted #ff9600;">
                                        <label class="form-check-label" for="radio-579" style="opacity: 0.8">Attachment</label>
                                        <input type="file" class="btn btn-sm btn-warning" id="finalDocument" style="width: 77%; left: 14%; position: relative; top: -7px; background-color: aliceblue; color: black" title="Final Submission Attachment" />
                                        <label class="form-check-label" style="font-size: 11px; color: black; opacity: 0.7; top: -11px; position: relative;" for="radio-579">upload txt,pdf,xml,xls or ppt files</label>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 text-center togglebtndiv" style="padding: 0; width: auto; top: -12px; position: relative; border: none; border-color: transparent;">
                                    <button data-toggle="collapse" type="button" style="width: 150px; background-color: transparent; height: 30px; color: black; border: none; width: auto;" class="btn btn-sm collapse-expences" data-target="#togglediv"><span id="spanExpence" style="font-weight: 700; opacity: 0.8" class="fa fa-angle-double-down expencebtnspan">&nbsp;Add Other Expences</span></button>
                                </div>
                                <div id="togglediv" class="col-md-12 col-sm-12 collapse" style="margin: 0px 5px 5px; border: 2px dotted rgb(255, 150, 0); width: auto;">
                                    <div class="col-md-3 col-sm-3 text-left ">
                                        <label style="font-size: 13px; padding: 6px 0 0 0; opacity: 0.8">Expences</label>
                                    </div>

                                    <div class="col-md-9 col-sm-9 text-right">
                                        <span style="left: 32px; position: absolute; top: 5px;">&#x20B9;</span>
                                        <input type="text" id="expenceMoney" style="height: 20px; border-radius: 3px; margin: 0 0 10px 0; background-color: white; color: black; font-weight: 600; padding-left: 28px"
                                            placeholder="Enter Expences" />
                                        <script>
                                            $("#expenceMoney").keydown(function (e) {
                                                if ((e.which > 47 && e.which < 58) || (e.which > 95 && e.which < 106) || e.which == 110 || e.which == 8 || e.which == 9) {

                                                } else {
                                                    e.preventDefault();
                                                }
                                            });
                                        </script>
                                        <%-- <input type="text" id="expenceDesc" placeholder="Expence Description" />--%>
                                    </div>

                                    <style>
                                        input[type='text']::placeholder, textarea::placeholder {
                                            font-size: 10px;
                                            padding-left: 10px;
                                            font-family: Georgia, 'Times New Roman', Times, serif;
                                        }
                                    </style>
                                    <div class="col-md-6 col-sm-6 text-left ">
                                        <label style="font-size: 13px; padding: 6px 0 0 0; opacity: 0.8">Expence Type</label>
                                    </div>
                                    <div class="col-md-6 col-sm-6 text-left" style="padding: 3px;">
                                        <%--<input type="number" id="expenceMoney" placeholder="Enter Expences" />--%>
                                        <select id="select_expenseType">
                                            <option value="Hardware">Hardware</option>
                                            <option value="Software">Software</option>
                                            <option value="Tour">Tour</option>
                                            <option value="Other">Other</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12 col-sm-12 text-left" style="padding: 3px;">
                                        <%--<input type="number" id="expenceMoney" placeholder="Enter Expences" />--%>
                                        <textarea id="expenceDescrption" style="height: auto; width: 100%; border: none; background-color: #ebcb99; resize: none; color: black; font-size: 13px" placeholder="Expence Description (at least 100 letters)"></textarea>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 text-center " style="">
                                    <input class="btn btn-sm btn-warning" type="button" id="finalsubmission" style="" value="FINAL SUBMISSION" />
                                </div>
                                <div class="col-md-12 col-sm-12 text-center">
                                    <button type="button" class="btn btnclose " style="background-color: #0e4e93; color: white;" data-dismiss="modal">Close</button>
                                </div>
                                <asp:Button ID="savebtn" runat="server" OnClick="savebtn_Click" Style="display: none" />
                            </div>
                        </div>

                        <!--Footer-->
                        <%--<div class="modal-footer text-center">
                    <button type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal">Close</button>
                </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="wait" style="display: none; width: 69px; height: 89px; position: absolute; top: 50%; left: 50%; padding: 2px;">
        <img src="images/loader.gif" width="64" height="64" /><br>
        Loading..
    </div>

    <!-- Modal: modalPoll -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js'></script>

    <script>

    </script>

    <script src="js/CreateTask.js" type="text/javascript"></script>
    <script type="text/javascript">
        function loadProjectTeam(pid) {
            $.ajax({
                type: "POST",
                url: "CreateTask.aspx/loadProjectTeam", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{pid:'" + pid + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ddlAssignTo').empty();
                    $('#ddlAssignTo').append('<option value="0">Select Team Member</option>');
                    $.each(data.d, function (key, val) {
                        $('#ddlAssignTo').append('<option value="' + val + '">' + key + '</option>');
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });
        }

        function getTaskName(pid) {
            if (!isAjaxRunning) {
                $.ajax({
                    type: "POST",
                    url: "CreateTask.aspx/getTaskName", //It calls our web method  
                    contentType: "application/json; charset=utf-8",
                    data: "{id:'" + pid + "'}",
                    dataType: "json",
                    success: function (data) {
                        debugger;
                        $(".card .card-header .taskname").text(data.d);
                    },
                    failure: function (error) {
                        alert(error);
                    }
                });
            }
        }

        $("#ddlAssignTo").change(function () {
            $("#" + '<%= teamMemberID.ClientID %>').val($(this).children("option:selected").val());  //ProjectID
        });
            $(".create .createspan").click(function () {

                $('#' + '<%=txtDescription.ClientID %>').val('');
                $('#' + '<%=txtDueDate.ClientID %>').val('');
                $('#' + '<%=ddlTaskType.ClientID %>').val('Select ');
                $('#' + '<%=attachmentfile.ClientID %>').val('');

                if (!isAjaxRunning) {
                    var pid = $(".select-css").children("option:selected").val();  //ProjectID
                    getTaskName(pid);
                    loadProjectTeam(pid);

                    $(".task_section ").hide("slide", { direction: "right" }, 0, function () {
                        $(".card").show("slide", { direction: "left" }, 0);
                    });
                } else {
                    return;
                }

            });

            $(".btnclose").click(function () {

                $("#expenceDescrption").val("");
                $("#expenceMoney").val("");
                $("#togglediv").removeClass("in");
            });


            $(".buttonTask").click(function () {
                $('#' + '<%=txtDescription.ClientID %>').val('');
                $('#' + '<%=txtDueDate.ClientID %>').val('');
                $('#' + '<%=ddlTaskType.ClientID %>').val('Select ');
                $('#' + '<%=attachmentfile.ClientID %>').val('');
                $('#' + '<%=txtDescription.ClientID %>').removeClass("invalid").removeClass("valid");
                $('#' + '<%=txtDueDate.ClientID %>').css("border", "1px solid #ccc");
                $('#' + '<%=ddlTaskType.ClientID %>').css("border", "1px solid #ccc");
                $("#ddlAssignTo").css("border", "1px solid #ccc");

                $(".task_section").show("slide", { direction: "left" }, 500, function () {
                    $(".card").hide("slide", { direction: "right" }, 500);
                });
            });

            $(".togglebtndiv ").click(function () {
                $("collapse #expenceMoney").focus();
                if ($(this).children().children().hasClass("fa fa-angle-double-down")) {
                    $(this).children().children().removeClass("fa fa-angle-double-down").addClass("fa fa-angle-double-up");
                } else {
                    $(this).children().children().removeClass("fa fa-angle-double-up").addClass("fa fa-angle-double-down");
                }
            });
            $(".select-css ").change(function () {
                debugger;
                var pid = $(this).children("option:selected").val();  //ProjectID from dropdown
                getTaskName(pid);  //Load taskname  from database according to last taskname
                loadProjectTeam(pid); // Load project team members 
                loadTasks();   //All task loading
                loadMyTask(pid); // employee specific tasks

                if ($("#userrole").val().includes("admin")) {
                    $("#cases_id").addClass("active_tab").parent().addClass("active").siblings().find("a").removeClass("active_tab").parent().removeClass("active");
                    $(".firstt").css("display", "table");
                    $(".secondt").css("display", "none");

                } else {
                    $("#assigntome_id").addClass("active_tab").parent().addClass("active").siblings().find("a").removeClass("active_tab").parent().removeClass("active");
                    $(".firstt").css("display", "none");
                    $(".secondt").css("display", "table");

                }
            });
            function loadTasks() {
                debugger;
                var pid = $(".select-css").children("option:selected").val();
                pid = pid + "#"+ $("#userrole").val();
                $.ajax({
                    type: "POST",
                    url: "CreateTask.aspx/loadAllTasks", //It calls our web method  
                    contentType: "application/json; charset=utf-8",                    
                    data: "{id:'" + pid + "'}",
                    dataType: "json",
                    success: function (data) {
                        var html = "";
                        //html = html.replace(/"/g, "'");
                        $("#tsk_tbl > tr").remove();
                        $.each(data.d, function (key, val) {

                            var bgcolor = "#8dc2f8";

                            if (val.task_status == "Complete") {
                                bgcolor = "#398439"

                            } else if (val.task_status == "In Process") {
                                bgcolor = "#E0814E";
                            } else if (val.task_status == "Active") {
                                bgcolor = "#8dc2f8";
                            }

                            html = " <tr class='tr_all' id='curRow2'> <td class=''  valign='top'><div class='dropdown fl'><div class='sett' data-toggle='dropdown'></div><ul class='dropdown-menu sett_dropdown-caret'><li class='pop_arrow_new'></li><li onclick='startCase('2', '1', '3b68611795ab932e148ee40af45b0e11');' id='start2' style='display: none'><a href='javascript:void(0);'><div class='act_icon act_start_task fl' title='Start'></div>Start</a>                     </li><li onclick='caseResolve('2', '1', '3b68611795ab932e148ee40af45b0e11');' id='resolve2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_resolve_task fl' title='Resolve'></div>Resolve</a>                     </li><li onclick='setCloseCase('2', '1', '3b68611795ab932e148ee40af45b0e11');' id='close2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_close_task fl' title='Close'></div>Close</a>                     </li><li class='divider'></li><li id='act_reply2' data-task='3b68611795ab932e148ee40af45b0e11'><a href='javascript:void(0);' id='reopen2' style='display: none'><div class='act_icon act_reply_task fl' title='Re-open'></div>Re-open</a>                         <a href='javascript:void(0);' id='reply2' style='display: block'><div class='act_icon act_reply_task fl' title='Reply'></div>Reply</a>                     </li><li data-prjid='1' data-caseid='2' data-caseno='1' id='mv_prj2' style='' onclick='mvtoProject('2',this);'><a href='javascript:void(0);'><div class='act_icon pro_mov fl' title='Move to Project'></div>Move to Project</a>       </li><li onclick='moveTask('2', '1', '','1');' id='moveTask2' style='display: block'><a href='javascript:void(0);'><div class='act_icon task_move_mlst fl' title='Move Task To Milestone'></div>Move to Milestone</a>                     </li><li class='divider'></li><li onclick='archiveCase('2', '1', '1', 't_3b68611795ab932e148ee40af45b0e11');' id='arch2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_arcv_task fl' title='Archive'></div>Archive</a>                     </li><li onclick='deleteCase('2', '1', '1', 't_3b68611795ab932e148ee40af45b0e11');' id='arch2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_del_task fl' title='Delete'></div>Delete</a> </li></ul></div> <div id='csStsRep2' class='fl tsk_sts'><div class='label wip' style='background-color:" + bgcolor + "' >" + val.task_status + "</div></div></td>" +
                                "  <td valign='top' style='padding-right: 20px; text-align: left'>" + val.assigned_to + "</td> <td class='title_det_wd'><div class='fl title_wd'><div id='titlehtml2' data-task='3b68611795ab932e148ee40af45b0e11' class='fl case-title '><div class='case_title wrapword task_title_ipad  ' style='color:#555555;' title='" + val.task_name + "'>" + val.task_name + "</div></div></div><div class='att_fl fr' style='display: none;' id='fileattch2'></div><div class='cb rcb'></div><div class='fnt999 fl' style='word-break:break-all' ><div class='fl'><span id='stsdisp2' class='cview_hide'>" + val.task_descriptions + "</span><span class='cview_hide'></span><span id='timedis2' class='cview_hide'></span><span id='timedis2' class='cview_show' title=''></span></div><div class='fl' style=''><div id='repno2' class='fl bblecnt'></div></div></div><div class='cb'></div></td>" +
                                "  <td valign='top'><span style='color: #E0814E'>" + val.fk_idlogin + "</span><span class='due_dt_icn'></span></td>" +
                                " <td colspan='2' class='fnt12' valign='top'><a class='lnkfile'> <span style='position: relative; top: 2px; cursor: text;' title='Download Document'>" + val.task_attachment + "</span></a></td></tr>";
                            $("#tsk_tbl").append(html);
                        });

                        if ($(".firstt tr").length < 2 && $(".firstt").attr("display") != "none" && $("#firstli").hasClass("active")) {
                            $(".lblerror").css("display", "block");
                            $(".lblerrormytask").css("display", "none");
                        } else {
                            $(".lblerror").css("display", "none");
                            $(".lblerrormytask").css("display", "none");
                        }


                        $("#tskTabAllCnt").text("  (" + data.d.length + ")");

                        html = "";
                    },
                    failure: function (error) {
                        alert(error);
                    }
                });
            }

            $('.s-assign-to').change(function () {                
                if ($('.s-assign-to option:selected').text() == "Select Team Member") {
                    $("#lblError").css("display", "block");
                    document.getElementById("lblErrorSubmitt").innerHTML = "Please Select Testing Leader";
                    return false;
                }
                else {
                    $(".s-assign-to").css("border", "2px solid green");
                    $("#lblError").css("display", "none");
                    return true;
                }
            })

            $('.s-task-type').change(function () {
                if ($('.s-task-type option:selected').text() == "Select") {
                    $("#lblError").css("display", "block");
                    document.getElementById("lblErrorSubmitt").innerHTML = "Please Select Testing Leader";
                    return false;
                }
                else {
                    $(".s-task-type").css("border", "2px solid green");
                    $("#lblError").css("display", "none");
                    return true;
                }
            })
            $('.t-due-date').change(function () {
                if ($('.t-due-date').val() == "") {
                    $("#lblError").css("display", "block");
                    document.getElementById("lblErrorSubmitt").innerHTML = "Please Select Testing Leader";
                    return false;
                }
                else {
                    $(".t-due-date").css("border", "2px solid green");
                    $("#lblError").css("display", "none");
                    return true;
                }
            })
    </script>
</asp:Content>
