 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="File.aspx.cs" MasterPageFile="~/Dashboard/DSMaster.master" Inherits="Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="head" ContentPlaceHolderID="mainContent" runat="server">

    <style>
        th {
            font-weight: bold;
            color: #333333;
            background-color: #F3F3F3;
            text-align: left;
            padding: 3px;
            padding-left:10px;
            font-size: medium;
            width: 300px;
        }

        .tr_col_sec {
            background-color: #EAF1F6;
        }

        tr:hover {
            background-color: #FFFFAE;
        }

        td {
            text-align: left;
            padding: 10px;
            width: 300px;
        }

        .t:hover {
            background-color: #fff;
        }
    </style>

    <style>
        .hide {
            display: none;
        }

        .card-header {
            height: 40px;
            font-size: 17px;
            font-family: 'helvetica-Neue-bold';
            box-shadow: 0 6px 9px -5px rgb(177, 171, 171);
            color: #5191BD;
            outline: none;
            padding-left: 20px;
            padding-top: 8px;
            float: left;
        }

        .scroll {
            overflow-y: auto;
            overflow-x: auto;
        }

            .scroll::-webkit-scrollbar {
                width: 12px;
            }

            .scroll::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
                border-radius: 10px;
            }

            .scroll::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
            }

        /* Fixed Headers */

        th {
            position: -webkit-sticky;
            position: sticky;
            top: 0;
            z-index: 2;
        }

            th[scope=row] {
                position: -webkit-sticky;
                position: sticky;
                left: 0;
                z-index: 1;
            }

            th[scope=row] {
                vertical-align: top;
                color: inherit;
                background-color: inherit;
                background: linear-gradient(90deg, transparent 0%, transparent calc(100% - .05em), #d6d6d6 calc(100% - .05em), #d6d6d6 100%);
            }

        table:nth-of-type(2) th:not([scope=row]):first-child {
            left: 0;
            z-index: 3;
            background: linear-gradient(90deg, #666 0%, #666 calc(100% - .05em), #ccc calc(100% - .05em), #ccc 100%);
        }

        /* Strictly for making the scrolling happen. */

        th[scope=row] + td {
            min-width: 24em;
        }

        th[scope=row] {
            min-width: 20em;
        }
    </style>

    <!-- Content Wrapper. Contains page content -->
    <div class="" style="background-color: rgb(255, 255, 255); margin-left: 80px !important;">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row" style="margin-left:30px ; margin-top:-20px">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <label style=" font-size: 1.2vw; font-family: Georgia, 'Times New Roman', Times, serif">PROJECT  : </label>
                        <asp:DropDownList ID="ddlprojects" Font-Names="times new roman" runat="server" CssClass="select-css"></asp:DropDownList>
                    </div>
                </div>
                <div class="row" style="margin-left:30px ; margin-top:20px">
                    <div  class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <table class="text-left m-btm-25" id="tableFile" style="width:100%">
                        </table>
                         <div id="divsorry" style="display: none">
                                <center><img src="images/sorry.png" style="margin-top:30px" /></center>
                            </div>
                           <asp:Button ID="savebtn" runat="server" OnClick="savebtn_Click" Style="display: none" />
                    </div>
                   
                </div>

            </div>
            <!--/. container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <script>
        $(document).ready(function () {
            var projectid = $(".select-css").children("option:selected").val();
            loadTasks(projectid);

        })
        $(".select-css").change(function () {

            var projectid = $(this).children("option:selected").val();  //ProjectID from dropdown
            loadTasks(projectid);

        });
        function loadTasks(projectid) {
            debugger;
            $.ajax({
                type: "POST",
                url: "File.aspx/GetFileData",
                data: "{projectid : '" + projectid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: done,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function done(r) {

                $("#tableFile tr").detach();
                var table = document.getElementById("#tableFile");
                var htmlstring = "";

                $("#tableFile").append("<tr id='myHeader' class='fixed_headers' style='    background: #f3f3f3;border: 1px solid #CCCCCC;'>" +
                                               "<th>Task</th>" +
                                                "<th style='padding-left:23px'>File</th>" +
                                               "<th>Uploaded by</th>" +
                                               "<th>Uploaded Date</th>" +
                                           "</tr>");
                if (r.d.length > 0) {
                    $.each(r.d, function (key, val) {
                        debugger;
                        var img = "";
                        if (val.file.includes(".pdf")) {                           
                            img = "fa fa-file-pdf-o";
                        }
                        else if (val.file.includes(".doc")) {
                            img = "fa fa-file-text-o";
                        }
                        else if (val.file.includes(".ppt")) {
                            img = "fa fa-file-o";
                        }
                        else if (val.file.includes(".zip")) {
                            img = "fa fa-file-archive-o";
                        }
                        else if (val.file.includes(".xls")) {
                            img = "fa fa-file-excel-o";
                        }
                        else if (val.file.includes(".html") || val.file.includes(".aspx")) {
                            img = "fa fa-chrome";
                        }
                        else if (val.file.includes(".jpg") || val.file.includes(".png") || val.file.includes(".jpeg") || val.file.includes(".csv")) {
                            img = "fa fa-file-image-o";
                        }
                        else if (val.file == "N/A") {
                            img = "";
                        }

                        else {
                            img = "fa fa-file-image-o";
                        }
                           
                        htmlstring += "<tr style='align-text:center' class='t'> " +
                                           "<td>" + r.d[key].Task + "</td>" +
                                           "<td class='fntlink'><i class='" + img + "' style='color:#0e4e93'></i><a class='lnkattachment'><span style='position: relative; margin-left:10px; top: 2px; cursor: text; color:#3c8dbc' title='Download Document'>" + r.d[key].file + "</span></td>" +
                                           "<td><span style='color:#E0814E'>" + r.d[key].uploadby + "</span></td>" +
                                           "<td>" + r.d[key].date_time + "</td>" +
                                      "</tr>";
                    });
                    $("#tableFile").append(htmlstring);
                    $("#divsorry").css("display", "none");
                    $("#divpdf").css("display", "block");
                    $("#divExcel").css("display", "block");
                }
                else {
                    $("#divsorry").css("display", "block");
                    $("#divpdf").css("display", "none");
                    $("#divExcel").css("display", "none");
                    $("#tableFile tr").detach();
                }

            }
        }

        $(document).on('click', '.fntlink', function () {  // Attachment link click
            debugger;
            var filename = $(this).find('.lnkattachment').children("span").text();
            var pname = $(".select-css").children("option:selected").text();

            if (!filename.toLocaleLowerCase().includes('n/a'))
                if (!isAjaxRunning) {
                    var downloadConf = confirm('Do you want to download ' + "'" + filename.toLocaleUpperCase() + "'" + ' ?');
                    debugger;
                    if (downloadConf) {
                        $.ajax({
                            type: "POST",
                            url: "File.aspx/downloadAttachment", //It calls our web method  
                            contentType: "application/json; charset=utf-8",
                            data: "{filename_pname:'" + filename + "#" + pname + "'}",
                            dataType: "json",
                            success: function (data) {
                                debugger;
                                if (data.d == "true") {
                                    document.getElementById('mainContent_savebtn').click();
                                }
                                else {
                                    var error = "This file is no longer available ! Download Failed";
                                    OnError(error);
                                }                 

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


    </script>

</asp:Content>
