<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/DSMaster.master" AutoEventWireup="true" CodeFile="Projects.aspx.cs" Inherits="Projects" %>

<%@ MasterType VirtualPath="~/Dashboard/DSMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="SweetAlert/sweetalert.min.js"></script>
    <link href="css/select2.min.css" rel="stylesheet" />
    <%-- <script src="js/jquery.min.js"></script>--%>
    <script src="js/select2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>      
    <link href="css/Project/Project.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="head" ContentPlaceHolderID="mainContent" runat="Server">
    <div class="slide_rht_con">
        <div class="proj_grids">
            <!--Tabs section starts -->
            <div class="tab tab_comon">
                <ul class="nav-tabs mod_wide">
                    <li class="active">
                        <a href="Projects.aspx">
                            <div class="pro_actv fl"></div>
                            <div class="fl" id="divActiveTab">Active<span id="active_proj_cnt" class="counter">(<asp:Label runat="server" ID="lblActiveProjectCount" Text=""></asp:Label>)</span></div>
                            <div class="cbt"></div>
                        </a>
                    </li>
                    <li>
                        <a href="SuspendProject.aspx">
                            <div class="pro_inactv fl"></div>
                            <div class="fl" id="divSuspendTab">Suspend<span id="inactive_proj_cnt" class="counter">(<asp:Label runat="server" ID="lblSuspendProjectCount" Text=""></asp:Label>)</span></div>
                            <div class="cbt"></div>
                        </a>
                    </li>
                    <li>
                        <a href="CompleteProject.aspx">
                            <div class="pro_inactv fl"></div>
                            <div class="fl" id="divCompleteTab">Complete<span id="complete_proj_cnt" class="counter">(<asp:Label runat="server" ID="lblCompleteProjectCount" Text=""></asp:Label>)</span></div>
                            <div class="cbt"></div>
                        </a>
                    </li>
                    <div class="cbt"></div>
                </ul>
            </div>
            <!--Tabs section ends -->
            <!--Copied Design-->

            <div class="col-lg-12 m-left-42 prj_div" id="thumbnail">
                <div class="col-lg-4">
                    <div class="col-lg-12 containCreate new_prjct text-centre" style="margin: 40px 0 0 17px;">
                        <a href="javascript:void(0);" class="addproject" style="display: block !important; padding: 50px 50px 35px 50px;">
                            <div class="icon-projct-gridvw">
                                <img src="images/add.png" style="height: 60px; width: 60px;" />
                            </div>
                            <h3 style="padding-left: 20px;">Create New Project</h3>
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 proj_mng_div" style="display: none" onmouseover="" onmouseout="">
                    <div class="col-lg-12 contain usr_mng_div ">
                        <h3 class="prj_name"><a href="" title="">A1&nbsp;</a></h3>
                        <div class="user-details prj_details">
                            <div class="fl usr_lt">
                                <div class="user-image">
                                    <a href="">
                                        <img src="project_files/prj_icon.png"></a>
                                </div>
                                <div class="user-nm">WWW</div>
                            </div>
                            <div class="fl usr_rt">
                                <div class="border_usr"><b><span id="tot_prjusers3">3</span></b> User(s)</div>
                                <div><b>2</b> Task(s)</div>
                                <div><b>0</b> Hour(s) Spent</div>
                                <div>
                                    <b>0
                                    </b>Mb Storage
                                </div>
                            </div>
                            <div class="cb"></div>
                        </div>
                        <div class="last_updt prj_last_updt" runat="server">
                            Last Activity: Today 11:26 am
                        </div>
                        <div class="proj_mng" id="proj_mng" style="bottom: -42px; opacity: 0;">
                            <div class="fl">
                                <a href="javascript:void(0);" class="icon-add-usr fl" data-prj-id="3" data-prj-name="A1">Add User
                                </a>
                                <br>
                                <asp:LinkButton ID="lnkRelTypes" runat="server" Text="Relationship Type:" OnClientClick="PopulateRelTypes();"></asp:LinkButton>
                                <span id="remove3">
                                    <a href="javascript:void(0);" class="icon-remove-usr" data-prj-id="3" data-prj-name="A1">Remove User</a>
                                </span>
                                <span id="ajax_remove3" style="display: none;">
                                    <a href="javascript:void(0);" class="icon-remove-usr" data-prj-id="3" data-prj-name="A1">Remove User</a>
                                </span>
                            </div>
                            <div class="fr">
                                <a href="javascript:void(0);" class="icon-edit-usr fl" data-prj-id="4bd2520594153ca4072ffb7d3855b04c" data-prj-name="A1">Edit</a><br>

                                <a href="javascript:void(0);" class="icon-disable-usr fl disbl_prj" data-prj-id="3" data-prj-name="A1">Disable</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <table cellpadding="0" cellspacing="0" border="0" align="right">
                <tbody>
                    <tr>
                        <td align="center" style="padding-top: 5px; padding-right: 35px;">
                            <div class="show_total_case" style="font-weight: normal; color: #000; font-size: 12px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <ul class="pagination" style="padding-right: 35px;"></ul>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="cb"></div>
        <input type="hidden" id="getcasecount" value="3" readonly="true">
        <input type="hidden" id="totalcount" name="totalcount" value="0">
    </div>




    <center>
        <div class="popup_user" id="popup_user" style="display: none;">
        <!-- New project popup starts -->
        <div class="new_project cmn_popup" style="display: block; background-color: white">
            <div class="popup_title">
                <span><i class="icon-create-proj"></i>Add Member</span>
                <a href="javascript:jsVoid();" onclick="hidemodal();">
                    <div class="fr">X</div>
                </a>
            </div>
            <div class="popup_form" style="margin-top: 20px;">
                <div class="loader_dv" style="display: none;">
                    <center><img src="" alt="Loading..." title="Loading..."></center>
                </div>
                <div id="usermodal" style="">
                    <form action="/orangescrum-master/projects/add_project" name="projectadd" onsubmit="return projectAdd('txt_Proj','txt_shortProj','loader','btn')" id="ProjectManageForm" method="post" accept-charset="utf-8">
                        <div style="display: none;">
                            <input type="hidden" name="_method" value="POST"><input type="hidden" name="data[_Token][key]" value="802fdd5cd0fad0e67b0b4611a60454f34e286f0bbcadfe6e675467e107fb6b11e9aa3d4266dabaa240f96e574f35fe56514580816c3172366f99dfd2dd5e2e5c" id="Token616988211">
                        </div>
                        <div class="data-scroll">
                            <table cellpadding="0" cellspacing="0" class="col-lg-12">
                                <tbody>
                                    <tr>
                                        <td style="width:80%;">
                                            <asp:gridview runat="server" ID="gridremoveuser" AutoGenerateColumns="false" Width="100%">
                                                <Columns>
                                                    <asp:BoundField HeaderText="idlogin" Visible="false" />
                                                    <asp:BoundField HeaderText="Member" Visible="true" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:button text="DELETE" runat="server" CssClass="btn btn-warning" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:gridview>
                                            </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div style="padding-left: 145px;">
                            <input type="hidden" name="data[Project][validate]" id="validate" readonly="true" value="0">
                            <span id="L1" style="display: none;">
                                <img src="http://172.16.4.105:8080/orangescrum-master/img/images/case_loader2.gif" alt="Loader">
                            </span>
                            <span id="btn1">
                                <%--<asp:Button runat="server" ID="btncreate" OnClientClick="addProject()" OnClick="btncreate_Click" class="btn btn_blue" Text="Create" />--%>
                                <asp:Button CssClass="btn " runat="server" style="width:150px;background-color:green !important; " type="button" onclick="btncreate_Click" Text="create"></asp:Button>
                                <span class="or_cancel">or
                    <a onclick="hidemodal();">Cancel</a>
                                </span>
                            </span>
                        </div>
                        <div style="display: none;">
                            <input type="hidden" name="data[_Token][fields]" value="a0a58eae38e8321e0966566cf60754f5b9ed3428%3A" id="TokenFields1155833952"><input type="hidden" name="data[_Token][unlocked]" value="" id="TokenUnlocked48974213">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- New project popup ends -->
        </div>
     </center>

    <div>
        <div id="create_task_pop" class="crt_tsk cmn_popup1 crt_task_slide">
            <div class="popup_form1">

                <div id="inner_task">
                    <div class="task_slide_in">
                        <span>
                            <i class="icon-create-tsk" id="ctask_icons"></i>
                            <span id="taskheading">Create</span> Task
                        </span>
                    </div>
                    <div class="cb"></div>
                    <div class="loader_dv_edit" style="display: none;">
                        <center><img src="Project_files/case_loader2.gif" alt="Loading..." title="Loading..."></center>
                    </div>
                    <table class="create_table" style="width: 75%">
                        <tbody>
                            <tr>
                                <td>
                                    <input type="hidden" name="data[Easycase][istype]" id="CS_istype" value="1" readonly="true">
                                    <div class="fl lbl-m-wid">Project:</div>
                                    <div class="col-lg-9 createtask fl rht-con">
                                        <div style="font-weight: bold;" id="edit_project_div" class="ttc"></div>
                                        <div id="create_project_div">
                                            <input type="hidden" readonly="readonly" value="ba777a4545b12c61c4c493559efe647b" id="curr_active_project">
                                            <div class="popup_link link_as_drp_dwn swtchproj fl" id="ctask_popup">
                                                <a href="javascript:void(0);" data-toggle="dropdown" class="option-toggle" onclick="show_prjlist(event);">
                                                    <span id="projUpdateTop" class="ttc">Card Wizard</span>
                                                    <i class="caret"></i>
                                                </a>
                                            </div>
                                            <div id="prjchange_loader" style="display: none; margin-left: 15px; margin-top: -2px;" class="fl">
                                                <img src="Project_files/del.gif" title="Loading..." alt="Loading...">
                                            </div>
                                            <div class="cb"></div>
                                            <div id="openpopup" class="popup dropdown-menu lft popup ctaskproj ttc" style="display: none;">
                                                <div class="popup_con_menu" align="left">
                                                    <div align="left" id="ajaxaftersrchc" style="display: none;"></div>
                                                    <div align="left" id="ajaxbeforesrchc">
                                                        <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;Card%20Wizard&#39;, &#39;ba777a4545b12c61c4c493559efe647b&#39;)">Card Wizard</a>
                                                        <hr class="pro_div">
                                                        <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;sdf&#39;, &#39;e09cdbfc5ca500460e436066d99dd01b&#39;)">sdf</a>
                                                        <hr class="pro_div">
                                                        <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;a1&#39;, &#39;4bd2520594153ca4072ffb7d3855b04c&#39;)">a1</a>
                                                        <hr class="pro_div">
                                                        <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;P1&#39;, &#39;2bdf6c2dc8ff565e70186f9996d5ecd6&#39;)">P1</a>
                                                        <hr class="pro_div">
                                                        <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;Digital%20Signage&#39;, &#39;062abdf226e93a198b2e0cfbd6ae3027&#39;)">Digital Signage</a>
                                                        <hr class="pro_div">
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="projAllmsg" style="display: none; color: #C0504D; font-size: 14px; padding-top: 10px;">Oops! No project selected.</div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="fl lbl-m-wid" style="padding-top: 16px">Title:</div>
                                    <div class="col-lg-9 fl rht-con">
                                        <input class="form-control" type="text" placeholder="Add a task here &amp; hit enter...." id="CS_title" maxlength="240" onblur="blur_txt();checkAllProj();" onfocus="focus_txt()" onkeydown="return onEnterPostCase(event)" onkeyup="checktitle_value();" style="font-size: 15px;">
                                        <div id="err_case_title" class="err_msg"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="case_field">
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td class="case_fieldprof">
                                                                        <div class="fl lbl-m-wid">Assign To:</div>
                                                                    </td>
                                                                    <td align="left">
                                                                        <div id="sample1" class="dropdown option-toggle p-6">
                                                                            <div class="opt1" id="opt5">
                                                                                <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt5&#39;);">
                                                                                    <span id="tsk_asgn_to"></span>
                                                                                    <i class="caret mtop-10 fr"></i>
                                                                                </a>
                                                                            </div>
                                                                            <div class="more_opt" id="more_opt5">
                                                                                <ul>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">


                                                        <div class="fl lbl-m-wid" style="padding-top: 17px">Due Date:</div>
                                                        <div class="col-lg-9 fl rht-con">
                                                            <div class="fl dropdown option-toggle p-6">
                                                                <div class="opt1" id="opt3">
                                                                    <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt3&#39;);">
                                                                        <span id="date_dd">No Due Date
                                                                        </span>
                                                                        <i class="caret mtop-10 fr"></i></a>
                                                                </div>


                                                                <div class="more_opt" id="more_opt3">
                                                                    <ul>
                                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;No Due Date<span class="value">No Due Date</span></a></li>
                                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;Today<span class="value">Sep 8, Tue</span> </a></li>
                                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;Next Monday <span class="value">Sep 14, Mon</span></a></li>
                                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;Tomorrow<span class="value">Sep 9, Wed</span></a></li>
                                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;This Friday<span class="value">Sep 11, Fri</span></a></li>
                                                                        <li style="color: #808080; padding-left: 10px;">
                                                                            <input type="hidden" id="due_date" title="Custom Date" style="min-width: 30px;">&nbsp;<span style="position: relative;">Custom Date</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="task_priority_td" colspan="2" style="padding: 6px 0 5px 0;">
                                                        <table cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td class="case_fieldprof">
                                                                        <span id="hd1">
                                                                            <div class="fl lbl-m-wid">Priority:</div>
                                                                        </span>
                                                                    </td>
                                                                    <td align="left">
                                                                        <div class="fl prio_radio y_low" onclick="check_priority(this);">
                                                                            <input type="radio" name="task_priority" value="2" id="priority_low" class="pri-checkbox"><label tabindex="4" class="pri-label"></label>
                                                                        </div>
                                                                        <div class="fl pri_type">Low</div>
                                                                        <div class="fl prio_radio g_mid" onclick="check_priority(this);">
                                                                            <input type="radio" name="task_priority" value="1" id="priority_mid" class="pri-checkbox" checked="checked"><label tabindex="4" class="pri-label"></label>
                                                                        </div>
                                                                        <div class="fl pri_type">Medium</div>
                                                                        <div class="fl prio_radio h_red" onclick="check_priority(this);">
                                                                            <input type="radio" name="task_priority" value="0" id="priority_high" class="pri-checkbox"><label tabindex="4" class="pri-label"></label>
                                                                        </div>
                                                                        <div class="fl pri_type">High</div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="new_case_more_div" style="display: none;">
                                        <style>
                                            #holde {
                                                d #F8F81;
                                                ding: 8 x;
                                                ght: 85px;
                                                o;
                                            }

                                            over {
                                                s;
                                            }

                                            /* END EXTERNAL SOURCE */

                                            /*
                                        </style>
                                        <input type="hidden" name="totfiles" id="totfiles" value="0" readonly="true">
                                        <input type="hidden" id="is_default_task_type" value="1" readonly="true">
                                        <input type="hidden" id="CS_type_id" value="2 ">
                                        <input type="hidden" id="CS_priority" value="1 ">
                                        <input type="hidden" id="CS_due_date" value="No Due Date">
                                        <input type="hidden" id="CS_milestone" value="">

                                        <div class="head_back"></div>
                                        <div id="cover" class="outer"></div>
                                        <div id="pagefade" class="pagefade" style="z-index: 0"></div>
                                        <div>

                                            <div class="case_field w-736">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <table cellpadding="0" cellspacing="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="case_fieldprof">
                                                                                <div class="fl lbl-m-wid">Task Type:</div>
                                                                            </td>
                                                                            <td align="left">
                                                                                <div id="sample" class="dropdown option-toggle p-6 fl">
                                                                                    <div class="opt1" id="opt1">
                                                                                        <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt&#39;);">
                                                                                            <span id="ctsk_type">
                                                                                                <img class="flag" src="Project_files/dev.png" alt="type" style="padding-top: 3px;" />&nbsp;Development
                                                                                            </span>
                                                                                            <i class="caret mtop-10 fr"></i>
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="more_opt" id="more_opt">
                                                                                        <ul>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/dev.png" />
                                                                                                    <span class="value">2
                                                                                                    </span>Development
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/bug.png" />
                                                                                                    <span class="value">1
                                                                                                    </span>Bug
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/upd.png" />
                                                                                                    <span class="value">10
                                                                                                    </span>Update
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/cr.png" />
                                                                                                    <span class="value">12
                                                                                                    </span>Change Request
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/idea.png" />
                                                                                                    <span class="value">11
                                                                                                    </span>Idea
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/enh.png" />
                                                                                                    <span class="value">3
                                                                                                    </span>Enhancement
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/rnd.png" />
                                                                                                    <span class="value">4
                                                                                                    </span>Research n Do
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/mnt.png" />
                                                                                                    <span class="value">7
                                                                                                    </span>Maintenance
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/qa.png" />
                                                                                                    <span class="value">5
                                                                                                    </span>Quality Assurance
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/unt.png" />
                                                                                                    <span class="value">6
                                                                                                    </span>Unit Testing
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/rel.png" />
                                                                                                    <span class="value">9
                                                                                                    </span>Release
                                                                                                </a>
                                                                                            </li>
                                                                                            <li>
                                                                                                <a href="javascript:jsVoid()">
                                                                                                    <img class="flag" src="Project_files/oth.png" />
                                                                                                    <span class="value">8
                                                                                                    </span>Others
                                                                                                </a>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                                <span style="position: relative; top: 4px;"><a href="http://172.16.4.105:8080/orangescrum-master/task-type" style="color: #06C; text-decoration: underline; font-size: 12px; padding-left: 5px;">Add New</a></span>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                            <td align="right" id="milestone_td">
                                                                <div class="fl lbl-m-wid" style="padding-top: 17px">Milestone:</div>
                                                                <div class="col-lg-9 createtask fr rht-con">
                                                                    <div class="fl dropdown option-toggle p-6" style="margin-left: 14px; text-align: left">
                                                                        <div class="opt1" id="opt8">
                                                                            <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt8&#39;);">
                                                                                <span id="selected_milestone">No milestone
                                                                                </span>
                                                                                <i class="caret mtop-10 fr"></i>
                                                                            </a>
                                                                        </div>
                                                                        <div class="more_opt" id="more_opt8">
                                                                            <ul></ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="case_field">
                                                <span>
                                                    <div class="fl lbl-m-wid">Description:</div>
                                                    <div id="divNewCase" class="col-lg-9 createtask fl rht-con">
                                                        <textarea name="data[Easycase][message]" id="CS_message" onfocus="openEditor()" rows="2" style="resize: none" class="form-control" placeholder="Enter Description..."></textarea>
                                                    </div>
                                                    <div id="divNewCaseLoader" style="display: none; padding: 20px; text-align: center; color: #999999;">
                                                        Loading...
                                                    </div>
                                                </span>
                                            </div>
                                            <div class="cb"></div>
                                            <div class="case_field w-736">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="left">
                                                                <table cellpadding="0" cellspacing="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="case_fieldprof">
                                                                                <div class="fl lbl-m-wid">Estimated Hour(s):</div>
                                                                            </td>
                                                                            <td>
                                                                                <div class="col-lg-9 createtask fl rht-con">
                                                                                    <a rel="tooltip" href="javascript:;" original-title="You can enter time as 1.5  (that  mean 1 hour and 30 minutes).">
                                                                                        <input type="text" onkeypress="return numericDecimal(event)" id="estimated_hours" name="data[Easycase][estimated_hours]" maxlength="6" class="form-control" style="width: 80px;" value="">
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>







                                                            <td align="right">
                                                                <table cellpadding="0" cellspacing="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="case_fieldprof">
                                                                                <div class="fl lbl-m-wid">Hour(s) Spent:</div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="sample" class="col-lg-9 createtask fl rht-con">
                                                                                    <a rel="tooltip" href="javascript:;" original-title="You can enter time as 1.5  (that  mean 1 hour and 30 minutes).">
                                                                                        <input type="text" onkeypress="return numericDecimal(event)" id="hours" name="data[Easycase][hours]" maxlength="6" class="form-control" style="width: 80px;" value="">
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="clear"></div>
                                            <div class="case_field">
                                                <table border="0" cellpadding="0" cellspacing="0" style="padding-left: 2px;" id="table1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="case_fieldprof" valign="top">
                                                                <div class="fl lbl-m-wid">Attachment(s):</div>
                                                            </td>
                                                            <td align="left">
                                                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                <form id="file_upload" action="http://172.16.4.105:8080/orangescrum-master/easycases/fileupload/" method="POST" enctype="multipart/form-data" class="file_upload">
                                                                                    <div class="fl" style="margin: 10px 0;">
                                                                                        <div id="holder" style="">
                                                                                            <div class="customfile-button" style="right: 0">
                                                                                                <input class="customfile-input fl" name="data[Easycase][case_files]" type="file" multiple="" style="width: 233px; height: 74px;">
                                                                                                <input name="data[Easycase][usedstorage]" type="hidden" id="usedstorage" value="">
                                                                                                <input name="data[Easycase][allowusage]" type="hidden" id="allowusage" value="Unlimited">
                                                                                                <div class="att_fl fl" style="margin-right: 5px"></div>
                                                                                                <div class="fr">Select multiple files to upload...</div>
                                                                                            </div>
                                                                                            <div style="margin-left: 4px; color: #F48B02; font-size: 13px;" class="fnt999">Drag and Drop files to Upload</div>
                                                                                            <div style="margin-left: 6px" class="fnt999">Max size 200 Mb</div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="cb"></div>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table id="up_files" style="font-weight: normal; width: 100%;"></table>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr id="drive_tr_0" style="display: none;">
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <%--   <form id="cloud_storage_form_0" name="cloud_storage_form_0" action="javascript:void(0)" method="POST">
                        <div style="float: left;margin-top: 7px;" id="cloud_storage_files_0"></div>
                    </form>--%>
                                                                <div style="clear: both; margin-bottom: 3px;"></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="cb"></div>
                                        </div>
                                        <script>
                                            var holder = document.getElementById('holder'),
                                                tests = {
                                                    dnd: 'draggable' in document.createElement('span')
                                                };

                                            if (tests.dnd) {
                                                holder.ondragover = function () {
                                                    this.className = 'hover';
                                                    return false;
                                                };
                                                holder.ondrop = function (e) {
                                                    $('#holder').removeClass('hover');
                                                    if ($.trim(e.dataTransfer.files[0].type) === "" || e.dataTransfer.files[0].size === 0) {
                                                        alert('File "' + e.dataTransfer.files[0].name + '" has no extension!\nPlease upload files with extension.');
                                                        e.stopPropagation();
                                                        e.preventDefault();
                                                    }
                                                    return false;
                                                };
                                            }
                                            $(function () {
                                                $('#holder').mouseout(function () {
                                                    $('#holder').removeClass('hover');
                                                });
                                            });
                                        </script>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" id="ajxQuickMem">
                                    <div class="fl lbl-m-wid">Notify via Email:</div>
                                    <div class="col-lg-9 fl rht-con email rht_bg">
                                        <input type="checkbox" name="chk_all" id="chked_all" value="all" onclick="checkedAllRes()">&nbsp;ALL
                            <div id="viewmemdtls">
                            </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    <div class="fl lbl-m-wid">&nbsp;</div>
                                    <div class="col-lg-9 fl rht-con rht_bg" style="padding-left: 4px; padding-bottom: 0">
                                        <div class="fr mor_toggle tasktoogle" id="more_tsk_opt_div" style="position: relative; float: left">
                                            <a href="javascript:jsVoid();" onclick="opencase(&#39;click&#39;);" style="text-decoration: none">
                                                <img src="Project_files/description.png" title="Description" rel="tooltip">&nbsp;&nbsp;<img src="Project_files/hours.png" title="Estimated Hours and Hours Spent" rel="tooltip">&nbsp;&nbsp;<img src="Project_files/attachment.png" title="Attachments, Google Drive, Dropbox" rel="tooltip">&nbsp;&nbsp;+ More</a>
                                        </div>

                                        <div class="fr less_toggle tasktoogle" id="less_tsk_opt_div" style="display: none; position: relative; float: left"><a href="javascript:jsVoid();" onclick="closecase();" style="text-decoration: none">- Less</a></div>

                                        <div style="position: relative; width: 20px;" class="fl">
                                            <img src="Project_files/del.gif" title="Loading..." alt="Loading..." id="loadquick" style="display: none;">
                                        </div>
                                    </div>

                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="cb"></div>
                    <input type="hidden" value="" name="easycase_uid" id="easycase_uid" readonly="readonly">
                    <input type="hidden" value="" name="easycase_id" id="CSeasycaseid" readonly="readonly">
                    <input type="hidden" value="" name="editRemovedFile" id="editRemovedFile" readonly="readonly">
                    <div class="col-lg-12 task_slide_in btm_block">
                        <div style="float: right; width: 255px;">
                            <input type="hidden" name="hid_http_images" id="hid_http_images" value="http://172.16.4.105:8080/orangescrum-master/img/" readonly="true">
                            <span id="quickcase" style="display: block;" class="nwa">
                                <button class="btn btn_blue" type="submit" onclick="return submitAddNewCase(&#39;Post&#39;, 0, &#39;&#39;, &#39;&#39;, &#39;&#39;, 1, &#39;&#39;);"><i class="icon-big-tick"></i><span id="ctask_btn">Create</span></button>
                                <!--<button class="btn btn_grey" type="reset" id="rset" onclick="crt_popup_close();"><i class="icon-big-cross"></i>Cancel</button>-->
                                <span class="or_cancel">
                                    <a id="rset" class="btn btn-default" onclick="crt_popup_close();">Cancel</a>
                                </span>
                            </span>
                            <span id="quickloading" style="display: none; padding-left: 10px; padding-top: 5px;">
                                <img src="Project_files/case_loader2.gif" title="Loading..." alt="Loading...">
                            </span>
                        </div>

                        <!--<div style="float:left;width:340px;">
                        
                </div>-->
                    </div>
                </div>
            </div>
        </div>
        <div class="cb"></div>
        <!--  common popups -->
        <!-- breadcrumb, project popup -->
        <input type="hidden" id="checkload" value="0">



        <div class="task_action_bar_div task_detail_head">
            <div class="task_action_bar">
                <button class="btn gry_btn task_detail_back" type="button" style="margin-left: 18px;">
                    <i class="icon-backto"></i>
                </button>
                <div class="fr">
                    <button class="btn gry_btn next" type="button" title="Next">

                        <i class="icon-next"></i>
                    </button>
                </div>
                <div class="fr">
                    <button class="btn gry_btn prev" type="button" title="Previous">
                        <i class="icon-prev"></i>
                    </button>
                </div>
            </div>
            <!-- Case Detail buttons -->
        </div>
        <div class="task_action_bar_div milestonekb_detail_head">
            <div class="task_action_bar">
                <button class="btn gry_btn task_detail_back" type="button" style="margin-left: 18px;">
                    <i class="icon-backto"></i>
                </button>
            </div>
            <!-- Case Detail buttons -->
        </div>
        <!-- Add New Project Modal Start-->


        <div id="id01" class="modal">
            <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>

            <div class="container">
                <div class="row">
                    <div class="card" style="width: 80%; margin: 20px; margin-left: -80px">
                        <div class="card-header" style="background-color: #eee; text-align: left">
                            <h3 style="margin-left: 10px">Create New Project</h3>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw" style="padding-top: 10px"><b>Project Name</b></label>
                                    <asp:TextBox runat="server" value="" ID="txtProjectName" AutoCompleteType="Disabled" autocomplete="off" onchange="pname(this);" placeholder="Project Name" CssClass="form-control  pname"></asp:TextBox>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Project Type</b></label>
                                    <asp:DropDownList runat="server" CssClass="form-control ptype" ID="ddlptype" OnSelectedIndexChanged="ddlptype_SelectedIndexChanged">
                                        <asp:ListItem Value="0" Text="Select Project Type" />
                                        <asp:ListItem Text="Software" />
                                        <asp:ListItem Text="Hardware" />
                                        <asp:ListItem Text="Mechanical" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw" style="padding-top: 10px"><b>Project Sub-Type</b></label>
                                    <asp:DropDownList runat="server" CssClass="form-control p-s-type" ID="ddlsubtype">
                                        <asp:ListItem Value="0" Text="Select" />
                                        <asp:ListItem Text="KIOSK" />
                                        <asp:ListItem Text="ATM" />
                                        <asp:ListItem Text="PRINTER" />
                                        <asp:ListItem Text="Smart City" />
                                        <asp:ListItem Text="RMS" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Due Date</b></label>
                                    <asp:TextBox ID="txtduedate" onchange="dueDate(this);" AutoCompleteType="Disabled" autocomplete="off" class="form-control due-date" type="date" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw" style="padding-top: 10px"><b>Project Manager</b></label>
                                    <asp:DropDownList runat="server" CssClass=" select form-control p-manager " ID="ddlprojectmanager">
                                        <asp:ListItem Text="1" />
                                        <asp:ListItem Text="Pm 1" />
                                        <asp:ListItem Text="PM 2" />
                                        <asp:ListItem Text="PM 3" />
                                    </asp:DropDownList>
                                </div>
                                <script>
                                    $(document).ready(function () {
                                        $(".mul-select").select2({
                                            placeholder: "select Team ", //placeholder
                                            tags: true,
                                            tokenSeparators: ['/', ',', ';', " "]
                                        });
                                    })
                                </script>
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Project Source</b></label>
                                    <asp:TextBox runat="server" value="" ID="txtSource" AutoCompleteType="Disabled" autocomplete="off" onchange="psource(this);" placeholder="Enter Source" CssClass="form-control p-source"></asp:TextBox>
                                </div>
                            </div>


                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Team Member</b></label>
                                    <div class="form-group" id="team">
                                        <asp:ListBox class="mul-select form-control team-member" Width="100%" Height="60px" SelectionMode="Multiple" runat="server" ID="listmembers">
                                            <asp:ListItem  Value="0" Text="all"></asp:ListItem>
                                        </asp:ListBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Description</b></label>.
                                     <asp:TextBox runat="server" value="" AutoCompleteType="Disabled" autocomplete="off" Style="resize: none" ID="txtDescription" onchange="checkLength()" placeholder="Please Enter Minimum 200 word Description ! " TextMode="MultiLine" Height="100" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <label id="lblError" style="color: red"></label>
                                </div>
                            </div>
                        </div>
                        <style>
                            input.invalid, textarea.invalid {
                                border: 2px solid red;
                            }

                            input.valid, textarea.valid {
                                border: 2px solid green;
                            }
                        </style>

                        <div class="taskfooter">
                            <div class="clearfix">
                                <asp:Button runat="server" ID="btnsubmit" OnClientClick="javascript:return TextValidation();" OnClick="btncreate_Click" class="buttonTask1" Style="background-color: #337ab7" Text="Add" />
                                <%-- <button type="button"  class="buttonTask" style="background-color: #337ab7" >Add</button>--%>
                                <asp:Button runat="server" type="button" ID="btnupdate" OnClick="btnupdate_Click" UseSubmitBehavior="false" class="buttonTask" Style="background-color: #337ab7; display: none" Text="UPDATE" />
                                <button type="button" class="buttonTask">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add New Project Modal  End-->

        <!-- Add User Modal Start -->
        <div id="id02" class="modal">
            <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>

            <div class="container" style="margin-top: 30px;">
                <div class="row">
                    <div class="card" style="width: 80%; margin-left: -60px">
                        <div class="card-header" style="background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(198,228,255,1) 0%, rgba(229,249,252,1) 58%, rgba(103,231,255,1) 100%); color: Highlight; text-align: left;">
                            <h4 style="margin-left: 10px" id="idh4">Add Member   <small style="color: darkgray">></small><asp:Label runat="server" ID="lblProjectname"></asp:Label><asp:Label runat="server" ID="lblProjectId" Style="display: none"></asp:Label></h4>
                        </div>
                        <div class="card-body">
                            <div class="col-md-8 col-lg-8 col-sm-8 col-xs-8" style="margin-left: -22px; display: block" id="divtable1">
                                <div style="overflow-y: auto; max-height: 600px; margin-left: -10px">
                                    <table id="table" style="margin-top: 20px;">
                                    </table>

                                </div>
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-4 col-xs-4" id="divtable2" style="display: block">
                                <div style="overflow-y: auto; max-height: 600px; margin-left: -10px">
                                    <table id="table2" style="margin-top: 20px;">
                                    </table>
                                </div>
                            </div>

                        </div>

                        <div class="taskfooter">
                            <div class="clearfix">
                                <button type="button" id="btnAddUser" onclick="GetTableValues();" class="buttonTask" style="background-color: #337ab7">Add</button>
                                <button type="button" class="buttonTask">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add User Modal End -->

        <!-- Remove User Modal Start -->
        <div id="id03" class="modal">
            <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close Modal">&times;</span>

            <div class="container" style="margin-top: 30px;">
                <div class="row">
                    <div class="card" style="width: 80%; margin-left: -60px">
                        <div class="card-header" style="background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(198,228,255,1) 0%, rgba(229,249,252,1) 58%, rgba(103,231,255,1) 100%); color: Highlight; text-align: left;">
                            <h4 style="margin-left: 10px">Remove User   <small style="color: darkgray">></small><asp:Label runat="server" ID="lblRemoveUser"></asp:Label><asp:Label runat="server" ID="lblRemoveUserPID" Style="display: none"></asp:Label></h4>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" style="margin-left: -22px;" id="divtable3">
                                <div style="overflow-y: auto; max-height: 600px; margin-left: -10px">
                                    <table id="table3" style="margin-top: 20px; width: 100%;">
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="taskfooter">
                            <div class="clearfix">
                                <button type="button" id="btnRemoveUser" onclick="GetTableValuesRemoveUser();" class="buttonTask" style="background-color: #337ab7">Remove</button>
                                <button type="button" class="buttonTask">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Remove User Modal End -->

        <!-- Edit  Project Modal Start-->
        <div id="id04" class="modal">
            <span onclick="document.getElementById('id04').style.display='none'" class="close" title="Close Modal">&times;</span>

            <div class="container">
                <div class="row">
                    <div class="card" style="width: 80%; margin: 20px; margin-left: -80px">
                        <div class="card-header" style="background-color: #eee; text-align: left">
                            <h3 id="headingProjectName" style="margin-left: 10px; padding-left: 10px;"></h3>
                            <asp:Label runat="server" ID="lblidProject" Style="display: none"></asp:Label>
                        </div>
                        <div class="card-body">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12" style="display: none">
                                    <label for="psw" style="padding-top: 10px"><b>Project Name</b></label>
                                    <asp:TextBox runat="server" value="" AutoCompleteType="Disabled" autocomplete="off"  ID="txtEditProjectName" placeholder="Project Name" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Project Type</b></label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlEditProjectType" OnSelectedIndexChanged="ddlptype_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Project Type" />
                                        <asp:ListItem Text="Software" />
                                        <asp:ListItem Text="Hardware" />
                                        <asp:ListItem Text="Mechanical" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw" style="padding-top: 10px"><b>Project Sub-Type</b></label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlEditProjectSubType">
                                        <asp:ListItem Text="Select " />
                                        <asp:ListItem Text="KIOSK" />
                                        <asp:ListItem Text="ATM" />
                                        <asp:ListItem Text="PRINTER" />
                                        <asp:ListItem Text="Smart City" />
                                        <asp:ListItem Text="RMS" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Due Date</b></label>
                                    <asp:TextBox ID="txtEditDueDate" AutoCompleteType="Disabled" autocomplete="off" class="form-control" type="date" runat="server"></asp:TextBox>
                                </div>

                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <label for="psw" style="padding-top: 10px"><b>Project Manager</b></label>
                                    <asp:DropDownList runat="server" CssClass=" select form-control " ID="ddlEditProjectManager">
                                        <asp:ListItem Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <script>
                                    $(document).ready(function () {
                                        $(".mul-select").select2({
                                            placeholder: "select Team ", //placeholder
                                            tags: true,
                                            tokenSeparators: ['/', ',', ';', " "]
                                        });
                                    })
                                </script>
                            </div>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Project Source</b></label>
                                    <asp:TextBox runat="server" value="" AutoCompleteType="Disabled" autocomplete="off" ID="txtEditProjectSource" placeholder="Enter Source" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>


                            <%--       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                  <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                     <label for="psw-repeat" style="padding-top:10px"><b>Team Member</b></label>
                                     <div class="form-group">
                                     <asp:ListBox class="mul-select form-control" Width="100%"  Height="60px" SelectionMode="Multiple" runat="server"  ID="listEditTeamMember">                                               
                                     </asp:ListBox>
                                  </div>    
                                      </div>                            
                            </div>--%>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <label for="psw-repeat" style="padding-top: 10px"><b>Description</b></label>.
                                     <asp:TextBox runat="server" value="" AutoCompleteType="Disabled" autocomplete="off" Style="resize: none" ID="txtEditDescription" onchange="chkLengthEditProject(this);" placeholder="Please Enter Minimum 200 word Description ! " TextMode="MultiLine" Height="100" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                </div>
                            </div>
                             <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <label id="lblErrorEdit" style="color: red"></label>
                                </div>
                            </div>
                        </div>

                        <div class="taskfooter">
                            <div class="clearfix">
                                <asp:Button runat="server" type="submit" ID="btnUpdateProject" OnClientClick="javascript:return EditProjectValidate();" OnClick="btnUpdateProject_Click" class="buttonTask1" Style="background-color: #337ab7" Text="Update" />
                                <button type="button" class="buttonTask">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add New Project Modal  End-->

        <!-- Submit  Project Modal Start-->
        <div id="id05" class="modal">
            <span onclick="document.getElementById('id05').style.display='none'" class="close" title="Close Modal">&times;</span>

            <div class="container">
                <div class="row">
                    <div class="card" style="width: 80%; margin: 20px; margin-left: -80px">
                        <div class="card-header" style="background-color: #eee; text-align: left">
                            <h3 id="" style="margin-left: 10px; padding-left: 10px;">
                                <asp:Label runat="server" ID="lblHeadProjectName"></asp:Label></h3>
                        </div>
                        <div class="card-body" style="padding: 0">


                            <div class="tab tab_comon">
                                <ul class="nav-tabs mod_wide col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <li id="tabTesting">
                                        <a>
                                            <div class="pro_actv fl"></div>
                                            <div class="fl" id="">Testing</div>
                                            <div class="cbt"></div>
                                        </a>
                                    </li>
                                    <li id="tabSuspend">
                                        <a>
                                            <div class="pro_inactv fl"></div>
                                            <div class="fl" id="">Suspend</div>
                                            <div class="cbt"></div>
                                        </a>
                                    </li>
                                    <li id="tabFinalSubmit">
                                        <a>
                                            <div class="pro_inactv fl"></div>
                                            <div class="fl" id="">Final Submit</div>
                                            <div class="cbt"></div>
                                        </a>
                                    </li>
                                    <div class="cbt"></div>
                                </ul>
                            </div>
                            <div id="divheadProjectName" style="display: none">
                                <asp:TextBox runat="server" ID="txtheadProjectName"></asp:TextBox>
                            </div>
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" id="divTesting" style="display: none">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <div class="card-body">
                                        <%-- <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Upload File</b></label>
                                            <asp:FileUpload runat="server" ID="fileUpload" CssClass="form-control" />
                                        </div>--%>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Testing Leader <span style="color: red">*</span></b></label>
                                            <asp:DropDownList runat="server" CssClass="form-control t-leader" onchange="validateEmptyTesting(this)" ID="ddlTestingLeader" OnSelectedIndexChanged="ddlptype_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>

                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" style="display: none">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Description</b></label>
                                            <asp:TextBox runat="server" AutoCompleteType="Disabled" autocomplete="off" value="" ID="txtTestingDescription" onchange="validateEmptyTesting(this)" Style="resize: none" placeholder="Type Here ! " TextMode="MultiLine" Height="50" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Expense Type</b></label>
                                            <asp:DropDownList runat="server" CssClass="form-control" ID="ddlExpenseTypeTesting" onchange="validateEmptyTesting(this)" OnSelectedIndexChanged="ddlptype_SelectedIndexChanged">
                                                <asp:ListItem Value="0" Text="Select Expense Type" />
                                                <asp:ListItem Text="Software" />
                                                <asp:ListItem Text="Hardware" />
                                                <asp:ListItem Text="Other" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Amount</b></label>
                                            <asp:TextBox runat="server" AutoCompleteType="Disabled" autocomplete="off" value="" ID="txtExpenseAmountTesting" onkeypress="return isNumber(event)" placeholder="Amount" onchange="validateEmptyTesting(this); NumberValidate(this)" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Expense Description</b></label>
                                            <asp:TextBox runat="server" AutoCompleteType="Disabled" autocomplete="off"  value="" ID="txtExpenseDescriptionTesting" placeholder="Type Here ! " Style="resize: none" onchange="projectTestingExpenseDesc(this)" TextMode="MultiLine" Height="50" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" id="divSuspend" style="display: none">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <div class="card-body">
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Reason</b> <span style="color: red">*</span></label>
                                            <asp:TextBox runat="server" value="" ID="txtSuspendReson" AutoCompleteType="Disabled" autocomplete="off" onchange="chkLength(this);" Style="resize: none" placeholder="Please Enter Minimum 200 word Description ! " TextMode="MultiLine" Height="100" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                        </div>

                                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Expense Type</b></label>
                                            <asp:DropDownList runat="server" CssClass="form-control" onchange="validateEmptyTesting(this)" ID="ddlExpenseType" OnSelectedIndexChanged="ddlptype_SelectedIndexChanged">
                                                <asp:ListItem Value="0" Text="Select Expense Type" />
                                                <asp:ListItem Text="Software" />
                                                <asp:ListItem Text="Hardware" />
                                                <asp:ListItem Text="Other" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Amount</b></label>
                                            <asp:TextBox runat="server" value="" ID="txtAmount" AutoCompleteType="Disabled" autocomplete="off" placeholder="Amount" onkeypress="return isNumber(event)" onchange="validateEmptyTesting(this)" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Expense Description</b></label>
                                            <asp:TextBox runat="server" value="" ID="txtExpesneDescription"  AutoCompleteType="Disabled" autocomplete="off" onchange="projectSuspendExpenseDesc(this)" Style="resize: none" placeholder="Type Here ! " TextMode="MultiLine" Height="50" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" id="divFinalSubmit" style="display: none">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                    <div class="card-body">
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <table id="tableFinalSubmisionDetails" style="overflow-x:auto">
                                            </table>
                                        </div>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Project Conclusion</b><span style="color: red">*</span></label>
                                            <asp:TextBox runat="server" value="" ID="txtFinalSubmisionDescription" AutoCompleteType="Disabled" autocomplete="off" onchange="chkConclusionLength(this)" Style="resize: none" placeholder="Please Enter Minimum 200 word conclusion ! " TextMode="MultiLine" Height="100" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                        </div>

                                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Expenses Type</b></label>
                                            <asp:DropDownList runat="server" CssClass="form-control" onchange="validateEmptyTesting(this)" ID="ddlFinalSubmisionExpenseType" OnSelectedIndexChanged="ddlptype_SelectedIndexChanged">
                                                <asp:ListItem Value="0" Text="Select Expenses Type" />
                                                <asp:ListItem Text="Software" />
                                                <asp:ListItem Text="Hardware" />
                                                <asp:ListItem Text="Other" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Amount</b></label>
                                            <asp:TextBox runat="server" value="" ID="txtFinalSubmisionAmount" AutoCompleteType="Disabled" autocomplete="off" onchange="validateEmptyTesting(this)" onkeypress="return isNumber(event)" placeholder="Amount" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <label for="psw-repeat" style="padding-top: 10px"><b>Expenses Description</b></label>
                                            <asp:TextBox runat="server" value="" ID="txtFinalSubmisionExpenseDescription" AutoCompleteType="Disabled" autocomplete="off" Style="resize: none" onchange="FinalSubmitExpense(this)" placeholder="Type Here ! " TextMode="MultiLine" Height="50" CssClass="form-control" MaxLength="5"></asp:TextBox>
                                        </div>


                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <label for="psw-repeat" style="padding-top: 10px; margin-left:47px; color: red" id="lblErrorSubmitt"></label>
                            </div>
                        </div>
                        <script>

                            

                        </script>
                        <div class="taskfooter">
                            <div class="clearfix">
                                <div id="divBtnTestingSubmitt">
                                    <asp:Button runat="server" ID="btnTestingSubmitt" OnClientClick="javascript:return ProjectTestingSubmit();" OnClick="btnTestingSubmitt_Click" class="buttonTask1" Style="background-color: #337ab7" Text="Submit" />
                                    <button type="button" class="buttonTask">Cancel</button>
                                </div>
                                <div id="divBtnSuspend">
                                    <asp:Button runat="server" ID="btnSuspend" OnClientClick="javascript:return ProjectSuspend();" OnClick="btnSuspend_Click" class="buttonTask1" Style="background-color: #337ab7" Text="Suspend" />
                                    <button type="button" class="buttonTask">Cancel</button>
                                </div>
                                <div id="divBtnFinalSubmitt">
                                    <asp:Button runat="server" ID="btnFianlSubmitt" OnClientClick="javascript:return ProjectFinalSubmitt();" OnClick="btnFinalSubmitt_Click" class="buttonTask1" Style="background-color: #337ab7" Text="Submit" />
                                    <button type="button" class="buttonTask">Cancel</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add New Project Modal  End-->
    </div>


    <div id="divSuspendProject" style="display: none">
        <table id="tableSuspendProject">
        </table>
    </div>
    <script type="text/javascript">


        $(document).ready(function () {
            $(".all-addon-list > a").click(function () {
                $(".all-addon-list > ul").toggle(500);
                $(this).toggleClass('open-addon');
            });
        });



        function validateEmptyTesting(e) {
            var bt = document.getElementById("<%=btnTestingSubmitt.ClientID%>");
            var bt1 = document.getElementById("<%=btnSuspend.ClientID%>");
            <%--var bt2 = document.getElementById("<%=btnsubmit.ClientID%>");--%>
            debugger;
            if ($.trim(e.value) == "" || $.trim(e.value) == "0" || $.trim(e.value) == "selectExpenseType") {
                $("#lblErrorSubmitt").css("display", "block");
                bt.disabled = true;
                bt1.disabled = true;
                bt2.disabled = true;
                bt.style.background = 'grey';
                bt1.style.background = 'grey';
                bt2.style.background = 'grey';
                document.getElementById("lblErrorSubmitt").innerHTML = "Fill Required fields";
                return false;
            }
            else {
                bt.disabled = false;
                bt1.disabled = false;
                bt2.disabled = false;
                bt.style.background = '#337ab7';
                bt1.style.background = '#337ab7';
                bt2.style.background = '#337ab7';
                $("#lblErrorSubmitt").css("display", "none");
                document.getElementById("lblErrorSubmitt").innerHTML = "Fill Required fields";
                return false;
            }

        }
        function JSFunctionValidate() {
            debugger;
            if (document.getElementById('<%=ddlTestingLeader.ClientID%>').selectedIndex == 0) {
                alert("Please select ddl");
                return false;
            }
            return true;
        }
        function NumberValidate(e) {
            debugger;
            if ((e.which > 47 && e.which < 58) || (e.which > 95 && e.which < 106) || e.which == 110 || e.which == 8 || e.which == 9) {

            } else {
                e.preventDefault();
            }
        };

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 45 || charCode > 57)) {
                return false;
            }
            return true;

        }

    </script>



    <script type="text/javascript">
        var DOMAIN = '172.16.4.105:8080/'; //Domain
        //var HTTP_ROOT = '';   //'http://172.16.4.105:8080/orangescrum-master/'; //pageurl
        var HTTP_IMAGES = 'img/' // 'http://172.16.4.105:8080/orangescrum-master/img/'; //hid_http_images
        var MAX_FILE_SIZE = '200'; //fmaxilesize
        var SES_ID = '1'; //pub_show
        var SES_TYPE = '1';
        var GLOBALS_TYPE = { "1": { "Type": { "id": "2", "name": "Development", "short_name": "dev", "seq_order": "1" } }, "2": { "Type": { "id": "1", "name": "Bug", "short_name": "bug", "seq_order": "2" } }, "3": { "Type": { "id": "10", "name": "Update", "short_name": "upd", "seq_order": "3" } }, "4": { "Type": { "id": "12", "name": "Change Request", "short_name": "cr", "seq_order": "4" } }, "5": { "Type": { "id": "11", "name": "Idea", "short_name": "idea", "seq_order": "5" } }, "6": { "Type": { "id": "3", "name": "Enhancement", "short_name": "enh", "seq_order": "6" } }, "7": { "Type": { "id": "4", "name": "Research n Do", "short_name": "rnd", "seq_order": "7" } }, "8": { "Type": { "id": "7", "name": "Maintenance", "short_name": "mnt", "seq_order": "8" } }, "9": { "Type": { "id": "5", "name": "Quality Assurance", "short_name": "qa", "seq_order": "9" } }, "10": { "Type": { "id": "6", "name": "Unit Testing", "short_name": "unt", "seq_order": "10" } }, "11": { "Type": { "id": "9", "name": "Release", "short_name": "rel", "seq_order": "11" } }, "12": { "Type": { "id": "8", "name": "Others", "short_name": "oth", "seq_order": "12" } } };
        var DESK_NOTIFY = 1;
        var CONTROLLER = 'users';
        var PAGE_NAME = 'manage';
        var ARC_CASE_PAGE_LIMIT = 10;
        var ARC_FILE_PAGE_LIMIT = 10;
        var PUSERS = { "4bd2520594153ca4072ffb7d3855b04c": [{ "User": { "id": "3", "uniq_id": "b59d4eaba20cee4f934c75cf2df14402", "name": "Invite", "email": "Raghuraj.Jhala@lipi.in", "istype": "3", "short_name": null } }, { "User": { "id": "5", "uniq_id": "191b6ad529a4c50cc85c41e1516e7267", "name": "Kuldeep", "email": "kuldeep.choudhary@lipi.in", "istype": "3", "short_name": null } }, { "User": { "id": "1", "uniq_id": "de17dee4de5da5a03e644d172dc75847", "name": "lakshya.sanadhya", "email": "lakshya.sanadhya@lipi.in", "istype": "2", "short_name": "LA" } }] };
        var PROJECTS = [{ "Project": { "id": "3", "uniq_id": "4bd2520594153ca4072ffb7d3855b04c", "name": "a1", "default_assign": "1" } }, { "Project": { "id": "2", "uniq_id": "2bdf6c2dc8ff565e70186f9996d5ecd6", "name": "P1", "default_assign": "1" } }, { "Project": { "id": "1", "uniq_id": "062abdf226e93a198b2e0cfbd6ae3027", "name": "Digital Signage", "default_assign": "1" } }];
        var defaultAssign = '';
        var dassign;
        var TASKTMPL = [];
        var SITENAME = 'Orangescrum';
        var TITLE_DLYUPD = 'Daily Update - 09/07';
    </script>

    <!--<script type="text/javascript" src="http://172.16.4.105:8080/orangescrum-master/js/jquery-ui.min.1.8.10.js"></script>-->




    <!-- Google drive starts-->
    <script type="text/javascript">
        var CLIENT_ID = "XXXXXXXXXXXX.apps.googleusercontent.com";
        var REDIRECT = "http://172.16.4.105:8080/orangescrum-master/users/googleConnect";
        var API_KEY = "xXxXXxxxxxXXXXXXXXXXXXXxXXxxxx";
        var DOMAIN_COOKIE = "172.16.4.105";
    </script>


    <!-- Add Project At Runtime Start-->
    <script>

        function addProject() {

            var projectname = $('#txt_Proj').val();
            $.ajax({
                type: "POST",
                url: "Projects.aspx/saveProject", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Projectname:'" + projectname + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {
                        $("#popup_bg").css("display", "none");
                        loadProjects();
                    }
                },
                failure: function (error) {
                    alert(error);
                }
            });


        }
    </script>
    <!-- Add Project At Runtime End-->


    <script>

        $(document).ready(function () {

            var toOpenCPModal = localStorage.getItem("openCreateProjectModal");
            if (toOpenCPModal == "true") {
                $("#id01").show("slide", { direction: "left" }, 0);
                localStorage.setItem("openCreateProjectModal", "false");

              <%--  var bt = document.getElementById("<%=btnsubmit.ClientID%>");--%>
                bt.disabled = true;
                bt.style.background = 'grey';
                $("#lblError").css("display", "block");
                document.getElementById("lblError").innerHTML = "Fill Required fields";

            }

            $(".create .createspan").click(function () {
                $("#id01").show("slide", { direction: "left" }, 0);  // Add Project Modal //
                //$("#id01").css("display", "block");
               <%-- var bt = document.getElementById("<%=btnsubmit.ClientID%>");--%>
                //bt.disabled = true;
                //bt.style.background = 'grey';
                //$("#lblError").css("display", "block");
                document.getElementById("lblError").innerHTML = "Fill Required fields";
            });

        });
        


      

        $(document).on("click", ".popup_user .fr", function () {
            $(".popup_user").css("display", "none");
        });

        function toggle(source) {
            var checkboxes = document.querySelectorAll('input[type="checkbox"]');
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i] != source)
                    checkboxes[i].checked = source.checked;
            }
        }
        
          </script>


    <script type="text/javascript">
        
        
    </script>
    <script type="text/javascript">

        loadProjects();


        $(document).on("mouseenter", ".proj_mng_div .contain ", function () {

            $(this).find(".proj_mng").stop(true, true).animate({
                bottom: "0px",
                opacity: 1
            }, 400);

        });

        $(document).on("mouseleave", ".proj_mng_div .contain ", function () {

            $(this).find(".proj_mng").stop(true, true).animate({
                bottom: "-42px",
                opacity: 0
            }, 400);
        });


        function loadProjects() {
            $.ajax({
                type: "POST",
                url: "Projects.aspx/getProject", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    //var html = document.getElementById("html").innerHTML;
                    //html = html.replace(/"/g, "'");
                    //debugger;
                    var i = 0;
                    var newhtml = "";
                    $.each(data.d, function (key, val) {
                        //<h4 class='prj_id' style='display:none' id='projectId' >" + data.d[key].idProjects + "</h4>
                        newhtml += "<div class='col-lg-4 proj_mng_div' >" +
                                   "<div class='col-lg-12 contain usr_mng_div '>" +
                                   "<h3 class='prj_name'><a href='' title=''>" + data.d[key].ProjectName + "</a> </h3>" +
                                   "<h3 class='prj_name' style='display:none'><a href='' title=''>" + "#" + data.d[key].idProjects + "</a> </h3>" +
                                   "<div class='user-details prj_details'>" +
                                   "<div class='fl usr_lt'><div class='user-image'>" +
                                   "<a href=''><img src='project_files/prj_icon.png'></a></div>" +
                                   "<div class='user-nm'>WWW</div></div><div class='fl usr_rt'>" +
                                   "<div class='border_usr'><b><span id='tot_prjusers3'>" + data.d[key].UserCount + "</span></b> User(s)</div>" +
                                   "<div><b>" + data.d[key].taskcount + "</b> Task(s)</div><div><b>" + data.d[key].WorkingHour + "</b> Hour(s) Spent</div>" +
                                   "<div><b></b></div></div></div><div class='last_updt prj_last_updt'>Last Activity: " + data.d[key].RecentActivity + "</div><div class='proj_mng' id='proj_mng' style='bottom: -42px; opacity: 0;'><div class='fl'><a href='javascript:void(0);' class='icon-add-usr fl' data-prj-id='3' data-prj-name='A1'>Add User</a><br><span id='remove3'><a href='javascript:void(0);' class='icon-remove-usr' data-prj-id='3' data-prj-name='A1'>Remove User</a></span><span id='ajax_remove3' style='display: none;'><a href='javascript:void(0);' class='icon-remove-usr' data-prj-id='3' data-prj-name='A1'>Remove User</a></span></div><div class='fr'><a href='javascript:void(0);' class='icon-edit-usr fl' data-prj-id='4bd2520594153ca4072ffb7d3855b04c' data-prj-name='A1'>Edit</a><br><a href='javascript:void(0);' class='icon-disable-usr fl disbl_prj' data-prj-id='3' data-prj-name='A1'>Submitt</a></div></div></div></div>";


                    });
                    $("#thumbnail").append(newhtml);
                },
                failure: function (error) {
                    alert(error);
                }
            });
        }



        $(function () {

            $(".more_in_menu").parent("li").click(function () {
                if ($(".more_menu_li").css("display") == "none") {
                    $(".more_menu_li").css({ display: "block" });
                    $(this).children("a.more_in_menu").text("Less");
                    $(this).addClass("open");
                    $(".cust_rec").css({ display: "none" });
                }
                else {
                    $(".more_menu_li").css({ display: "none" });
                    $(this).children("a.more_in_menu").text("More");
                    $(this).removeClass("open");
                    $(".cust_rec").css({ display: "block" });
                }
            });


            $('[rel=tooltip]').tipsy({ gravity: 's', fade: true });
            $(".scrollTop").click(function () {
                $('html, body').animate({ scrollTop: 0 }, 1200);
            });
            $('body').click(function () {
                $(".tipsy").remove();
            });
        });

        function showhelp() {
            openPopup();
            $('.popup_bg').css({ 'width': '700px' });
            $('.loader_dv').hide();
            $('.help_popup').show();
        }


        $(".addproject").click(function () {
            $("#id01").show("slide", { direction: "left" }, 0);
            <%--var bt = document.getElementById("<%=btnsubmit.ClientID%>");
            bt.disabled = true;
            bt.style.background = 'grey';
            $("#lblError").css("display", "block");
            document.getElementById("lblError").innerHTML = "Fill Required fields";--%>
            debugger;
            $('#multiple-checkboxes').multiselect({
                includeSelectAllOption: true,
            });


        });
        
        
       
        $(document).ready(function () {
            
        })
     
    </script>   
    <script src="js/Project/Project.js"></script>
</asp:Content>


