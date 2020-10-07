



$(document).ready(function () {




    var taskname = "";
    var taskStatus = "";
    var isStarted = false;
    var pid = $(".select-css").children("option:selected").val();

   

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
            $.ajax({
                type: "POST",
                url: "CreateTask.aspx/getTaskName", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{id:'" + pid + "'}",
                dataType: "json",
                success: function (data) {
                    $(".card .card-header .taskname").text(data.d);
                },
                failure: function (error) {
                    alert(error);
                }
            });
    }

    function extractFilename(fullPath) {
        if (fullPath) {
            var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
            var filename = fullPath.substring(startIndex);
            if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                filename = filename.substring(1);
            }
            return filename;
        }
    }

   

   
    $(document).ready(function () {

        $(document).on('click', '.fntlink', function () {  // Attachment link click

            var filename = $(this).find('.lnkattachment').children("span").text();
            var pname = $(".select-css").children("option:selected").text();

            if (!filename.toLocaleLowerCase().includes('n/a'))
                if (!isAjaxRunning) {
                    var downloadConf = confirm('Do you want to download ' + "'" + filename.toLocaleUpperCase() + "'" + ' ?');
                debugger;
                if (downloadConf) {
                    $.ajax({
                        type: "POST",
                        url: "CreateTask.aspx/downloadAttachment", //It calls our web method  
                        contentType: "application/json; charset=utf-8",
                        data: "{filename_pname:'" + filename + "#" + pname + "'}",
                        dataType: "json",
                        success: function (data) {
                            //var a = document.createElement("a"); //Create <a>
                            //a.href = "data:application/pdf;base64," + data.d; //Image Base64 Goes here
                            //a.download = filename; //File name Here
                            //a.click(); //Downloaded file

                            document.getElementById('mainContent_savebtn').click();

                        },
                        failure: function (error) {
                            alert(error);
                        }
                    });
                }
            } else {
                return;
            }

        });

        $(".create .createspan").text("Create Task");
        var toOpenCTModal = localStorage.getItem("openCreateTaskModal");
        if (toOpenCTModal == "true") {

            $('#mainContent_txtDescription').val('');
            $('#mainContent_txtDueDate').val('');
            $('#mainContent_ddlTaskType').val('Select ');
            $('#mainContent_attachmentfile').val('');

            debugger;
            var pid = $(".select-css").children("option:selected").val();  //ProjectID
            getTaskName(pid);
            loadProjectTeam(pid);

            $(".task_section ").hide("slide", { direction: "right" }, 0, function () {
                $(".card").show("slide", { direction: "left" }, 0);
                localStorage.setItem("openCreateTaskModal", "false");
            });

        }

    });
    $(".btnclose").click(function () {
        var pid = $(".select-css").children("option:selected").val();
        loadMyTask(pid);
        loadTasks();
    });

    //$(document).ajaxStart(function () {
    //    isAjaxRunning = true;
    //    $("#wait").css("display", "block").css("z-index", "1");
    //});
    //$(document).ajaxComplete(function () {
    //    isAjaxRunning = false;
    //    $("#wait").css("display", "none");
    //});

    if ($("#userrole").val().includes("admin")) {
        loadTasks();
        loadMyTask(pid);
        $(".firstt").css("display", "table");
        $(".secondt").css("display", "none");
    } else {
        // var pid = $(".select-css").children("option:selected").val();
        loadMyTask(pid);
        $(".firstt").css("display", "none");
        $(".secondt").css("display", "table");
        $("#firstli").css("display", "none");
    }

    $("#finalsubmission").click(function () {  //Final submission of task

        var conf = confirm("Do you want to do final submission?");  //Confirming for final submission

        if (conf) {
            var fileBase64 = "";
            var input = document.getElementById("finalDocument");

            let file = input.files[0];
            var pid = $(".select-css").children("option:selected").val();
            debugger;
            var expences = $("#expenceMoney").val();
            var expenceDesc = $("#expenceDescrption").val();
            var expenseType = $("#select_expenseType").children("option:selected").val();
            if (expences.length > 0) {
                if (expenceDesc.length < 1) {
                    alert('Please add description text..');
                    return;
                }
            }

            if (file != null) {  //if file exists then reading file in base64
                var filename = extractFilename(input.value);
                const reader = new FileReader(); //JS file reader
                reader.readAsDataURL(file);


                reader.onload = function () {
                    fileBase64 = reader.result;
                    fileBase64 = fileBase64.substring(fileBase64.indexOf(",") + 1);

                    $.ajax({
                        type: "POST",
                        url: "CreateTask.aspx/dailySubmission", //It calls our web method  
                        contentType: "application/json; charset=utf-8",
                        data: "{taskname_pid:'" + taskname + "#" + pid + "#finalsubmission#" + fileBase64 + "#" + filename + "#" + expences + "#" + expenceDesc + "#" + expenseType + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.includes("true")) {

                                $("#expenceDescrption").val("");
                                $("#expenceMoney").val("");
                                $("#togglediv").removeClass("in");

                                $("#startTask").css("display", "inline");
                                $('.timerlabel').text("Stopped!");
                                alert("Task Complete");
                                $("#modalPoll-1").modal("hide");
                                
                                loadMyTask(pid);
                                loadTasks();
                            } else {                               
                                alert("Final submission failed!");
                            }
                        },
                        failure: function (error) {
                            alert(error);
                        }
                    });
                };
                reader.onerror = function (error) {
                    console.log('Error: ', error);
                };
            } else {  //when final submission without file uploading   

                $.ajax({
                    type: "POST",
                    url: "CreateTask.aspx/dailySubmission", //It calls our web method  
                    contentType: "application/json; charset=utf-8",
                    data: "{taskname_pid:'" + taskname + "#" + pid + "#finalsubmission#" + " #" + "" + "#" + expences + "#" + expenceDesc + "#" + expenseType + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.includes("true")) {

                            $("#expenceDescrption").val("");
                            $("#expenceMoney").val("");
                            $("#togglediv").removeClass("in");

                            $("#startTask").css("display", "inline");
                            $('.timerlabel').text("Stopped!");
                            alert("Task Complete");
                            $("#modalPoll-1").modal("hide");
                            loadMyTask(pid);
                            loadTasks();
                        } else {
                            alert("Final submission failed!");

                        }
                    },
                    failure: function (error) {
                        alert(error);
                    }
                });
            }
        }


    });

    $("#dailysubmission").click(function () {
        var pid = $(".select-css").children("option:selected").val();

        $.ajax({
            type: "POST",
            url: "CreateTask.aspx/dailySubmission", //It calls our web method  
            contentType: "application/json; charset=utf-8",
            data: "{taskname_pid:'" + taskname + "#" + pid + "#dailysubmission" + "'}",
            dataType: "json",
            success: function (data) {
                var error = data.d.split("#")[1];
                if (data.d.includes("true")) {
                    $("#startTask").css("display", "inline");
                    $('.timerlabel').text(error);
                    localStorage.removeItem(taskname + "_" + pid);
                    isStarted = false;

                } else {
                    $('.timerlabel').text(error);                    
                    //alert("Daily submission failed!");
                }
            },
            failure: function (error) {
                alert(error);
            }
        });
    });  //Daily subbmission

    $("#startTask").click(function () {    // Start task timer 
        var pid = $(".select-css").children("option:selected").val();
        var start = new Date().setSeconds(0, 0);

        $.ajax({
            type: "POST",
            url: "CreateTask.aspx/timerStarted", //It calls our web method  
            contentType: "application/json; charset=utf-8",
            data: "{taskname_pid:'" + taskname + "#" + pid + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d.includes("true")) {
                    isStarted = true;
                    $(".timerlabel").css("display", "block");

                    var dtime = data.d.toString().split("#")[1];
                    var time = dtime.split("_")[1];
                    var dt = dtime.split("_")[0];

                    var day = dt.split("-")[0];
                    var mon = dt.split("-")[1];

                    var hours = time.split(":")[0];
                    var min = time.split(":")[1];

                    localStorage.setItem(taskname + "_" + pid, day + "_" + mon + "|" + hours + "_" + min);

                    var timer = ((new Date - start) / (1000 * 60)); //time into minutes
                    timer = timer.toString().split(".")[0];
                    $('.timerlabel').text("STARTED...");
                }
            },
            failure: function (error) {
                alert(error);
            }
        });


        $(this).hide();
        $(".timerlabel").css("display", "block");

    });


    $("#suspendTask").click(function () {    // Start task timer 
        var pid = $(".select-css").children("option:selected").val();

        var sendStatus = "";
        localStorage.removeItem(taskname + "_" + pid);

        if (taskStatus == "suspend") {
            sendStatus = "active";
            $("#suspendTask").text("SUSPEND");
            $(".timerlabel").css("display", "block");
            $("#startTask").css("display", "inline");
        } else {
            sendStatus = "suspend";
            $(".timerlabel").css("display", "none");
            $("#startTask").css("display", "none");
        }

        $.ajax({
            type: "POST",
            url: "CreateTask.aspx/timerStarted", //It calls our web method  
            contentType: "application/json; charset=utf-8",
            data: "{taskname_pid:'" + taskname + "#" + pid + "#" + sendStatus + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d == "true") {
                    loadMyTask(pid);
                }
            },
            failure: function (error) {
                alert(error);
            }
        });



        $(".timerlabel").css("display", "block");

    });

    $("#deleteTask").click(function () {    // Start task timer 
        var pid = $(".select-css").children("option:selected").val();
        $.ajax({
            type: "POST",
            url: "CreateTask.aspx/timerStarted", //It calls our web method  
            contentType: "application/json; charset=utf-8",
            data: "{taskname_pid:'" + taskname + "#" + pid + "#delete" + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d == "true")
                    if (localStorage.getItem(taskname + "_" + pid) != null) {
                        localStorage.setItem(taskname + "_" + pid, new Date().getDate() + "_" + (new Date().getMonth() + 1) + "|" + new Date().getHours() + "_" + new Date().getMinutes());

                    }
            },
            failure: function (error) {
                alert(error);
            }
        });

        $(".timerlabel").css("display", "block");

    });


    //task status button event
    $(document).on("click", ".btnchoose", function () {

        $("#finalDocument").val("");
        $('.timerlabel').text("");

        if (!isAjaxRunning) {
            $("#modalPoll-1").modal('toggle');

            taskStatus = $(this).parent().siblings().children().find(".wip").text();

            var pid = $(".select-css").children("option:selected").val();
            taskname = $(this).parent().siblings().children().children().find("div").text();

            $(".timertaskname").text(taskname);  // set label taskname value

            if (taskStatus == "Active") {
                $("#finalsubmission").attr("disabled", "true");
                $(".collapse-expences").css('display', 'none');
            }
            else {
                $(".collapse-expences").css('display', 'inline');
                $("#finalsubmission").removeAttr("disabled");
            }

            if (taskStatus != "suspend") {
                $("#suspendTask").text("SUSPEND");
                $(".timerlabel").css("display", "block");
                $("#startTask").css("display", "inline");
                var storedTime = localStorage.getItem(taskname + "_" + pid);

                $.ajax({
                    type: "POST",
                    url: "CreateTask.aspx/timerStarted", //It calls our web method  
                    contentType: "application/json; charset=utf-8",
                    data: "{taskname_pid:'" + taskname + "#" + pid + "#startstatus" + "'}",
                    dataType: "json",
                    success: function (data) {

                        var status = data.d.split("#")[1];
                        if (data.d.includes("true")) {

                            if (status == "STARTED...")
                                $("#startTask").css("display", "none");
                            else
                                $("#startTask").css("display", "inline");

                            $(".timerlabel").text(status);
                        } else {
                            $("#startTask").css("display", "inline");
                            $(".timerlabel").text(status);
                        }
                        //if (localStorage.getItem(taskname + "_" + pid) != null) {
                        //    localStorage.setItem(taskname + "_" + pid, new Date().getDate() + "_" + (new Date().getMonth() + 1) + "|" + new Date().getHours() + "_" + new Date().getMinutes());

                        //}
                    },
                    failure: function (error) {
                        alert(error);
                    }
                });
            } else {
                localStorage.removeItem(taskname + "_" + pid);
                $("#suspendTask").text("ACTIVE");
                $("#startTask").css("display", "none");
                $(".timerlabel").css("display", "none");
            }
        } else {
            return;
        }

    });

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

        });
    }


    $("li").click(function () {

        var pid = $(".select-css").children("option:selected").val();

        switch ($(this).find("a").prop("id")) {

            case "assigntome_id":
                $(this).find("a").addClass("active_tab").parent().siblings().find("a").removeClass("active_tab");
                loadMyTask(pid);

                $(".firstt").css("display", "none");
                $(".secondt").css("display", "table");

                break;

            case "cases_id":
                $(this).find("a").addClass("active_tab").parent().siblings().find("a").removeClass("active_tab");
                loadTasks();
                $(".firstt").css("display", "table");
                $(".secondt").css("display", "none");
                break;

            default:

        }
    });

  

    function loadMyTask(pid) {

        $.ajax({
            type: "POST",
            url: "CreateTask.aspx/loadMyTasks", //It calls our web method  
            contentType: "application/json; charset=utf-8",
            data: "{id:'" + pid + "'}",
            dataType: "json",
            success: function (data) {

                var html = "";
                //html = html.replace(/"/g, "'");
                $("#mtask > tr").remove();


                $.each(data.d, function (key, val) {
                    var statusBtnDisabled = "";
                    var bgcolor = "#8dc2f8";

                    if (val.task_status == "Complete") {
                        bgcolor ="#398439"
                        statusBtnDisabled = "disabled=true";

                    } else if (val.task_status == "In Process") {
                        bgcolor = "#E0814E";
                    } else if (val.task_status == "Active") {
                        bgcolor = "#8dc2f8";
                    }

                    html = " <tr class='tr_all' id='curRow2'> <td class=''  valign='top'><div class='dropdown fl'><div class='sett' data-toggle='dropdown'></div><ul class='dropdown-menu sett_dropdown-caret'><li class='pop_arrow_new'></li><li onclick='startCase('2', '1', '3b68611795ab932e148ee40af45b0e11');' id='start2' style='display: none'><a href='javascript:void(0);'><div class='act_icon act_start_task fl' title='Start'></div>Start</a>                     </li><li onclick='caseResolve('2', '1', '3b68611795ab932e148ee40af45b0e11');' id='resolve2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_resolve_task fl' title='Resolve'></div>Resolve</a>                     </li><li onclick='setCloseCase('2', '1', '3b68611795ab932e148ee40af45b0e11');' id='close2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_close_task fl' title='Close'></div>Close</a>                     </li><li class='divider'></li><li id='act_reply2' data-task='3b68611795ab932e148ee40af45b0e11'><a href='javascript:void(0);' id='reopen2' style='display: none'><div class='act_icon act_reply_task fl' title='Re-open'></div>Re-open</a>                         <a href='javascript:void(0);' id='reply2' style='display: block'><div class='act_icon act_reply_task fl' title='Reply'></div>Reply</a>                     </li><li data-prjid='1' data-caseid='2' data-caseno='1' id='mv_prj2' style='' onclick='mvtoProject('2',this);'><a href='javascript:void(0);'><div class='act_icon pro_mov fl' title='Move to Project'></div>Move to Project</a>       </li><li onclick='moveTask('2', '1', '','1');' id='moveTask2' style='display: block'><a href='javascript:void(0);'><div class='act_icon task_move_mlst fl' title='Move Task To Milestone'></div>Move to Milestone</a>                     </li><li class='divider'></li><li onclick='archiveCase('2', '1', '1', 't_3b68611795ab932e148ee40af45b0e11');' id='arch2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_arcv_task fl' title='Archive'></div>Archive</a>                     </li><li onclick='deleteCase('2', '1', '1', 't_3b68611795ab932e148ee40af45b0e11');' id='arch2' style='display: block'><a href='javascript:void(0);'><div class='act_icon act_del_task fl' title='Delete'></div>Delete</a> </li></ul></div> <div id='csStsRep2' class='fl tsk_sts'><div class='label wip' style='background-color:" + bgcolor + "' >" + val.task_status + "</div></div></td>" +
                        "   <td class='title_det_wd'><div class='fl title_wd'><div id='titlehtml2' data-task='3b68611795ab932e148ee40af45b0e11' class='fl case-title '><div class='case_title wrapword task_title_ipad  ' style='color:#555555;' title='" + val.task_name + "'>" + val.task_name + "</div></div></div><div class='att_fl fr' style='display: none;' id='fileattch2'></div><div class='cb rcb'></div><div class='fnt999 fl' style='word-break:break-all'><div class='fl'><span id='stsdisp2'  class='cview_hide'>" + val.task_descriptions + "</span><span class='cview_hide'></span><span id='timedis2' class='cview_hide'></span><span id='timedis2' class='cview_show' title=''></span></div><div class='fl' style=''><div id='repno2' class='fl bblecnt'></div></div></div><div class='cb'></div></td>" +
                        "  <td valign='top'><span style='color: #E0814E'>" + val.fk_idlogin + "</span><span class='due_dt_icn'></span></td>" +
                        " <td class='fnt12 fntlink' valign='top'><a class='lnkattachment'> <span style='position: relative; top: 2px; cursor: text;' title='Download Document'>" + val.task_attachment + "</span></a></td><td><button type='button' class='btn btn-success btnchoose' style='height:30px;padding-top:4px' " + statusBtnDisabled + " >Status</button> </td></tr>";
                    $("#mtask").append(html);
                });

                if ($(".secondt tr").length < 2 && $(".secondt").attr("display") != "none" && $("#secondli").hasClass("active")) {
                    $(".lblerror").css("display", "none");
                    $(".lblerrormytask").css("display", "block");
                } else {
                    $(".lblerrormytask").css("display", "none");
                    $(".lblerror").css("display", "none");
                }

                $("#tskTabMyCnt").text("  (" + data.d.length + ")");

                html = "";
            },
            failure: function (error) {
                alert(error);
            }
        });
    }

   

        $(".task_section").show();
        $(".card").hide();

        $("#" + '<%= teamMemberID.ClientID %>').val($(this).children("option:selected").val());

      
       
        
   

});
