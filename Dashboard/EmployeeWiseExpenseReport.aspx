<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeWiseExpenseReport.aspx.cs" MasterPageFile="~/Dashboard/DSMaster.master" Inherits="Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="head" ContentPlaceHolderID="mainContent" runat="server">

    <style>
        th {
            font-weight: bold;
            color: #333333;
            background-color: #F3F3F3;
            text-align: center;
            padding: 3px;
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
            text-align: center;
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
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <div class="col-md-5 col-lg-5 col-sm-12 col-xs-12">
                        <label id="ReportHeading" style="font-weight: 800; font-size: 20px; color: #0e4e93; margin-bottom: 20px; margin-top: 5px; font-family: Georgia, 'Times New Roman', Times, serif;">Employee Wise Expense Report</label>
                    </div>

                </div>
                <div class="card" style="margin-left: 30px">
                    <div class="card-header" style="height: auto; color: black; padding-left: 0">
                          <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12" id="divFilterByUser">
                            <label for="psw-repeat" style="margin-left: -25px;"><b>Filter By User Name</b></label>
                            <asp:DropDownList runat="server" value="" Style="margin-bottom: 20px" type="date" ID="ddlFilterByUserName" class="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12" id="divFromDate">
                                <label for="psw-repeat" style="margin-left: -91px;"><b>From Date</b></label>
                                <asp:TextBox runat="server" value="" type="date" ID="txtFromDate" Style="margin-bottom: 10px;" class="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12" id="divToDate">
                                <label for="psw-repeat" style="margin-left: -113px;"><b>To Date</b></label>
                                <asp:TextBox runat="server" value="" type="date" ID="txtToDate" class="form-control"></asp:TextBox>
                            </div>    
                      
                        <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12" id="divFilterByUserType" style="display: none">
                            <label for="psw-repeat" style="margin-left: -135px;"><b>Filter By User Type</b></label>
                            <asp:DropDownList runat="server" value="" type="date" ID="ddlFilterByUserType" class="form-control"></asp:DropDownList>
                        </div>
                         <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12" id="divsearch" style="margin-top: 20px; ">
                                <button style="background-color: #00a65a;" id="btnSearch" type="button" onclick="search()" class="btn btn-success form-control">Search</button>
                            </div>
                        <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12" id="divpdf" style="margin-top: 29px;">
                            <asp:Button Style="background-color: #ec5e5e;" OnClick="btnPdfExport_Click" runat="server" ID="btnPdfExport" type="button" Text="Export PDF" class="btn btn-success form-control" />
                        </div>
                        <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12" id="divExcel" style="margin-top: 29px;">
                            <asp:Button ID="btnExcelExport" type="button" OnClick="btnExcelExport_Click" runat="server" Style="background-color: #00a65a;" value="Export Report" class="btn btn-success form-control" Text="Export Report" />
                        </div>
                    </div>
                    <div class="scroll" style="max-height: 500px;">
                        <table class="card-body " id="tableProjectDetails">
                        </table>
                        <div style="display: none">
                            <asp:GridView runat="server" ID="gvExportExceldata" AutoGenerateColumns="true"></asp:GridView>
                        </div>
                        <div id="divsorry" style="display: none">
                            <center><img src="images/sorry.png" style="margin-top:30px" /></center>
                        </div>
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
            var data = "";
            ProjectReportUserWise(data);

        })

        function ProjectReportUserWise(data) {
            debugger;
             if (data == undefined)
                data = "";
           
            $.ajax({
                type: "POST",
                url: "EmployeeWiseExpenseReport.aspx/getProjectExpenseUserWise",
                data: "{data : '" + data + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: done,
                failure: function (e) {
                    alert(e.d);
                },
                error: function (response) {
                    alert(e.d);
                }
            });


            function done(r) {

                $("#tableProjectDetails tr").detach();
                var table = document.getElementById("#tableProjectDetails");
                var htmlstring = "";
                $("#tableProjectDetails").append("<tr id='myHeader' class='fixed_headers'>" +
                                               "<th>Employee Name</th>" +
                                               "<th>Main Hour</th>" +
                                               "<th>Main Hour Exp.</th>" +
                                               "<th>Tour Exp</th>" +
                                               "<th>Other Exp</th>" +
                                               "<th>Total</th>" +
                                           "</tr>");
                if (r.d.length > 0) {
                    $.each(r.d, function (key, val) {

                        htmlstring += "<tr style='align-text:center'> " +
                                         "<td>" + r.d[key].employee + "</td>" +
                                         "<td>" + r.d[key].MainHour + "<i class='fa fa-clock-o' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                         "<td>" + r.d[key].MainHourExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                         "<td>" + r.d[key].TourExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                         "<td>" + r.d[key].OtherExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                         "<td>" + r.d[key].TotalExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                      "</tr>";

                    });                   
                    $("#tableProjectDetails").append(htmlstring);
                    $("#divsorry").css("display", "none");
                    $("#divpdf").css("display", "block");
                    $("#divExcel").css("display", "block");
                    $("#" + "<%=txtFromDate.ClientID%>").val("");
                    $("#" + "<%=txtToDate.ClientID%>").val("");
                }
                else {
                    $("#divsorry").css("display", "block");
                    $("#divpdf").css("display", "none");
                    $("#divExcel").css("display", "none");
                    $("#tableProjectDetails tr").detach();
                }

            }
        }
        $("#" + "<%=ddlFilterByUserName.ClientID%>").change(function () {
            var data = "";
            
            if ($(this).val() != "0") {
                data = $(this).val();
                ProjectReportUserWise(data);
            }
            else {
                ProjectReportUserWise(data);
            }

            
        })
        function search() {
            var fdate = $("#" + "<%=txtFromDate.ClientID%>").val();
            var tdate = $("#" + "<%=txtToDate.ClientID%>").val();
            
                data = fdate + "#" + tdate
            
            ProjectReportUserWise(data);
        }
    </script>

</asp:Content>
