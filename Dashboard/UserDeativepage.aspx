<%@ Page Language="C#" MasterPageFile="~/Dashboard/DSMaster.master" AutoEventWireup="true" CodeFile="UserDeativepage.aspx.cs" Inherits="UserDeativepage" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="mainContent" runat="server">
  
   <input type="hidden" name="pub_counter" id="pub_counter" value="0">
    <input type="hidden" name="hid_casenum" id="hid_casenum" value="0">
    <div style="display:block; position:fixed; width:88%; text-align:center;z-index: 2147483647; position:fixed">
        <div onclick="removePubnubMsg();" id="punnubdiv" align="center" style="display:none;">
            <div class="fls-spn">
                <div id="pubnub_notf" class="topalerts alert_info msg_span"></div>
                <div class="fr close_popup" style="margin:-48px 8px 0 0;">X</div>
            </div>
        </div>
    </div>
    <!-- Flash Success and error msg starts --> 
    <div id="topmostdiv">
                    <div onclick="removeMsg();" id="upperDiv" align="center" style="display:none; margin:0px auto;position:relative; text-align:center;">
                <div class="fls-spn" id="msg-spn">
                    <div class="topalerts success msg_span">
                                            </div>
                    <div class="fr close_popup" style="margin:-48px 8px 0 0;">X</div>
                </div>
            </div>
            </div>
    <!-- Flash Success and error msg ends --> 
    <!-- common popups like Create task, Create project, Invite User -->
<!--[if lte IE 9]>
    <style>
        #chked_all{top:2px!important;}
    </style>	
<![endif]-->
<div class="popup_overlay"></div>
<div class="popup_bg">
    <!-- New project popup starts -->
    <div class="new_project cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-create-proj"></i> Create New Project</span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_proj" style="display: none;">
<form action="http://172.16.4.105:8080/orangescrum-master/projects/add_project" name="projectadd" onsubmit="return projectAdd(&#39;txt_Proj&#39;,&#39;txt_shortProj&#39;,&#39;loader&#39;,&#39;btn&#39;)" id="ProjectManageForm" method="post" accept-charset="utf-8"><div style="display:none;"><input type="hidden" name="_method" value="POST"><input type="hidden" name="data[_Token][key]" value="31a9449c43fe881011857f9369649e656c7931562cd788c645d79eb7977f9da43765fc8810f7fc94ed0a210d9c05919600f20ad744c317f7484873393c2a9715" id="Token1416387029"></div>    <div class="data-scroll">
    <table cellpadding="0" cellspacing="0" class="col-lg-12">
	<tbody><tr>
	    <td class="popup_label">Project Name:</td>
	    <td>
		<input name="data[Project][name]" value="" class="form-control" id="txt_Proj" placeholder="My Project" maxlength="50" type="text">		<div id="err_msg_project_name" class="err_msg"></div>
	    </td>
	</tr>
	<tr>
	    <td>Short Name:</td>
	    <td>
		<input name="data[Project][short_name]" value="" class="form-control ttu" id="txt_shortProj" placeholder="MP" maxlength="5" type="text">		<div id="err_msg_short_name" class="err_msg"></div>
                <span id="ajxShort" style="display:none">
		    <img src="./Orangescrum3_files/del.gif" width="16" height="16">
		</span>
		<span id="ajxShortPage"></span>
	    </td>
	</tr>
		<tr>
	    <td class="v-top">
		<div style="text-align:right">
    		    <span id="add_new_member_txt">
			    				Add new Users:
			    	
    		    </span>
    		    <div class="opt_field">(optional)</div>
    		</div>
	    </td>
	    <td style="text-align:left">
		<div class="fl check_user">
		    			<label class="checkbox-inline" style="margin:0 10px 5px 0;">
			<input type="checkbox" checked="checked" name="data[Project][members][]" class="proj_mem_chk" onclick="addremoveadmin(this)" value="1">
			&nbsp;<span id="puser1">lakshya.sanadhya</span>
						    <span class="user_green">(owner)</span>
						</label>
		    								
		</div>
		<textarea id="members_list" class="wickEnabled form-control expand" rows="2" wrap="virtual" name="data[Project][members_list]" style="height: 0px; overflow: hidden; padding-top: 8px; padding-bottom: 8px;"></textarea>
		<div class="user_inst">(Use comma to separate multiple email ids)</div>
                <div id="err_mem_email" class="err_msg"></div>
		<div id="autopopup"></div>
	    </td>
	</tr>
			    </tbody></table>    
    </div>
    <div style="padding-left:145px;">
        		<input type="hidden" name="data[Project][validate]" id="validate" readonly="true" value="0">
    		<span id="loader" style="display:none;">
    		    <img src="./Orangescrum3_files/case_loader2.gif" alt="Loader">
    		</span>
    		<span id="btn">
    		    <button type="button" value="Create" name="crtProject" class="btn btn_blue" onclick="return projectAdd(&#39;txt_Proj&#39;,&#39;txt_shortProj&#39;,&#39;loader&#39;,&#39;btn&#39;);"><i class="icon-big-tick"></i>Create</button>
		    <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                 <span class="or_cancel">or
                    <a onclick="closePopup();">Cancel</a>
                </span>
    		</span>
		            </div>
<div style="display:none;"><input type="hidden" name="data[_Token][fields]" value="a0a58eae38e8321e0966566cf60754f5b9ed3428%3A" id="TokenFields155073783"><input type="hidden" name="data[_Token][unlocked]" value="" id="TokenUnlocked1790792249"></div></form></div>
        </div>
    </div>
    <!-- New project popup ends -->

    <!-- Task type popup starts -->
    <div class="new_tasktype cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-create-tsk-type"></i> New Task Type</span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_tasktype" style="display: none;">
                <center><div id="tterr_msg" style="color:#FF0000;display:none;"></div></center>
                <form name="task_type" id="customTaskTypeForm" method="post" action="http://172.16.4.105:8080/orangescrum-master/projects/addNewTaskType" autocomplete="off">
                    <input type="hidden" class="form-control" name="data[Type][id]" id="new-typeid">
                    <div class="data-scroll">
                        <table cellpadding="0" cellspacing="0" class="col-lg-12">
                            <tbody><tr>
                                <td class="popup_label">Name:</td>
                                <td>
                                    <input type="text" value="" class="form-control" name="data[Type][name]" id="task_type_nm" placeholder="Design" maxlength="20">
                                </td>
                            </tr>
                            <tr>
                                <td class="popup_label">Short Name:</td>
                                <td>
                                    <input type="text" value="" class="form-control" name="data[Type][short_name]" id="task_type_shnm" placeholder="dgn" maxlength="4">
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                    <div style="padding-left:145px;">
                        <span id="ttloader" style="display:none;">
                            <img src="./Orangescrum3_files/case_loader2.gif" alt="Loader">
                        </span>
                        <span id="ttbtn">
                            <button id="newtask_btn" type="button" value="Add" onclick="return validateTaskType();" name="crttasktype" class="btn btn_blue"><i class="icon-big-tick"></i>Add</button>
                            <span class="or_cancel">or
                                <a onclick="closePopup();">Cancel</a>
                            </span>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Task type popup ends -->

    <!-- Help popup starts -->
    <div class="help_popup cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-help-user"></i> Need help getting started?</span>
            <a href="javascript:jsVoid();" onclick="trackclick(&#39;Close Button&#39;);closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div class="help-text"> 
                If you get stuck or need help with anything we are here for you. Just <a data-toggle="dropdown" class="dropdown-toggle support-popup" href="javascript:void(0);" onclick="trackclick(&#39;Send us a line&#39;)">send us a line</a> we will get back to you as soon as possible or find your answer at our <a href="http://172.16.4.105:8080/orangescrum-master/help" target="_blank" onclick="trackclick(&#39;Help Desk&#39;);">help desk</a>.</div>
            <div class="hlpe_popbtn"><button class="btn btn_blue" onclick="closePopup();trackclick(&#39;Ok ,got it!&#39;);"><i class="icon-big-tick"></i>Ok, got it!</button></div>			
        </div>
    </div>
    <!-- Help popup ends -->

    <!-- Move project popup starts -->
    <div class="mv_project cmn_popup" style="display: none;">
        <div class="popup_title">
            <span>
                <i class="icon-mov-proj"></i> 
                <span class="hdr-cnt">
                    <span id="header_mvprj" class="fnt-nrml"></span>
                </span>
            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_mvproj" style="display: none; "></div>
        </div>
    </div>
    <!-- Move project popup ends -->

    <!-- New user popup starts -->
    <div class="new_user cmn_popup" style="display: none; background-color:white;">
        <div class="popup_title">
            <span> <i class="icon-create-user"></i> <span id="add_edit_span">Add New User</span></span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form" style=" background-color:white;">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_user" style="display: none;">
                <form action="http://172.16.4.105:8080/orangescrum-master/users/new_user" id="myform" name="myform" onsubmit="return memberCustomer(&#39;txt_email&#39;,&#39;username&#39;,&#39;password&#39;,&#39;sel_custprj&#39;,&#39;loader&#39;,&#39;btn&#39;)" method="post" accept-charset="utf-8"><div style="display:none;"><input type="hidden" name="_method" value="POST"><input type="hidden" name="data[_Token][key]" value="31a9449c43fe881011857f9369649e656c7931562cd788c645d79eb7977f9da43765fc8810f7fc94ed0a210d9c05919600f20ad744c317f7484873393c2a9715" id="Token1090439824"></div><div class="data-scroll user_pdt">
<table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab">
            <tbody><tr>
	<td class="v-top">
                Name:
            </td>
            <td>
                <input type="text" name="data[User][name]" id="username" class="form-control" style="width:352px;">
                
                <div id="err_name" class="err_msg"></div>
            </td>
        </tr>
        <tr>
            <td class="v-top">
	    Email ID:
	</td>
	<td> 
                <input type="text" class="form-control" name="data[User][email]" style="width:352px;height:35px;" id="txt_email">
                	    <input type="hidden" name="data[User][istype]" value="3" id="sel_Typ">
            <input type="hidden" name="data[User][user_id]" value="" id="user_id">
                <div id="err_email_new" class="err_msg"></div>
                <!--<div class="user_inst">(Use comma to separate multiple email ids)</div>-->
			</td>
    </tr>
        <tr>
            <td class="v-top">
                Password:
            </td>
            <td>
                <input type="password" name="data[User][password]" id="password" class="form-control" style="width:352px;">
                
                <div id="err_password_new" class="err_msg"></div>
            </td>
        </tr>
	    <tr>
	<td class="v-top">
	    Project to be<br>assigned: <br>
	</td>
	<td>
	    <div class="input select"><select name="data[User][pid]" id="select_project" class="form-control">
<option value="1">Digital Signage</option>
<option value="2">P1</option>
<option value="3">a1</option>
</select></div>	</td>
    </tr>
	    <input type="hidden" name="data[TimezoneName][id]" value="49" id="txt_loc">
</tbody></table>
</div>
 <div style="padding-left:320px;"> 
	    	    
	    <span id="ldr" style="display:none;">
		<img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading...">
	    </span>
	    <span id="btn_addmem">
		<input type="hidden" id="uniq_id" value="a65d0aa53291fcf2b87cd7f53a3eead5">
		<button type="submit" value="Add" name="addMember" class="btn btn_blue" id="add_user_btn"><i class="icon-big-tick"></i>Add</button>
		<button type="submit" class="btn btn_blue" name="Update" value="Update" id="update_user_btn" style="display: none;">Update</button>
         <span class="or_cancel">
             <a class="btn btn-default" onclick="closePopup();">Cancel</a>
        </span>
	    </span>
		</div> 
<div style="display:none;"><input type="hidden" name="data[_Token][fields]" value="89a2b470f91d58d7908c9f33aab3a48d1763fc10%3A" id="TokenFields1257435669"><input type="hidden" name="data[_Token][unlocked]" value="" id="TokenUnlocked663211360"></div></form><script>

                                                                                                                                                                                                                                                                    var active_prjct = "3";

    </script>
            </div>
        </div>
    </div>
    <!-- New user popup ends  -->
    <div class="new_contact cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-create-user"></i> Contact Sales</span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_contact" style="display: none;">
                <form action="http://172.16.4.105:8080/orangescrum-master/users/new_contact" id="mycontactform" name="myformcontact" onsubmit="return validate_contact();" method="post" accept-charset="utf-8"><div style="display:none;"><input type="hidden" name="_method" value="POST"><input type="hidden" name="data[_Token][key]" value="31a9449c43fe881011857f9369649e656c7931562cd788c645d79eb7977f9da43765fc8810f7fc94ed0a210d9c05919600f20ad744c317f7484873393c2a9715" id="Token322882389"></div><center><div id="err_cont_div" style="color:#FF0000;display:none;"></div></center>
<div class="data-scroll user_pdt">
<table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab">
  
    <tbody><tr>
	<td class="v-top">
	    Name:
	</td>
	<td> 
	    <input name="data[Contact][name]" id="contact_name" class="form-control" type="text">      </td></tr>
     <tr>
	<td class="v-top">
	    Email:
	</td>
	<td> 
	    <input name="data[Contact][email]" id="contact_email" class="form-control" type="text">	</td>
    </tr>
        <tr>
	<td class="v-top">
	    Message:
	</td>
	<td> 
	    <textarea name="data[Contact][message]" id="contact_message" class="form-control"></textarea>	  
	</td>
    </tr>

    
</tbody></table>
</div>
 <div style="padding-left:124px;"> 
	    	    
	    <span id="ldr" style="display:none;">
		<img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading...">
	    </span>
	    <span id="btn_addmem">
		<input type="hidden" id="uniq_id" value="a65d0aa53291fcf2b87cd7f53a3eead5">
		<button type="submit" value="Add" name="addMember" class="btn btn_blue"><i class="icon-big-tick"></i>Add</button>
		<!--<button class="btn btn_grey reset_btn" type="button" name="cancel" onclick="closePopup();" ><i class="icon-big-cross"></i>Cancel</button>-->
         <span class="or_cancel">or
            <a onclick="closePopup();">Cancel</a>
        </span>
	    </span>
		</div> 
<div style="display:none;"><input type="hidden" name="data[_Token][fields]" value="67fe131efeba9f3c0de87b300acd2b22cb114cf4%3A" id="TokenFields184059609"><input type="hidden" name="data[_Token][unlocked]" value="" id="TokenUnlocked817439371"></div></form><script>
                                                                                                                                                                                                                                                                   var active_prjct = "3";
</script>
             </div>
        </div>
    </div>
    <!-- Export csv popup starts -->
    <div class="exportcsv cmn_popup" style="display: none;max-height:570px;overflow-y: auto" id="exporttaskcsv_popup">
        <div class="popup_title">
            <span><i class="icon-exp"></i><span id="popup_heading">Export Tasks to CSV</span></span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="exportcsv_content" style="display: none;"></div>
        </div>
    </div>
    <!-- Export csv popup ends -->
    <!-- Cancel Subscription popup starts -->
    <div class="cancel_sub_popup_content cmn_popup scrollTop" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-create-proj"></i> Cancel Subscription Information</span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="cancel_sub_popup_content" style="display: none;"></div>
        </div>
    </div>
    <!-- Cancel Subscription popup ends -->

    <!-- Profile Image popup starts -->
    <div class="prof_img cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-create-proj"></i>Profile Image</span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form popup_form_one">
            <div id="inner_prof_img">
                <form enctype="multipart/form-data" method="POST" action="http://172.16.4.105:8080/orangescrum-master/users/show_preview_img/" id="file_upload1" class="upload applied file_upload">
                    <div class="customfile" id="inputfileid" style="display:none;">                
                            <span aria-hidden="true" class="customfile-button">Browse</span>                
                            <span aria-hidden="true" class="customfile-feedback">Select your profile image...</span>                
                            <input type="file" size="50" name="data[User][photo]" class="fileupload customfile-input" id="upldphoto">               
                        </div><table cellpadding="0" cellspacing="0" class="col-lg-12">
                <!--	<tr>
                            <td > -->
                        
                        <!--    </td>								
                        </tr> -->
                        <tbody><tr>
                            <td>
                                <div>Drag and set the box on the area you want to crop.</div>
                                <br>
                                <span id="profLoader" style="display:none">
                                    <img src="./Orangescrum3_files/del.gif" alt="Loading..." width="16" height="16">
                                </span>
                                <div id="up_files_usr" class="up_files"></div>
                                <!--<div id="up_files1" class="up_files"></div>-->
                                <input type="hidden" id="imgName" name="data[User][photo]">
                            </td>
                        </tr>
                        <tr>
                            <td>									
                                <!-- hidden inputs -->
                                <input type="hidden" id="x" name="x">
                                <input type="hidden" id="y" name="y">
                                <input type="hidden" id="w" name="w">
                                <input type="hidden" id="h" name="h">
                                <div id="actConfirmbtn" style="display:none;">
                                    <button type="button" value="Confirm" class="btn btn_blue file_confirm_btn" onclick="doneCropImage()"><i class="icon-big-tick"></i>Confirm</button>
                                    <div id="file_confirm_btn_loader" style="float: left;width: 60px;display:none;"><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></div>
                                    <button class="btn btn_grey reset_btn file_confirm_btn" type="button" onclick="profilePopupCancel();"><i class="icon-big-cross"></i>Cancel</button>
                                </div>
                                <div id="inactConfirmbtn" style="display:block;">
                                    <button type="button" value="Confirm" class="btn btn_blue btn_impcsv" disabled="disabled" onclick="javascript:void(0);"><i class="icon-big-tick"></i>Confirm</button>
                                    <button class="btn btn_grey reset_btn" type="button" onclick="profilePopupCancel();"><i class="icon-big-cross"></i>Cancel</button>
                                </div>
                            </td>
                        </tr>	
                    </tbody></table>
                </form>
            </div>
        </div>
    </div>
    <!-- Profile Image popup ends -->

    <!-- Select tabs popup starts -->
    <div class="select_tab cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-create-proj"></i> Select tabs to enable</span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_select_tab"></div>
        </div>
    </div>
    <!-- Select tabs popup ends -->

    <!-- Edit Project popup starts -->
    <div class="edt_prj cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-edit-projct"></i><span id="header_prj"></span></span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_prj_edit"></div>
        </div>
    </div>
    <!-- Edit Project popup ends -->

    <!-- Remove users from Project popup starts -->
    <div class="rmv_prj_usr cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <div class="hdr-cnt fl">Remove User</div>
            <div class="fl"><img src="./Orangescrum3_files/icon_breadcrumbs.png"></div>
            <div id="header_prj_usr_rmv" class="fnt-nrml prj_hd_title fl"></div>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="remusersrch" class="col-lg-4 mrt-14 top-10 fr" style="display:none;">
                <input name="data[name]" class="form-control pro_srch" id="rmname" maxlength="100" onkeyup="searchListWithInt(&#39;searchuserrem&#39;,600)" placeholder="Enter User Name" type="text">                <i class="icon-srch-img chng_icn"></i>
            </div>
            <span id="popupload2" class="usr-srh" style="display: none">Loading users... <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..."></span>
            <div class="cb"></div>
            <div id="inner_prj_usr_rmv"></div>

            <div class="rmv-btn">
                <center>
                    <span id="rmvloader" class="ldr-ad-btn">
                        <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                    </span>
                    <span id="rmv_btn">
                        <button class="btn btn_blue" id="rmvbtn" value="Remove" type="button" onclick="removeusers()"><i class="icon-big-tick"></i>Remove</button>
                        <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                        <span class="or_cancel">or<a onclick="closePopup();">Cancel</a></span>
                    </span>
                </center>
            </div>
        </div>
    </div>
    <!-- Remove users from Project popup ends -->

    <!-- Add users from Project popup starts -->
    <div class="add_prj_usr cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <div class="hdr-cnt fl">Add User </div>
            <div class="fl"><img src="./Orangescrum3_files/icon_breadcrumbs.png"></div>
            <div id="header_prj_usr_add" class="fnt-nrml fl prj_hd_title"></div>

            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
                            <a id="invite_usr" class="dropdown-toggle upgrade_btn" onclick="newUser();" href="javascript:jsVoid();">
                    <button class="btn blue_btn blue_btn_lrg fr mrt-10" type="button">
                        <i class="icon-invite-usr"></i>
                        Invite New User
                    </button>
                </a>
                        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <input type="hidden" name="prjct_id" id="prjct_id">
            <input type="hidden" name="prjct_name" id="prjct_name">      
            <div class="fl" style="overflow: auto; max-height: 90px; width: 576px;">
                <ul id="userList" class="holder" style="border:1px solid #FAFAFA">
                </ul>
            </div>
            <div id="usersrch" class="col-lg-4 mrt-14 fr" style="display:none;">
                <input name="data[name]" class="form-control pro_srch" id="name" maxlength="100" onkeyup="searchListWithInt(&#39;searchuser&#39;,600)" placeholder="Enter User Name" type="text">                <i class="icon-srch-img chng_icn"></i>
            </div>
            <span id="popupload1" class="usr-srh">Loading users... <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..."></span>
            <div class="cb"></div>
            <div id="inner_prj_usr_add"></div>

            <div class="add-usr-btn" style="display: none;">
                <span id="userloader" style="display: none;">
                    <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                </span>
                <span id="popupload" class="ldr-ad-btn">Loading users... <img src="./Orangescrum3_files/case_loader2.gif" title="Loading..." alt="Loading..."></span>
                <span id="confirmbtn" style="display:block;">
                    <button class="btn btn_blue" id="confirmusercls" value="Confirm" type="button" onclick="assignuser(this)"><i class="icon-big-tick"></i>Add</button>
                    <button class="btn btn_blue" id="confirmuserbut" value="Confirm" type="button" onclick="assignuser(this)"><i class="icon-big-tick"></i>Add &amp; Continue</button>
                    <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                    <span class="or_cancel">or
                        <a onclick="closePopup();">Cancel</a>
                    </span>
                </span>

                <span id="excptAddContinue" style="display:none;">
                    <button class="btn btn_blue" id="confirmusercls" value="Confirm" type="button" onclick="assignuser(this)"><i class="icon-big-tick"></i>Add</button>
                    <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                    <span class="or_cancel">or
                        <a onclick="closePopup();">Cancel</a>
                    </span>
                </span>
            </div>
        </div>
    </div>
    <!-- Add users from Project popup ends -->


    <!-- Add project to a user popup starts -->
    <div class="add_usr_prj cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <span class="hdr-cnt">Assign Project
                <span><img src="./Orangescrum3_files/icon_breadcrumbs.png"></span>
                <span id="invite_user_cls" class="fnt-nrml"></span>
            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>

            <a id="creat_pro" class="dropdown-toggle upgrade_btn" onclick="newProject();" href="javascript:jsVoid();">
                <button class="btn blue_btn blue_btn_lrg fr mrt-10" type="button">
                    <i class="icon-invite-proj"></i>
                    Create New Project
                </button>
            </a>

        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>

            <div class="fl" style="overflow: auto; max-height: 90px; width: 576px;">
                <ul id="prjList" class="holder" style="border:1px solid #FAFAFA">
                </ul>
            </div>
            <div id="prjsrch" class="col-lg-4 mrt-14 fr" style="display:none;">
                <input name="data[name]" class="form-control pro_srch" id="proj_name" maxlength="100" onkeyup="searchListWithInt(&#39;searchproj&#39;,600)" placeholder="Enter Project Name" type="text">                <i class="icon-srch-img chng_icn"></i>
            </div>
            <div class="cb"></div>
            <span id="prjpopupload1" class="usr-srh">Loading projects... <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..."></span>
            <div class="cb"></div>
            <div id="inner_usr_prj_add"></div>

            <div class="add-prj-btn" style="display: none;">
                <span id="prjloader" class="ldr-ad-btn">
                    <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                </span>
                <span id="prjpopupload" class="ldr-ad-btn">Loading projects... <img src="./Orangescrum3_files/case_loader2.gif" title="Loading..." alt="Loading..."></span>
                <span id="confirmbtnprj" style="display:block;">
                    <button class="btn btn_blue" id="confirmprjcls" value="Confirm" type="button" onclick="assignproject(this)"><i class="icon-big-tick"></i>Assign</button>
                    <button class="btn btn_blue" id="confirmprjbut" value="Confirm" type="button" onclick="assignproject(this)"><i class="icon-big-tick"></i>Assign &amp; Continue</button>
                    <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                    <span class="or_cancel">or<a onclick="closePopup();">Cancel</a></span>
                </span>
            </div>
        </div>
    </div>
    <!-- Add project to a user popup ends -->

    <!-- Remove projects of a user popup starts -->
    <div class="rmv_usr_prj cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <span class="hdr-cnt">Remove Project
                <span><img src="./Orangescrum3_files/icon_breadcrumbs.png"></span>
                <span id="header_usr_prj_rmv" class="fnt-nrml"></span>
            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="remprjsrch" class="col-lg-4 mrt-14 top-10 fr" style="display:none;">
                <input name="data[name]" class="form-control pro_srch" id="rmprjname" maxlength="100" onkeyup="searchListWithInt(&#39;searchprojrem&#39;,600)" placeholder="Enter Project Name" type="text">                <i class="icon-srch-img chng_icn"></i>
            </div>
            <span id="rempopupload" class="usr-srh" style="display: none">Loading projects... <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..."></span>
            <div class="cb"></div>
            <div id="inner_usr_prj_rmv"></div>

            <div class="rmv-prj-btn">
                <center>
                    <span id="rmvprjloader" class="ldr-ad-btn">
                        <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                    </span>
                    <span id="rmv_prj_btn">
                        <button class="btn btn_blue" id="rmvprjbtn" value="Remove" type="button" onclick="removeprojects()"><i class="icon-big-tick"></i>Remove</button>
                        <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                        <span class="or_cancel">or<a onclick="closePopup();">Cancel</a></span>
                    </span>
                </center>
            </div>
        </div>
    </div>
    <!-- Remove projects of a user popup ends -->
    <!-- Add or Edit Milestone popup starts -->
    <div class="mlstn cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i id="icon_mlstn" class="icon-create-proj"></i><div id="header_mlstn" class="fl mlstn_nm_long">Create Milestone</div></span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv" id="addeditMlst"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_mlstn" class="mils_ipad"></div>
        </div>
    </div>
    <!-- Add or Edit Milestone popup ends -->

    <!-- Add cases to Milestone popup ends -->
    <div class="mlstn_case cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <div class="hdr-cnt">
                <div class="fl">&nbsp;Add Tasks&nbsp;</div>
                <div class="fl">&nbsp;<img src="./Orangescrum3_files/icon_breadcrumbs.png">&nbsp;</div>
                <div id="header_prj_ttl" class="fl fnt-nrml"></div>
                <div class="fl">&nbsp;<img src="./Orangescrum3_files/icon_breadcrumbs.png">&nbsp;</div>
                <div id="header_mlstn_ttl" class="fl fnt-nrml ttc adtskmlstn_ttl"></div>

                <div class="fl" style="position: relative;">&nbsp;&nbsp;
                    <a href="javascript:void(0);"><span id="switch_mlstn" style="font-size: 12px;text-decoration:underline;" onclick="view_project_milestone();">Switch Milestone</span></a>
                    <ol style="list-style-type: none;">
                        <li class="dropdown" id="mlstn_drpdwn" style="position: absolute; top: 7px;left: 13px;">
                            <div class="dropdown-menu lft popup" id="mlstnpopup" style="left: 0px;left: 0px;min-height: 30px; height:auto;">
                                <center>
                                    <div id="loader_mlsmenu" style="display:none;position: absolute;left: 93px;">
                                        <img src="./Orangescrum3_files/del.gif" alt="loading..." title="loading...">
                                    </div>
                                </center>
                                <div id="ajaxViewMilestonesCP"></div>
                            </div>
                        </li>
                    </ol>
                </div>
                <div class="cb"></div>
            </div>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup" style="margin-top: -36px;">X</div></a>
        </div>
        <div class="popup_form" style="position: relative;">
            <div class="loader_dv" style="position: absolute; top: 7px;left: 385px;width:33px"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>

            <div id="tsksrch" class="col-lg-4 mrt-14 srchmile_spc fr" style="display:none;">
                <input name="data[name]" class="form-control pro_srch" id="tsk_name" maxlength="100" onkeyup="searchMilestoneCase()" placeholder="Title" type="text">                <i class="icon-srch-img chng_icn"></i>
            </div>
            <span id="tskpopupload1" class="mlstn-srh-ldr">Loading tasks... <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..."></span>
            <div class="cb"></div>
            <div id="inner_mlstn_case"></div>

            <div class="add-mlstn-btn" style="display: none;">
                <center>
                    <span id="tskloader" style="display: none;">
                        <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                    </span>
                    <span id="confirmbtntsk" style="display:block;">
                        <button class="btn btn_blue showhidebtn" id="addtsk" value="Add" type="button" onclick="assignCaseToMilestone(this)"><i class="icon-big-tick"></i>Add</button>
                        <button class="btn btn_blue showhidebtn" id="addtskncont" value="Add" type="button" onclick="assignCaseToMilestone(this)"><i class="icon-big-tick"></i>Add &amp; Continue</button>
                        <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                        <span class="or_cancel">
                            or
                            <a onclick="closePopup();">Cancel</a>
                        </span>
                    </span>
                </center>
            </div>
        </div>
    </div>
    <!-- Add cases to Milestone popup end -->

    <!-- Move Task To Milestone popup Start -->
    <div class="movetaskTomlst cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <div class="hdr-cnt">
                <div class="fl">&nbsp;Move task to milestone&nbsp;</div>
                <div class="fl">&nbsp;<img src="./Orangescrum3_files/icon_breadcrumbs.png">&nbsp;</div>
                <div id="mvtask_prj_ttl" class="fnt-nrml fl"></div>
                <div class="cb"></div>
            </div>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup" style="margin-top: -20px;">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv" id="mvtask_loader"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="mvtask_mlst"></div>

        </div>
    </div>
    <!-- Move Task To Milestone popup end -->

    <!-- Remove cases From Milestone popup starts -->
    <div class="mlstn_remove_task cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <div class="hdr-cnt">
                <div class="fl">&nbsp;Remove Tasks&nbsp;</div>
                <div class="fl">&nbsp;<img src="./Orangescrum3_files/icon_breadcrumbs.png">&nbsp;</div>
                <div id="header_prj_ttl_rt" class="fnt-nrml fl"></div>
                <div class="fl">&nbsp;<img src="./Orangescrum3_files/icon_breadcrumbs.png">&nbsp;</div>
                <div id="header_mlstn_ttl_rt" class="fnt-nrml ttc fl"></div>

                <!--		<div class="fl" style="position: relative;">&nbsp;&nbsp;
                                <a href="javascript:void(0);"><span id="switch_mlstn" style="font-size: 12px;text-decoration:underline;" onclick="view_project_milestone();">Switch Milestone</span></a>
                                <ol style="list-style-type: none;">
                                    <li class="dropdown" id="mlstn_drpdwn" style="position: absolute; top: 7px;left: 13px;">
                                                <div class="dropdown-menu lft popup" id="mlstnpopup" style="left: 0px;">
                                            <center>
                                                <div id="loader_mlsmenu" style="display:none;">
                                                    <img src="http://172.16.4.105:8080/orangescrum-master/img/images/del.gif" alt="loading..." title="loading..."/>
                                                </div>
                                            </center>
                                            <div id="ajaxViewMilestonesCP"></div>
                                        </div>
                                    </li>
                                </ol>
                                </div>-->
                <div class="cb"></div>
            </div>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup" style="margin-top: -20px;">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv" id="rmv_case_loader"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>

            <div id="tsksrch" class="col-lg-4 mrt-14 fr" style="display:none;">
                <input name="data[name]" class="form-control pro_srch" id="tsk_name" maxlength="100" onkeyup="searchMilestoneCase()" placeholder="Title" type="text">                <i class="icon-srch-img chng_icn"></i>
            </div>

            <span id="tskpopupload1" class="mlstn-srh-ldr">Loading tasks... <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..."></span>
            <div class="cb"></div>
            <div id="inner_mlstn_removetask"></div>

            <div class="add-mlstn-btn" style="display: none;">
                <center>
                    <span id="tskloader" style="display: none;">
                        <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                    </span>
                    <span id="confirmbtntsk" style="display:block;">
                        <button class="btn btn_blue" id="addtsk" value="Add" type="button" onclick=" return removecaseFromMilestone(this)"><i class="icon-big-tick"></i>Remove</button>
                        <!--<button class="btn btn_blue" id="addtskncont" value="Add" type="button" onclick="assignCaseToMilestone(this)"><i class="icon-big-tick"></i>Add & Continue</button>-->
                        <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                        <span class="or_cancel">or<a onclick="closePopup();">Cancel</a></span>
                    </span>
                </center>
            </div>
        </div>
    </div>
    <!-- Add cases to Milestone popup ends -->

    <!-- Support popup starts -->
        <div class="support_popup cmn_popup" style="display: none;">
        <div class="popup_title">
            <span>
                <i class="icon-support"></i> <span class="support_title">Feedback</span>
            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="cb"></div>
            <div id="inner_support">
                <center><div id="support_err" class="fnt_clr_rd" style="display:block;"></div></center>
                <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab">
                    <tbody><tr>
                        <td class="v-top">Name:</td>
                        <td>
                            <input type="text" name="support_name" id="support_name" class="form-control" value="lakshya.sanadhya ">
                        </td>
                    </tr>
                    <tr>
                        <td class="v-top">Email:</td>
                        <td>
                            <input type="text" name="support_email" id="support_email" readonly="readOnly" class="form-control" value="lakshya.sanadhya@lipi.in">
                        </td>
                    </tr>
                    <tr>
                        <td class="v-top">Message:</td>
                        <td>
                            <textarea name="support_msg" id="support_msg" class="form-control" cols="23" rows="4"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="btn_align">
                            <span id="sprtloader" class="ldr-ad-btn">
                                <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                            </span>
                            <span id="spt_btn">
                                <button class="btn btn_blue" type="button" value="Post" name="addMember" onclick="postSupport();action_ga(&#39;Feedback Post&#39;);"><i class="icon-big-tick"></i>Post</button>
                                <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                                <span class="or_cancel">
                                    or
                                    <a onclick="closePopup();">Cancel</a>
                                </span>
                            </span>
                        </td>
                    </tr>

                    <input type="hidden" name="url_sendding" id="url_sendding">
                </tbody></table>
            </div>
        </div>
    </div>
    <!-- Support popup ends -->



    <!-- Create task popup starts -->

    <!-- Create task popup ends -->    
    <!-- <div id="template_mod_cases" style="position:fixed;left:0;top:0px;width:100%;position: absolute;background: white;" class="inner"></div>-->

    <!-- Task template create popup starts -->
    <div class="task_temp_popup cmn_popup" style="display: none;">
        <div class="popup_title">
            <span>
                <i class="icon-pro-templt"></i> Task Template
            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="cb"></div>
            <div id="inner_task_temp">
                <center><div id="task_temp_err" class="fnt_clr_rd" style="display:block;font-size:15px;"></div></center>
                <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab">
                    <tbody><tr>
                        <td>Title:<span style="color:red">*</span></td>
                        <td>
                            <input type="text" name="tasktemptitle" id="tasktemptitle" class="form-control" value="">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding-left:33px;">Description:<span style="color:red">*</span></td>
                        <td>
                            <textarea class="text_field form-control" id="desc" name="desc"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="btn_align">
                            <span id="tasktemploader" class="ldr-ad-btn">
                                <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                            </span>
                            <span id="task_btn">
                                <button class="btn btn_blue" type="button" onclick="createTaskTemplate(&#39;add&#39;)"><i class="icon-big-tick"></i>Create</button>
                                <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                                <span class="or_cancel"><a class="btn btn-default" onclick="closePopup();">Cancel</a></span>
                            </span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
        </div>
    </div>
    <!-- Task template create popup ends --> 

    <!-- Edit Task Template popup starts -->
    <div class="edt_task_temp cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-edit-projct"></i><span id="header_task_temp"></span></span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv_task"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_task_temp_edit">
                <center><div id="task_temp_err" class="fnt_clr_rd" style="display:block;font-size:15px;"></div></center>
                <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab">
                    <input type="hidden" name="hid_edit_id" id="hid_edit_id" value="">
                    <input type="hidden" name="hid_edit_user_id" id="hid_edit_user_id" value="">
                    <input type="hidden" name="hid_edit_company_id" id="hid_edit_company_id" value="">
                    <input type="hidden" name="hid_edit_page_num" id="hid_edit_page_num" value="">
                    <tbody><tr>
                        <td>Title:</td>
                        <td>
                            <input type="text" name="tasktemptitle_edit" id="tasktemptitle_edit" class="form-control" value="">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding-left:33px;">Description:</td>
                        <td>
                            <textarea class="text_field form-control" id="desc_edit" name="desc_edit"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="btn_align">
                            <span id="tasktemploader_edit" class="ldr-ad-btn">
                                <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                            </span>
                            <span id="task_btn_edit">
                                <button class="btn btn_blue" type="button" onclick="createTaskTemplate(&#39;edit&#39;)"><i class="icon-big-tick"></i>Update</button>
                                <!--<button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>-->
                                <span class="or_cancel"><a class="btn btn-default" onclick="closePopup();">Cancel</a></span>
                            </span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
        </div>
    </div>
    <!-- Edit Task Template popup ends -->

    <!-- project template create popup starts -->
    <div class="project_temp_popup cmn_popup" style="display: none;">
        <div class="popup_title">
            <span>
                <i class="icon-pro-templt"></i> Project Template
            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="cb"></div>
            <div id="inner_project_temp">
                <center><div id="project_temp_err" class="fnt_clr_rd" style="display:block;"></div></center>
                <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab" style="width:100%">
                    <tbody><tr>
                        <td style="width:0px;">Template Name:</td>
                        <td style="width:220px;">
                            <input type="text" name="projtemptitle" id="projtemptitle" class="form-control" value="">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="btn_align">
                            <span id="prjtemploader" class="ldr-ad-btn">
                                <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                            </span>
                            <span id="prj_btn">
                                <button class="btn btn_blue" type="button" onclick="createTemplate()"><i class="icon-big-tick"></i>Create</button>
                                <button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>
                            </span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
        </div>
    </div>
    <!-- project template create popup ends --> 

    <!-- tasks of project template Edit popup starts -->
    <div class="task_project_edit cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-edit-projct"></i><span id="header_task_prj"></span></span>
            <a href="javascript:jsVoid();" onclick="closePopupEdit();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="cb"></div>
            <div class="loader_dv_tsk_prj"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_task_project_edit">
                <center><div id="task_project_err_edit" class="fnt_clr_rd" style="display:block;"></div></center>
                <form name="templatecase" method="post" action="http://172.16.4.105:8080/orangescrum-master/templates/edit_template_task" onsubmit="return validateTaskTemplateEdit()">
                    <input type="hidden" name="template_id" id="temp_id" value="">
                    <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab" style="width:100%;">
                        <tbody><tr>
                            <td align="left" style="width:82%;padding-right:0;">
                                <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab" style="width:100%;margin-left:5px;">
                                    <tbody><tr>
                                        <td>Task Title:</td>
                                        <td style="padding-right:0px;">
                                            <input type="text" name="title_edit" id="title_edit" class="form-control" value="" style="width:415px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">Description:</td>
                                        <td style="padding-right:0px;">
                                            <textarea name="description_edit" id="description_edit" class="form-control" style="width:415px"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td class="btn_align">
                                            <span id="prjtemploader_task_prj" style="display:none;">
                                                <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                                            </span>
                                            <span id="prj_btn_task_edit">
                                                <button class="btn btn_blue" name="submit_template_edit" value="1" type="submit"><i class="icon-big-tick"></i>Update</button>
                                                <button class="btn btn_grey" type="button" onclick="closePopupEdit();"><i class="icon-big-cross"></i>Cancel</button>
                                            </span>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                    </tbody></table>
                </form>	
            </div>
        </div>
    </div>
    <!-- tasks of project template Edit popup ends --> 

    <!-- project template Edit popup starts -->
    <div class="project_temp_popup_edit cmn_popup" style="display: none;">
        <div class="popup_title">
            <span><i class="icon-edit-projct"></i><span id="header_prj_task_temp"></span></span>
            <!--<span>
                    <i class="icon-pro-templt"></i> Project Template
            </span>-->
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="cb"></div>
            <div class="loader_dv_prj"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div id="inner_project_temp_edit">
                <center><div id="project_temp_err_edit" class="fnt_clr_rd" style="display:block;"></div></center>
                <table cellpadding="0" cellspacing="0" class="col-lg-12 new_auto_tab" style="width:100%">
                    <tbody><tr>
                        <td style="width:0px;">Template Name:</td>
                        <td style="width:220px;">
                            <input type="text" name="projtemptitle_edit" id="projtemptitle_edit" class="form-control" value="">
                            <input type="hidden" name="hid_orig_projtemptitle_edit" id="hid_orig_projtemptitle_edit" class="form-control" value="">
                            <input type="hidden" name="hid_temptitle_id" id="hid_temptitle_id" class="form-control" value="">
                            <input type="hidden" name="hid_page_num" id="hid_page_num" class="form-control" value="">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="btn_align">
                            <span id="prjtemploader_edit" style="display:none;">
                                <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                            </span>
                            <span id="prj_btn_edit">
                                <button class="btn btn_blue" type="button" onclick="save_edit_template()"><i class="icon-big-tick"></i>Update</button>
                                <button class="btn btn_grey" type="button" onclick="closePopup();"><i class="icon-big-cross"></i>Cancel</button>
                            </span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
        </div>
    </div>
    <!-- project template Edit popup ends --> 

    <!-- Add tasks to Project popup starts -->
    <div class="add_to_project cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <span class="hdr-cnt add_prod_temp_name">

            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div class="cb"></div>
            <div id="inner_tmp_add"></div>

            <div class="add-tmp-btn" style="display: none;">
                <span id="userloader" class="ldr-ad-btn">
                    <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                </span>

            </div>
        </div>
    </div>
    <!-- Add tasks to Project popup ends -->

    <!-- Create task to template popup starts -->
    <div class="add_task_to_temp cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <span class="hdr-cnt add_task_temp_name">

            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div class="cb"></div>
            <center><div id="task_to_temp_err" class="fnt_clr_rd" style="display:block;"></div></center>
            <div id="inner_task_add"></div>

            <div class="add-task-btn" style="display: none;">
                <span id="userloader" class="ldr-ad-btn">
                    <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                </span>

            </div>
        </div>
    </div>
    <!-- Create task to template popup ends -->

    <!-- Remove tasks from Template popup starts -->
    <div class="remove_from_task cmn_popup" style="display: none;">
        <div class="popup_title pad-10">
            <span class="hdr-cnt proj_temp_name">

            </span>
            <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
        </div>
        <div class="popup_form">
            <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <div class="cb"></div>
            <div id="inner_tasks"></div>

            <div class="add-remove-btn" style="display: none;">
                <span id="removetaskloader" class="ldr-ad-btn">
                    <img src="./Orangescrum3_files/case_loader2.gif" alt="loading..." title="loading..."> 
                </span>

            </div>
        </div>
    </div>
    <!-- Remove tasks from Template popup ends --> 

            <!-- Tweet popup starts -->
        <div class="tweet_popup cmn_popup" style="display: none;">
            <div class="popup_title">
                <span><i class="icon-tweet"></i> Tweet about us!</span>
                <a href="javascript:jsVoid();" onclick="closePopup();"><div class="fr close_popup">X</div></a>
            </div>
            <div class="popup_form">
                <div class="loader_dv"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
                <div class="help-text"> 
                    <center>Tweet about  your favourite project management tool and help us grow.</center>
                </div>
                <div class="hlpe_popbtn">
                    <a href="https://twitter.com/intent/tweet?url=http%3A%2F%2F172.16.4.105%3A8080%2Forangescrum-master%2F&amp;text=%23Orangescrum+is+a+Awesome+project+management+tool+for+You+%26+Your+Team+%40TheOrangescrum&amp;related=TheOrangescrum" target="_blank">
                        <button class="btn btn_blue" type="button" onclick="trackEventGoogle(&#39;Tweet and share&#39;, &#39;Tweet and share&#39;, &#39;Clicked For Tweet - Let me tweet&#39;);">
                                <!--<i class="icon-tweet"></i>-->
                            Let me tweet!
                        </button>
                    </a>
                    <button class="btn btn_grey" type="button" onclick="closePopup();trackEventGoogle(&#39;Tweet and share&#39;, &#39;Tweet and share&#39;, &#39;Clicked For Tweet - No thanks&#39;);"><i class="icon-big-cross"></i>No thanks</button>
                </div>
            </div>
        </div>
        <!-- Tweet popup ends -->
    </div>

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
            <div class="loader_dv_edit" style="display: none;"><center><img src="./Orangescrum3_files/case_loader2.gif" alt="Loading..." title="Loading..."></center></div>
            <table class="create_table" style="width:75%">
                <tbody><tr>
                    <td>
                        <input type="hidden" name="data[Easycase][istype]" id="CS_istype" value="1" readonly="true">
                        <div class="fl lbl-m-wid">Project:</div>
                        <div class="col-lg-9 createtask fl rht-con">
                            <div style="font-weight: bold;" id="edit_project_div" class="ttc"></div>
                            <div id="create_project_div">
                                                                                                <input type="hidden" readonly="readonly" value="4bd2520594153ca4072ffb7d3855b04c" id="curr_active_project">
                                                                    <div class="popup_link link_as_drp_dwn swtchproj fl" id="ctask_popup">
                                        <a href="javascript:void(0);" data-toggle="dropdown" class="option-toggle" onclick="show_prjlist(event);">
                                            <span id="projUpdateTop" class="ttc">a1</span>
                                            <i class="caret"></i>
                                        </a>
                                    </div>
                                    <div id="prjchange_loader" style="display:none;margin-left: 15px;margin-top: -2px;" class="fl">
                                        <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading...">
                                    </div>
                                    <div class="cb"></div>
                                    <div id="openpopup" class="popup dropdown-menu lft popup ctaskproj ttc">
                                        <div class="popup_con_menu" align="left">
                                                                                        <div align="left" id="ajaxaftersrchc" style="display: none;"></div>
                                            <div align="left" id="ajaxbeforesrchc">
                                                                                                    <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;a1&#39;, &#39;4bd2520594153ca4072ffb7d3855b04c&#39;)">a1</a>
                                                    <hr class="pro_div">
                                                                                                    <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;P1&#39;, &#39;2bdf6c2dc8ff565e70186f9996d5ecd6&#39;)">P1</a>
                                                    <hr class="pro_div">
                                                                                                    <a href="javascript:void(0);" class="proj_lnks" onclick="showProjectName(&#39;Digital%20Signage&#39;, &#39;062abdf226e93a198b2e0cfbd6ae3027&#39;)">Digital Signage</a>
                                                    <hr class="pro_div">
                                                                                            </div>
                                        </div>
                                    </div>
                                                                <div id="projAllmsg" style="display:none;color:#C0504D;font-size:14px;  padding-top:10px;">Oops! No project selected.</div>
                            </div>
                        </div>
                    </td>
                </tr>		
                <tr>
                    <td colspan="2">
                        <div class="fl lbl-m-wid" style="padding-top:16px">Title:</div>
                        <div class="col-lg-9 fl rht-con">
                            <input class="form-control" type="text" placeholder="Add a task here &amp; hit enter...." id="CS_title" maxlength="240" onblur="blur_txt();checkAllProj();" onfocus="focus_txt()" onkeydown="return onEnterPostCase(event)" onkeyup="checktitle_value();" style="font-size:15px;">
                            <div id="err_case_title" class="err_msg"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="case_field">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                    <td>
                                        <table cellpadding="0" cellspacing="0">
                                            <tbody><tr>
                                                <td class="case_fieldprof">
                                                    <div class="fl lbl-m-wid">Assign To:</div>
                                                </td>
                                                <td align="left">
                                                    <div id="sample1" class="dropdown option-toggle p-6">
                                                        <div class="opt1" id="opt5">
                                                            <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt5&#39;);">
                                                                <span id="tsk_asgn_to">

                                                                </span>
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
                                        </tbody></table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        

                                        <div class="fl lbl-m-wid" style="padding-top:17px">Due Date:</div>
                                        <div class="col-lg-9 fl rht-con">	
                                            <div class="fl dropdown option-toggle p-6">
                                                <div class="opt1" id="opt3"><a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt3&#39;);"> 
                                                        <span id="date_dd">	
                                                                                                                            No Due Date
                                                                                                                    </span>
                                                        <i class="caret mtop-10 fr"></i></a></div>


                                                <div class="more_opt" id="more_opt3">
                                                    <ul>
                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;No Due Date<span class="value">No Due Date</span></a></li>
                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;Today<span class="value">Sep 7, Mon</span> </a></li> 	
                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;Next Monday <span class="value">Sep 14, Mon</span></a></li> 
                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;Tomorrow<span class="value">Sep 8, Tue</span></a></li>
                                                        <li><a href="javascript:jsVoid()">&nbsp;&nbsp;This Friday<span class="value">Sep 11, Fri</span></a></li> 
                                                        <li style="color:#808080; padding-left:10px;">
                                                            <input type="hidden" id="due_date" title="Custom Date" style="min-width:30px;">&nbsp;<span style="position:relative;">Custom Date</span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="task_priority_td" colspan="2" style="padding:6px 0 5px 0;">
                                        <table cellpadding="0" cellspacing="0">
                                            <tbody><tr>
                                                <td class="case_fieldprof">
                                                    <span id="hd1">
                                                        <div class="fl lbl-m-wid">Priority:</div>
                                                    </span>
                                                </td>
                                                <td align="left">
                                                    <div class="fl prio_radio y_low" onclick="check_priority(this);"><input type="radio" name="task_priority" value="2" id="priority_low" class="pri-checkbox"><label tabindex="4" class="pri-label"></label></div>
                                                    <div class="fl pri_type">Low</div>
                                                    <div class="fl prio_radio g_mid" onclick="check_priority(this);"><input type="radio" name="task_priority" value="1" id="priority_mid" class="pri-checkbox" checked="checked"><label tabindex="4" class="pri-label"></label></div>
                                                    <div class="fl pri_type">Medium</div>
                                                    <div class="fl prio_radio h_red" onclick="check_priority(this);"><input type="radio" name="task_priority" value="0" id="priority_high" class="pri-checkbox"><label tabindex="4" class="pri-label"></label></div>
                                                    <div class="fl pri_type">High</div>
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                            </tbody></table>
                        </div>
                        <div id="new_case_more_div" style="display:none;"><style>
                                                                              #holder {
                                                                                  border: 4px dashed #F8F81E;
                                                                                  padding: 8px;
                                                                                  height: 85px;
                                                                                  background: #F0F0F0;
                                                                              }

                                                                                  #holder.hover {
                                                                                      border: 4px dashed #0c0;
                                                                                  }
                                                                          </style>
<input type="hidden" name="totfiles" id="totfiles" value="0" readonly="true">
<input type="hidden" id="is_default_task_type" value="1" readonly="true">
<input type="hidden" id="CS_type_id" value="2 ">
<input type="hidden" id="CS_priority" value="1 ">
<input type="hidden" id="CS_due_date" value="No Due Date">
<input type="hidden" id="CS_milestone" value="">

<div class="head_back"></div>
<div id="cover" class="outer"></div>
<div id="pagefade" class="pagefade" style="z-index:0"></div>
<div>

    <div class="case_field w-736">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody><tr>
                <td>
                    <table cellpadding="0" cellspacing="0">
                        <tbody><tr>
                            <td class="case_fieldprof">
                                <div class="fl lbl-m-wid">Task Type:</div>
                            </td>
                            <td align="left">
                                <div id="sample" class="dropdown option-toggle p-6 fl">
                                    <div class="opt1" id="opt1">
                                        <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt&#39;);">
                                            <span id="ctsk_type">
                                                                                                        <img class="flag" src="./Orangescrum3_files/dev.png" alt="type" style="padding-top:3px;">&nbsp;Development
                                                                                                                                        </span> 
                                            <i class="caret mtop-10 fr"></i>
                                        </a>
                                    </div>
                                    <div class="more_opt" id="more_opt">
                                        <ul>
                                            <li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/dev.png" '="" alt="">
																		<span class="value">2
																		</span>Development
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/bug.png" '="" alt="">
																		<span class="value">1
																		</span>Bug
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/upd.png" '="" alt="">
																		<span class="value">10
																		</span>Update
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/cr.png" '="" alt="">
																		<span class="value">12
																		</span>Change Request
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/idea.png" '="" alt="">
																		<span class="value">11
																		</span>Idea
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/enh.png" '="" alt="">
																		<span class="value">3
																		</span>Enhancement
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/rnd.png" '="" alt="">
																		<span class="value">4
																		</span>Research n Do
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/mnt.png" '="" alt="">
																		<span class="value">7
																		</span>Maintenance
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/qa.png" '="" alt="">
																		<span class="value">5
																		</span>Quality Assurance
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/unt.png" '="" alt="">
																		<span class="value">6
																		</span>Unit Testing
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/rel.png" '="" alt="">
																		<span class="value">9
																		</span>Release
																	</a>
																</li><li>
																	<a href="javascript:jsVoid()">
																		<img class="flag" src="./Orangescrum3_files/oth.png" '="" alt="">
																		<span class="value">8
																		</span>Others
																	</a>
																</li>                                        </ul>
                                    </div>
                                </div>
                                                                            <span style="position:relative;top:4px;"><a href="http://172.16.4.105:8080/orangescrum-master/task-type" style="color:#06C;text-decoration:underline;font-size:12px;padding-left:5px;">Add New</a></span>
                                                                        </td>
                        </tr>
                    </tbody></table>
                </td>
                <td align="right" id="milestone_td">
                    <div class="fl lbl-m-wid" style="padding-top:17px">Milestone:</div>
                    <div class="col-lg-9 createtask fr rht-con">	
                        <div class="fl dropdown option-toggle p-6" style="margin-left: 14px;text-align:left">
                            <div class="opt1" id="opt8">
                                <a href="javascript:jsVoid()" onclick="open_more_opt(&#39;more_opt8&#39;);">
                                    <span id="selected_milestone">
                                                            No milestone
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
        </tbody></table>
    </div>
    <div class="case_field">
        <span>
            <div class="fl lbl-m-wid">Description:</div>
            <div id="divNewCase" class="col-lg-9 createtask fl rht-con">
                <textarea name="data[Easycase][message]" id="CS_message" onfocus="openEditor()" rows="2" style="resize:none" class="form-control" placeholder="Enter Description..."></textarea>
            </div>
            <div id="divNewCaseLoader" style="display:none;padding:20px ;text-align: center;color:#999999;">
                Loading...
            </div>
        </span>
    </div>
    <div class="cb"></div>
    <div class="case_field w-736">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody><tr>
                <td align="left">
                    <table cellpadding="0" cellspacing="0">
                        <tbody><tr>
                            <td class="case_fieldprof">
                                <div class="fl lbl-m-wid">Estimated Hour(s):</div>
                            </td>
                            <td>
                                <div class="col-lg-9 createtask fl rht-con">
                                    <a rel="tooltip" href="javascript:;" original-title="You can enter time as 1.5  (that  mean 1 hour and 30 minutes).">
                                        <input type="text" onkeypress="return numericDecimal(event)" id="estimated_hours" name="data[Easycase][estimated_hours]" maxlength="6" class="form-control" style="width:80px;" value="">
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </tbody></table>
                </td>







                <td align="right">
                    <table cellpadding="0" cellspacing="0">
                        <tbody><tr>
                            <td class="case_fieldprof">
                                <div class="fl lbl-m-wid">Hour(s) Spent:</div>			
                            </td>
                            <td>
                                <div id="sample" class="col-lg-9 createtask fl rht-con">
                                    <a rel="tooltip" href="javascript:;" original-title="You can enter time as 1.5  (that  mean 1 hour and 30 minutes).">
                                        <input type="text" onkeypress="return numericDecimal(event)" id="hours" name="data[Easycase][hours]" maxlength="6" class="form-control" style="width:80px;" value="">
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
        </tbody></table>
    </div>
    <div class="clear"></div>
    <div class="case_field">
        <table border="0" cellpadding="0" cellspacing="0" style="padding-left:2px;" id="table1">
            <tbody><tr>
                <td class="case_fieldprof" valign="top">
                    <div class="fl lbl-m-wid">Attachment(s):</div>
                </td>
                <td align="left">
                    <table cellpadding="0" cellspacing="0" style="width:100%">
                        <tbody><tr>
                            <td>
                                <form id="file_upload" action="http://172.16.4.105:8080/orangescrum-master/easycases/fileupload/" method="POST" enctype="multipart/form-data" class="file_upload">
                                    <div class="fl" style="margin:10px 0;">
                                        <div id="holder" style="">
                                            <div class="customfile-button" style="right:0">
                                                <input class="customfile-input fl" name="data[Easycase][case_files]" type="file" multiple="" style="width:233px;height:74px;">
                                                <input name="data[Easycase][usedstorage]" type="hidden" id="usedstorage" value="">
                                                <input name="data[Easycase][allowusage]" type="hidden" id="allowusage" value="Unlimited">
                                                <div class="att_fl fl" style="margin-right:5px"></div><div class="fr">Select multiple files to upload...</div>
                                            </div>
                                            <div style="margin-left:4px;color:#F48B02;font-size:13px;" class="fnt999">Drag and Drop files to Upload</div>
                                            <div style="margin-left:6px" class="fnt999">Max size 200 Mb</div>
                                        </div>									
                                    </div>
                                    <div class="cb"></div>
                                </form>     
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="up_files" style="font-weight:normal;width: 100%;"></table>
                            </td>	
                        </tr>
                    </tbody></table>
                </td>
            </tr>
            <tr id="drive_tr_0" style="display: none;">
                <td>&nbsp;</td>
                <td>
                    <form id="cloud_storage_form_0" name="cloud_storage_form_0" action="javascript:void(0)" method="POST">
                        <div style="float: left;margin-top: 7px;" id="cloud_storage_files_0"></div>
                    </form>
                    <div style="clear: both;margin-bottom: 3px;"></div>
                </td>
            </tr>
        </tbody></table>
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
                        <div class="col-lg-9 fl rht-con rht_bg" style="padding-left:4px; padding-bottom:0">
                            <div class="fr mor_toggle tasktoogle" id="more_tsk_opt_div" style="position: relative;float:left"><a href="javascript:jsVoid();" onclick="opencase(&#39;click&#39;);" style="text-decoration:none"><img src="./Orangescrum3_files/description.png" title="Description" rel="tooltip">&nbsp;&nbsp;<img src="./Orangescrum3_files/hours.png" title="Estimated Hours and Hours Spent" rel="tooltip">&nbsp;&nbsp;<img src="./Orangescrum3_files/attachment.png" title="Attachments, Google Drive, Dropbox" rel="tooltip">&nbsp;&nbsp;+ More</a></div>

                            <div class="fr less_toggle tasktoogle" id="less_tsk_opt_div" style="display:none;position: relative;float:left"><a href="javascript:jsVoid();" onclick="closecase();" style="text-decoration:none">- Less</a></div>

                            <div style="position:relative;width:20px;" class="fl">
                                <img src="./Orangescrum3_files/del.gif" title="Loading..." alt="Loading..." id="loadquick" style="display:none;">
                            </div>
                        </div>

                    </td>
                </tr>
            </tbody></table>
            <div class="cb"></div>
            <input type="hidden" value="" name="easycase_uid" id="easycase_uid" readonly="readonly">
            <input type="hidden" value="" name="easycase_id" id="CSeasycaseid" readonly="readonly">
            <input type="hidden" value="" name="editRemovedFile" id="editRemovedFile" readonly="readonly">
            <div class="col-lg-12 task_slide_in btm_block">
                <div style="float:right;width:255px;">
                    <input type="hidden" name="hid_http_images" id="hid_http_images" value="http://172.16.4.105:8080/orangescrum-master/img/" readonly="true">
                    <span id="quickcase" style="display:block;" class="nwa">
                        <button class="btn btn_blue" type="submit" onclick="return submitAddNewCase(&#39;Post&#39;, 0, &#39;&#39;, &#39;&#39;, &#39;&#39;, 1, &#39;&#39;);"><i class="icon-big-tick"></i><span id="ctask_btn">Create</span></button>
                                        <!--<button class="btn btn_grey" type="reset" id="rset" onclick="crt_popup_close();"><i class="icon-big-cross"></i>Cancel</button>-->
                        <span class="or_cancel">
                            <a id="rset" class="btn btn-default" onclick="crt_popup_close();">Cancel</a>
                        </span>
                    </span>
                    <span id="quickloading" style="display:none;padding-left:10px;padding-top:5px;">
                        <img src="./Orangescrum3_files/case_loader2.gif" title="Loading..." alt="Loading...">
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
		<button class="btn gry_btn task_detail_back" type="button" style="margin-left:18px;">
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
	</div><!-- Case Detail buttons -->
</div>
<div class="task_action_bar_div milestonekb_detail_head">
	<div class="task_action_bar">
		<button class="btn gry_btn task_detail_back" type="button" style="margin-left:18px;">
		<i class="icon-backto"></i>
		</button>
	</div><!-- Case Detail buttons -->
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(".all-addon-list > a").click(function () {
            $(".all-addon-list > ul").toggle(500);
            $(this).toggleClass('open-addon');
        });
    });


</script>
    
    <div class="slide_rht_con">
        <input type="hidden" id="role" value="disable">
        <input type="hidden" id="type" value="">
        <input type="hidden" id="user_srch" value="">
        <div class="proj_grids">
            <div class="tab tab_comon tab_task">
                <ul class="nav-tabs mod_wide">
                    <li id="task_li">
                        <%-- <a href="javascript:void(0);" onclick="filterUserRole(&#39;all&#39;,&#39;&#39;);">--%>
                        <a href="UserOrange.aspx" onclick="filterUserRole(&#39;all&#39;,&#39;&#39;);">
                            <div class="usrr_actv fl"></div>
                            <div class="fl">Active<span class="counter">(4)</span></div>
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
                    <li id="task_li" class="active">
                        <a href="javascript:void(0);" onclick="filterUserRole(&#39;disable&#39;,&#39;&#39;);">
                            <div class="usrr_disbl fl"></div>
                            <div class="fl">Disabled<span class="counter">(1)</span></div>
                            <div class="cbt"></div>
                        </a>
                    </li>
                    <div class="cbt"></div>
                </ul>
            </div>


            <div class="col-lg-12 user_div m-left-20">

                <div class="col-lg-4">
                    <div class="col-lg-12 contain new_prjct user_inv text-centre">
                        <a href="javascript:void(0);" onclick="newUser()" style="display: block !important; padding: 55px;">
                            <div class="icon-projct-gridvw"></div>
                            Add Users
			</a>
                    </div>
                </div>

                <div class="col-lg-4 proj_mng_div">
                    <div class="col-lg-12 contain usr_mng_div" style="position: relative;">
                        <div class="usr_block">
                            <div class="label user-usr fl" style="padding: 3px; text-align: center !important; width: 96px;">User</div>
                            <div class="fl mgl14">
                                <div class="nm">Invite</div>
                                <div class="usr_email" title="champakchacha.cc@gmail.com">
                                     
                                </div>
                            </div>
                            <div class="cbt"></div>
                        </div>
                        <div class="user-details">
                            <div class="fl usr_lt">
                                <div class="user-image">
                                    <img class="lazy" data-original="http://172.16.4.105:8080/orangescrum-master/users/image_thumb/?type=photos&amp;file=user.png&amp;sizex=94&amp;sizey=94&amp;quality=100" width="94" height="94" src="./Orangescrum3_files/saved_resource(1)" style="display: inline;">
                                </div>
                                <div class="user-nm"></div>
                            </div>
                            <div class="fl usr_rt">
                                <div class="border_usr usr_email">Last Activity:</div>

                                <div class="usr_email"></div>
                                <div class="border_usr usr_email">Created: </div>
                                <div class="usr_email">Sep 03, Thu 2:14 pm</div>
                            </div>
                            <div class="cbt"></div>
                        </div>
                        <div class="nm_prj" id="remain_prj_2">Projects: <span class="fnt13 fnt_clr_gry">N/A</span></div>
                        <div class="proj_mng">
                            <div class="fl">

                                <!--<a class="" href="javascript:void(0);"    style="color:#fff;"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>-->
                            </div>
                            <div class="fl">
                                <a class="icon-enable-usr fl" href="http://172.16.4.105:8080/orangescrum-master/users/manage/?act=f9b34f3fa5b5d01c7ecb20ef5eb28dc4&amp;role=disable" onclick="return confirm(&#39;Are you sure you want to enable \&#39;Invite\&#39; ?&#39;)">Enable</a>
                            </div>
                            <div class="fr">
                                <input id="rmv_allprj_2" type="hidden" value="">
                                <a id="rmv_prj_2" class="icon-remprj-usr" href="javascript:void(0);" data-usr-id="2" data-usr-name="Invite" data-total-project="0" style="display: none;">Remove Project</a>
                            </div>

                        </div>
                    </div>
                </div>
                <input type="hidden" id="is_invited_user" value="0">
            </div>

            <div class="cbt"></div>
            <input type="hidden" id="getcasecount" value="1" readonly="true">
            <div class="tot-cs fr">
                <div class="sh-tot-cs">
                    1 - 1 of 1   
                </div>
                <div class="pg-ntn">
                    <ul class="pagination">
                    </ul>
                </div>
            </div>
            <input type="hidden" id="totalcount" name="totalcount" value="2">
        </div>
        <div id="projectLoader">
            <div class="loadingdata">Sending invitation again...</div>
        </div>


        <script>
            function edit_user(id) {
                newUser();
                $("#add_user_btn").hide();
                $("#update_user_btn").show();
                $.post(HTTP_ROOT + "users/edit_user", {
                    "u_id": id
                }, function (data) {
                    if (data) {
                        $('#username').val(data.name);
                        $('#user_u_id').val(data.id);
                        $('#txt_email').val(data.email);
                        $('#password').val('*******');
                        $("#user_id").val(data.id);
                        $('#useremail').attr('readonly', true);
                        $('#select_project').attr('disabled', true);
                        $('#sel_custprj').attr('disabled', true);

                        $('#add_edit_span').html('Edit User');

                    }
                }, 'json');


            }



</script>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".all-addon-list > a").click(function () {
                $(".all-addon-list > ul").toggle(500);
                $(this).toggleClass('open-addon');
            });
        });


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

    <script type="text/javascript" src="Project_files/os_core.js.download"></script>
    
    <script src="js/os_core.js"></script>
    <!--<script type="text/javascript" src="http://172.16.4.105:8080/orangescrum-master/js/jquery-ui.min.1.8.10.js"></script>-->
    <script type="text/javascript" src="Project_files/jquery-ui-1.9.2.custom.min.js.download"></script>
    <script src="js/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="Project_files/script.js.download"></script>
    <script src="js/script.js"></script>
    <script type="text/javascript" src="Project_files/easycase_new.js.download"></script>
    <script src="js/easycase_new.js"></script>
    <script type="text/javascript" src="Project_files/jquery.tipsy.js.download"></script>
    <script src="js/jquery.tipsy.js"></script>
    <script type="text/javascript" src="Project_files/jquery.lazyload.min.js.download"></script>
    <script src="js/jquery.lazyload.min.js"></script>
    <script type="text/javascript" src="Project_files/jquery.tinymce.js.download"></script>
    <script src="js/jquery.tinymce.js"></script>
    <script type="text/javascript" src="Project_files/tiny_mce.js.download"></script>
    <script src="js/tiny_mce.js"></script>

    <!-- Dropbox starts-->
    <script type="text/javascript" src="Project_files/dropins.js.download" id="dropboxjs" data-app-key="xXxxXxxxXx"></script>
    <script src="js/dropins.js"></script>
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



    <script type="text/javascript">
        var project = 'all';
        $.post(HTTP_ROOT + "easycases/ajax_project_size", { "projUniq": project, "pageload": 0 }, function (data) {
            if (data) {
                $('#csTotalHours').html(data.used_text);
                if (data.last_activity) {
                    $('#projectaccess').html(data.last_activity);
                    $('#last_project_id').val(data.lastactivity_proj_id);
                    $('#last_project_uniqid').val(data.lastactivity_proj_uid);
                    var url = document.URL.trim();
                    if (isNaN(url.substr(url.lastIndexOf('/') + 1)) && (url.substr(url.lastIndexOf('/') + 1)).length != 32) {
                        $('#selproject').val($('#last_project_id').val());
                        $('#project_id').val($('#last_project_id').val());
                    }
                }
            }
        }, 'json');
        $(function () {
            checkuserlogin();
        });
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
</script>


    <script type="text/javascript" src="Project_files/jquery.fileupload.js.download"></script>
    <script src="js/jquery.fileupload.js"></script>
    <script type="text/javascript" src="Project_files/jquery.fileupload-ui.js.download"></script>
    <script src="js/jquery.fileupload-ui.js"></script>

    <!-- For multi autocomplete and tagging -->
    <script type="text/javascript" src="Project_files/jquery.fcbkcomplete.js.download"></script>
    <script src="js/jquery.fcbkcomplete.js"></script>

    <script type="text/javascript" src="Project_files/wiki.js.download"></script>
    <script src="js/wiki.js"></script>
    <script type="text/javascript" src="Project_files/jquery.textarea-expander.js.download"></script>
    <script src="js/jquery.textarea-expander.js"></script>
    <script type="text/javascript" src="Project_files/highcharts.js.download"></script>
    <script src="js/highcharts.js"></script>
    <script type="text/javascript" src=""></script>
    <script src="js/exporting.js"></script>
    <style>
        #holder_detl {
            border: 4px dashed #F8F81E;
            padding: 8px;
            height: 85px;
            background: #F0F0F0;
        }

            #holder_detl.hover {
                border: 4px dashed #0c0;
            }
    </style>
    <script type="text/javascript" src="Project_files/pace.min.js.download"></script>
    <script>
        paceOptions = {
            elements: true
        };
        $(document).ajaxStart(function () {
            Pace.restart();
        });
        $(document).ajaxStop(function () {
            Pace.stop();
        });
    </script>

</asp:Content>
