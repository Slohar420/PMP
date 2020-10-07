<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" MasterPageFile="~/Dashboard/DSMaster.master" Inherits="Dashboard" %>

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
    <script>
        var chartData //global variable for hold chartdata//
        google.load("visualization", "1", { packages: ["corechart"] });  



        function drawChart() {
            var data = google.visualization.arryToDatatTable(chartData);

            var option = {
                title: "Company Revenue",
                pointSize: 5
            };
            var pieChart = new google.visualization.pieChart(document.getElementById('chart'));
            pieChart.draw(data, option);
        }

    </script>
    <style>
        .hide {
            display:none;
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
                <!-- Admin Dashboard-->
                <div runat="server" id="divAdminDashboard">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="scroll" style="max-height: 332px;">
                                <table class="card-body " id="tablePdetails">
                                </table>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="height: 392px; margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Recent Activity</div>
                            </div>
                            <div class="scroll card-body" style="max-height: 392px;">
                                <table class="card-body " id="tableRecentActivity">
                                </table>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">
                                    <select id="sel_task_type" style="color: #5191BD; background: #FFF; width: 140px; border: 1px solid #999;" onchange="showTaskStatus(this, '4bd2520594153ca4072ffb7d3855b04c');">
                                        <option value="New Development">New Development</option>
                                        <option value="Bug">Bug</option>
                                        <option value="Update">Update</option>
                                        <option value="Change Request">Change Request</option>
                                        <option value="Idea">Idea</option>
                                        <option value="Enhancement">Enhancement</option>
                                        <option value="Research n Do">Research n Do</option>
                                        <option value="Maintenance">Maintenance</option>
                                        <option value="Quality Assurance">Quality Assurance</option>
                                        <option value="Unit Testing">Unit Testing</option>
                                        <option value="Release">Release</option>
                                        <option value="Others">Others</option>
                                    </select>
                                </div>
                            </div>
                            <div class="card-body">
                                <canvas id="myChart" width="400" height="400"></canvas>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Project Status</div>
                            </div>
                            <div class="card-body">
                                <canvas id="myChart1" width="300" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Admin Dashboard End-->

                <!--  User Dashboard-->
             
                <div runat="server" id="divUserDashboard">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="scroll" style="max-height: 332px;">
                                <table class="card-body " id="tableTdetails">
                                </table>
                            </div>
                        </div>
                    </div>

                     <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="height: 392px; margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Recent Assigned Task </div>
                            </div>
                            <div class="scroll card-body" style="max-height: 392px;">
                                <table class="card-body " id="tableRecentAssignedTask">
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Task Status</div>
                            </div>
                            <div class="card-body">
                                <canvas id="myChart2" width="300" height="300"></canvas>
                            </div>
                        </div>
                    </div>

                     <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Work Overview</div>
                            </div>
                            <div class="card-body">
                                <canvas id="myChart3" width="300" height="300"></canvas>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- User Dashboard End-->

                 <!--  Admin Testing Dashboard-->
             
                <div runat="server" id="divAdminTesting">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="scroll" style="max-height: 332px;">
                                <table class="card-body " id="tableTdetailsTesting">
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="height: 392px; margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Recent Activity</div>
                            </div>
                            <div class="scroll card-body" style="max-height: 392px;">
                                <table class="card-body " id="tableRecentActivityTesting">
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Task Status</div>
                            </div>
                            <div class="card-body">
                                <canvas id="taskTesting" width="300" height="300"></canvas>
                            </div>
                        </div>
                    </div>

                     <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                        <div class="card" style="margin-left: 30px">
                            <div class="card-header">
                                <div class="fl">Work Overview</div>
                            </div>
                            <div class="card-body">
                                <canvas id="WorkTesting" width="300" height="300"></canvas>
                            </div>
                        </div>
                    </div>

                </div>
                <!--  Admin Testing Dashboard End-->

                <!-- /.row -->
            </div>
            <!--/. container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Admin Dashboard Script  -->
    <script>

        $(document).ready(function () {

            var TaskType = $("#sel_task_type").val();
            GetChartData(TaskType);
            GetChartDataAllTask();
            todayTask();
            ProjectDetails();
           
        });


        function GetChartData(value) {


            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetCharData", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{TaskType:'" + value + "'}",
                dataType: "json",
                success: function (data) {



                    // set varible through db data// 
                    var x = data.d[0].Inprocess;
                    var y = data.d[0].Active;
                    var z = data.d[0].complete;


                    //chart data/
                    var ctx = document.getElementById('myChart').getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: ['In-Process', 'Active', 'Complete'],
                            datasets: [{
                                label: '# of Votes',
                                data: [data.d[0].Inprocess, data.d[0].Active, data.d[0].complete],
                                backgroundColor: [
                                    'rgba(162, 63, 63, 1)',
                                    'rgba(0, 100, 240, 1)',
                                    'rgba(46, 216, 3, 1)',
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                     'rgba(54, 162, 235, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });


                },
                failure: function (error) {
                    alert(error);
                }
            });
        }

        function GetChartDataAllTask() {


            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetCharDataAllProject", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    //chart data/
                    var ctx = document.getElementById('myChart1').getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: ['In-Process', 'Suspend', 'Complete'],
                            datasets: [{
                                label: '# of Votes',
                                data: [data.d[0].InprocessTask, data.d[0].ActiveTask, data.d[0].completeTask],
                                backgroundColor: [
                                    'rgba(0, 100, 240, 1)',
                                     'rgba(162, 63, 63, 1)',
                                    'rgba(46, 216, 3, 1)'
                                ],
                                borderColor: [
                                     'rgba(54, 162, 235, 1)',
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });
        }
        function todayTask() {


            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetRecentActivity",
                data: '{}',
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


            function OnSuccess2(r) {

                $("#tableRecentActivity tr").detach();
                var table = document.getElementById("#tableRecentActivity");
                var htmlstring = "";

                $.each(r.d, function (key, val) {
                   
                    htmlstring += "<tr style='border-bottom:1px solid darkgray ;' class='t'>" +
                                       "<td style = 'width:10px'>" +
                                          "<i class = 'fa fa-user' style = 'font-size:43px; color:#0e4e93' ></i>" +
                                       "</td>" +
                                       "<td style = 'text-align:left'>" +
                                          "<span style='margin-left:20px'>" + r.d[key].AssginedTo + "<span > Submitted </span> Task </span>" +
                                           "<br>" +
                                           "<small style='margin-left: 20px; color: darkgray;'> Today " + r.d[key].datetime + " " +
                                           "</small>" +
                                       "</td>" +
                                 "</tr>"

                });
                $("#tableRecentActivity").append(htmlstring);
            }
        };

        function ProjectDetails() {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/getProjectData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function OnSuccess(r) {
               
                $("#tablePdetails tr").detach();
                var table = document.getElementById("#tablePdetails");
                var htmlstring = "";
                $("#tablePdetails").append("<tr id='myHeader' class='fixed_headers'>" +
                                               "<th>S No</th>" +
                                               "<th>Project Name</th>" +
                                               "<th>Status</th>" +
                                               "<th>User</th>" +
                                               "<th>Task</th>" +
                                               "<th>Main Hour</th>" +
                                               "<th>Main Hour Exp.</th>" +
                                               "<th>Tour Exp.</th>" +
                                               "<th>Other Exp.</th>" +
                                               "<th>Total Exp.</th>" +
                                           "</tr>");

                $.each(r.d, function (key, val) {

                    var bgcolor = "";
                    if (val.Status == "Processing")
                        bgcolor = "orange";
                    else if (val.Status == "Suspend")
                        bgcolor = "red";
                    else if (val.Status == "Complete")
                        bgcolor = "green";
                    else if (val.Status == "Testing")
                        bgcolor = "Orange";
                    htmlstring += "<tr style='align-text:center'> " +
                                       "<td>" + r.d[key].SNo + "</td>" +
                                       "<td>" + r.d[key].Pname + "</td>" +
                                       "<td ><i style='background-color:" + bgcolor + ";color:white;padding:3px;border-radius:5px ; width:100px'>" + r.d[key].Status + "</i></td>" +
                                       "<td>" + r.d[key].uCount + "<i class='fa fa-users' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td>" + r.d[key].tCount + "<i class='fa fa-tasks' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td>" + r.d[key].MainHour + "<i class='fa fa-clock-o' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td>" + r.d[key].MainHourExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td>" + r.d[key].TourExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td>" + r.d[key].OtherExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td>" + r.d[key].TotalExp + "<i class='fa fa-inr' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                  "</tr>";
                });
                $("#tablePdetails").append(htmlstring);
            }
        }

        //$(document).on("click", "#sel_task_type", function () {
        //    

        //    var TaskType = $("#sel_task_type").val();

        //})
        $("#sel_task_type").change(function () {

            var selected = $(this).val();
            GetChartData(selected);
        });


    </script>
    <!-- Admin Dashboard Script End -->

    <!-- User Dashboard Script Start -->
    <script>
        function TaskDetails(empid) {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/getTaskDetails",
                data: "{Userid:'" + empid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess3,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function OnSuccess3(r) {
               
                $("#tableTdetails tr").detach();
                var table = document.getElementById("#tableTdetails");
                var htmlstring = "";
                $("#tableTdetails").append("<tr id='myHeader' class='fixed_headers'>" +
                                               "<th>S No</th>" +
                                               "<th>Project Name</th>" +
                                               "<th>Total Task</th>" +
                                               "<th>Complete</th>" +
                                               "<th>Active</th>" +
                                               "<th>In Process</th>" +                                               
                                                "<th>Pause</th>" +
                                                "<th>Suspend</th>" +
                                               "<th>Total Main Hour</th>" +
                                           "</tr>");

                $.each(r.d, function (key, val) {
                 
                    htmlstring += "<tr style='align-text:center'> " +
                                       "<td>" + r.d[key].SNo + "</td>" +
                                       "<td>" + r.d[key].pname + "</td>" +
                                       "<td>" + r.d[key].totalTask + "<i class='fa fa-tasks' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td ><i style='background-color:green ; color:white; padding:3px; padding-left:20px ; padding-right:20px ; border-radius:5px ; width:100px'>" + r.d[key].completeTask + "</i></td>" +
                                       "<td><i style='background-color: blue ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].ActiveTask + "</i></td>" +
                                       "<td><i style='background-color: lightgreen ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].InprocessTask + "</i></td>" +
                                       "<td><i style='background-color: yellow ;color:black;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].PauseTask + "</i></td>" +
                                       "<td><i style='background-color: red ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].SuspendTask + "</i></td>" +
                                       "<td>" + r.d[key].totalMainHour + "<i class='fa fa-clock-o' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                  "</tr>";
                });
                $("#tableTdetails").append(htmlstring);
            }

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetRecentAssignTask",
                data: "{Userid:'" + empid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess4,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function OnSuccess4(r) {

                $("#tableRecentAssignedTask tr").detach();
                var table = document.getElementById("#tableRecentAssignedTask");
                var htmlstring = "";

                $.each(r.d, function (key, val) {

                    htmlstring += "<tr style='border-bottom:1px solid darkgray ;' class='t'>" +
                                       "<td style = 'width:10px'>" +
                                          "<i class = 'fa fa-user' style = 'font-size:43px; color:#0e4e93' ></i>" +
                                       "</td>" +
                                       "<td style = 'text-align:left'>" +
                                          "<span style='margin-left:20px'>" + r.d[key].AssginedTo + "<span > Assgined a </span> Task </span>" +
                                           "<br>" +
                                           "<small style='margin-left: 20px; color: darkgray;'> Today " + r.d[key].datetime + " " +
                                           "</small>" +
                                       "</td>" +
                                 "</tr>"

                });
                $("#tableRecentAssignedTask").append(htmlstring);
            }

            //load Chart data for task status//
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetTaskStatus", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Userid:'" + empid + "'}",
                dataType: "json",
                success: function (data) {
                    //chart data/
                    var ctx = document.getElementById('myChart2').getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: ['Complete', 'Active', 'In-Process', 'Pause' , 'Suspend'],
                            datasets: [{
                                label: '# of Votes',
                                data: [data.d[0].CompleteTask, data.d[0].ActiveTask, data.d[0].InProcessTask,data.d[0].PauseTask,data.d[0].SuspendTask],
                                backgroundColor: [
                                    'rgba(0, 128, 0, 1)',
                                     'rgba(0, 0, 255, 1)',
                                    'rgba(144, 238, 144, 1)',
                                    'rgba(255, 255, 0, 1)',
                                    'rgba(255, 0, 0, 1)',
                                     'rgba(255, 0, 0, 1)'
                                ],
                                borderColor: [
                                      'rgba(0, 128, 0, 1)',
                                     'rgba(0, 0, 255, 1)',
                                    'rgba(144, 238, 144, 1)',
                                    'rgba(255, 255, 0, 1)',
                                    'rgba(255, 0, 0, 1)',
                                     'rgba(255, 0, 0, 1)'
                                   
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });


            ////

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetWorkOverView", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Userid:'" + empid + "'}",
                dataType: "json",
                success: function (data) {
                    debugger;
                    var labels = [];
                    var value = [];
                    var color = [];
                    var bgColor = [];
                    var colorIndex = 0; 
                    for (var i = 0; i < data.d.length; i++)
                    {                        
                        labels[i] = data.d[i].TaskName;
                        value[i] = data.d[i].Minute;

                        if (colorIndex == 0) {
                            color[i] = 'rgba(13, 180, 98, 0.8)';
                            bgColor[i] = 'rgba(13, 180, 98, 0.8)';
                        }
                        else if (colorIndex == 1) {
                            color[i] = 'rgba(13, 71, 247, 0.8)';
                            bgColor[i] = 'rgba(13, 71, 247, 0.8)';
                        }
                        else if (colorIndex == 2) {
                            color[i] = 'rgba(244, 255, 55, 1)';
                            bgColor[i] = 'rgba(244, 255, 55, 1)';
                        }
                        else if (colorIndex == 3) {
                            color[i] = 'rgba(232, 33, 55, 1)';
                            bgColor[i] = 'rgba(232, 33, 55, 1)';
                        }                      
                        colorIndex++;
                        if (colorIndex > 3)
                            colorIndex = 0;
                    }


                    var ctx = document.getElementById('myChart3').getContext('2d');
                    
                    var myChart = new Chart(ctx, {
                        type: 'bar',                        
                        data: {                            
                            labels: labels,
                            datasets: [{
                                label: '# Time In HH.mm',
                                data:value,
                                backgroundColor: color,
                                borderColor: bgColor,
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });
        }

    </script>
    <!-- User Dashboard Script End -->

      <!-- User Dashboard Script Start -->
    <script>
        function TaskDetails(empid) {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/getTaskDetails",
                data: "{Userid:'" + empid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess3,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function OnSuccess3(r) {
               
                $("#tableTdetails tr").detach();
                var table = document.getElementById("#tableTdetails");
                var htmlstring = "";
                $("#tableTdetails").append("<tr id='myHeader' class='fixed_headers'>" +
                                               "<th>S No</th>" +
                                               "<th>Project Name</th>" +
                                               "<th>Total Task</th>" +
                                               "<th>Complete</th>" +
                                               "<th>Active</th>" +
                                               "<th>In Process</th>" +                                               
                                                "<th>Pause</th>" +
                                                "<th>Suspend</th>" +
                                               "<th>Total Main Hour</th>" +
                                           "</tr>");

                $.each(r.d, function (key, val) {
                 
                    htmlstring += "<tr style='align-text:center'> " +
                                       "<td>" + r.d[key].SNo + "</td>" +
                                       "<td>" + r.d[key].pname + "</td>" +
                                       "<td>" + r.d[key].totalTask + "<i class='fa fa-tasks' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td ><i style='background-color:green ; color:white; padding:3px; padding-left:20px ; padding-right:20px ; border-radius:5px ; width:100px'>" + r.d[key].completeTask + "</i></td>" +
                                       "<td><i style='background-color: blue ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].ActiveTask + "</i></td>" +
                                       "<td><i style='background-color: lightgreen ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].InprocessTask + "</i></td>" +
                                       "<td><i style='background-color: yellow ;color:black;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].PauseTask + "</i></td>" +
                                       "<td><i style='background-color: red ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].SuspendTask + "</i></td>" +
                                       "<td>" + r.d[key].totalMainHour + "<i class='fa fa-clock-o' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                  "</tr>";
                });
                $("#tableTdetails").append(htmlstring);
            }

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetRecentAssignTask",
                data: "{Userid:'" + empid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess4,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function OnSuccess4(r) {

                $("#tableRecentAssignedTask tr").detach();
                var table = document.getElementById("#tableRecentAssignedTask");
                var htmlstring = "";

                $.each(r.d, function (key, val) {

                    htmlstring += "<tr style='border-bottom:1px solid darkgray ;' class='t'>" +
                                       "<td style = 'width:10px'>" +
                                          "<i class = 'fa fa-user' style = 'font-size:43px; color:#0e4e93' ></i>" +
                                       "</td>" +
                                       "<td style = 'text-align:left'>" +
                                          "<span style='margin-left:20px'>" + r.d[key].AssginedTo + "<span > Assgined a </span> Task </span>" +
                                           "<br>" +
                                           "<small style='margin-left: 20px; color: darkgray;'> Today " + r.d[key].datetime + " " +
                                           "</small>" +
                                       "</td>" +
                                 "</tr>"

                });
                $("#tableRecentAssignedTask").append(htmlstring);
            }

            //load Chart data for task status//
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetTaskStatus", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Userid:'" + empid + "'}",
                dataType: "json",
                success: function (data) {
                    //chart data/
                    var ctx = document.getElementById('myChart2').getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: ['Complete', 'Active', 'In-Process', 'Pause' , 'Suspend'],
                            datasets: [{
                                label: '# of Votes',
                                data: [data.d[0].CompleteTask, data.d[0].ActiveTask, data.d[0].InProcessTask,data.d[0].PauseTask,data.d[0].SuspendTask],
                                backgroundColor: [
                                    'rgba(0, 128, 0, 1)',
                                     'rgba(0, 0, 255, 1)',
                                    'rgba(144, 238, 144, 1)',
                                    'rgba(255, 255, 0, 1)',
                                    'rgba(255, 0, 0, 1)',
                                     'rgba(255, 0, 0, 1)'
                                ],
                                borderColor: [
                                      'rgba(0, 128, 0, 1)',
                                     'rgba(0, 0, 255, 1)',
                                    'rgba(144, 238, 144, 1)',
                                    'rgba(255, 255, 0, 1)',
                                    'rgba(255, 0, 0, 1)',
                                     'rgba(255, 0, 0, 1)'
                                   
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });


            ////

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetWorkOverView", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Userid:'" + empid + "'}",
                dataType: "json",
                success: function (data) {
                    debugger;
                    var labels = [];
                    var value = [];
                    var color = [];
                    var bgColor = [];
                    var colorIndex = 0; 
                    for (var i = 0; i < data.d.length; i++)
                    {                        
                        labels[i] = data.d[i].TaskName;
                        value[i] = data.d[i].Minute;

                        if (colorIndex == 0) {
                            color[i] = 'rgba(13, 180, 98, 0.8)';
                            bgColor[i] = 'rgba(13, 180, 98, 0.8)';
                        }
                        else if (colorIndex == 1) {
                            color[i] = 'rgba(13, 71, 247, 0.8)';
                            bgColor[i] = 'rgba(13, 71, 247, 0.8)';
                        }
                        else if (colorIndex == 2) {
                            color[i] = 'rgba(244, 255, 55, 1)';
                            bgColor[i] = 'rgba(244, 255, 55, 1)';
                        }
                        else if (colorIndex == 3) {
                            color[i] = 'rgba(232, 33, 55, 1)';
                            bgColor[i] = 'rgba(232, 33, 55, 1)';
                        }                      
                        colorIndex++;
                        if (colorIndex > 3)
                            colorIndex = 0;
                    }


                    var ctx = document.getElementById('myChart3').getContext('2d');
                    
                    var myChart = new Chart(ctx, {
                        type: 'bar',                        
                        data: {                            
                            labels: labels,
                            datasets: [{
                                label: '# Time In HH.mm',
                                data:value,
                                backgroundColor: color,
                                borderColor: bgColor,
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });
        }

    </script>
    <!-- User Dashboard Script End --> 
    
     <!-- Admin Testing Dashboard Script Start -->
    <script>
        function TaskDetails(empid) {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/getTaskDetails",
                data: "{Userid:'" + empid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess3,
                failure: function (e) {
                    alert(r.d);
                },
                error: function (response) {
                    alert(r.d);
                }
            });


            function OnSuccess3(r) {
               
                $("#tableTdetailsTesting tr").detach();
                var table = document.getElementById("#tableTdetailsTesting");
                var htmlstring = "";
                $("#tableTdetailsTesting").append("<tr id='myHeader' class='fixed_headers'>" +
                                               "<th>S No</th>" +
                                               "<th>Project Name</th>" +
                                               "<th>Total Task</th>" +
                                               "<th>Complete</th>" +
                                               "<th>Active</th>" +
                                               "<th>In Process</th>" +                                               
                                                "<th>Pause</th>" +
                                                "<th>Suspend</th>" +
                                               "<th>Total Main Hour</th>" +
                                           "</tr>");

                $.each(r.d, function (key, val) {
                 
                    htmlstring += "<tr style='align-text:center'> " +
                                       "<td>" + r.d[key].SNo + "</td>" +
                                       "<td>" + r.d[key].pname + "</td>" +
                                       "<td>" + r.d[key].totalTask + "<i class='fa fa-tasks' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                       "<td ><i style='background-color:green ; color:white; padding:3px; padding-left:20px ; padding-right:20px ; border-radius:5px ; width:100px'>" + r.d[key].completeTask + "</i></td>" +
                                       "<td><i style='background-color: blue ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].ActiveTask + "</i></td>" +
                                       "<td><i style='background-color: lightgreen ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].InprocessTask + "</i></td>" +
                                       "<td><i style='background-color: yellow ;color:black;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].PauseTask + "</i></td>" +
                                       "<td><i style='background-color: red ;color:white;padding:3px;border-radius:5px ; padding-left:20px ; padding-right:20px; width:100px'>" + r.d[key].SuspendTask + "</i></td>" +
                                       "<td>" + r.d[key].totalMainHour + "<i class='fa fa-clock-o' style='color:#0e4e93; margin-left:5px'></i></td>" +
                                  "</tr>";
                });
                $("#tableTdetailsTesting").append(htmlstring);
            }

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetRecentActivityTesting",
                data: '{}',
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


            function OnSuccess2(r) {

                $("#tableRecentActivityTesting tr").detach();
                var table = document.getElementById("#tableRecentActivityTesting");
                var htmlstring = "";

                $.each(r.d, function (key, val) {

                    htmlstring += "<tr style='border-bottom:1px solid darkgray ;' class='t'>" +
                                       "<td style = 'width:10px'>" +
                                          "<i class = 'fa fa-user' style = 'font-size:43px; color:#0e4e93' ></i>" +
                                       "</td>" +
                                       "<td style = 'text-align:left'>" +
                                          "<span style='margin-left:20px'>" + r.d[key].AssginedTo + "<span > Submitted </span> Task </span>" +
                                           "<br>" +
                                           "<small style='margin-left: 20px; color: dar kgray;'> Today " + r.d[key].datetime + " " +
                                           "</small>" +
                                       "</td>" +
                                 "</tr>"

                });
                $("#tableRecentActivityTesting").append(htmlstring);
            }

            //load Chart data for task status//
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetTaskStatus", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Userid:'" + empid + "'}",
                dataType: "json",
                success: function (data) {
                    //chart data/
                    var ctx = document.getElementById('taskTesting').getContext('2d');
                    var myChart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: ['Complete', 'Active', 'In-Process', 'Pause' , 'Suspend'],
                            datasets: [{
                                label: '# of Votes',
                                data: [data.d[0].CompleteTask, data.d[0].ActiveTask, data.d[0].InProcessTask,data.d[0].PauseTask,data.d[0].SuspendTask],
                                backgroundColor: [
                                    'rgba(0, 128, 0, 1)',
                                     'rgba(0, 0, 255, 1)',
                                    'rgba(144, 238, 144, 1)',
                                    'rgba(255, 255, 0, 1)',
                                    'rgba(255, 0, 0, 1)',
                                     'rgba(255, 0, 0, 1)'
                                ],
                                borderColor: [
                                      'rgba(0, 128, 0, 1)',
                                     'rgba(0, 0, 255, 1)',
                                    'rgba(144, 238, 144, 1)',
                                    'rgba(255, 255, 0, 1)',
                                    'rgba(255, 0, 0, 1)',
                                     'rgba(255, 0, 0, 1)'
                                   
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });


            ////

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetWorkOverView", //It calls our web method  
                contentType: "application/json; charset=utf-8",
                data: "{Userid:'" + empid + "'}",
                dataType: "json",
                success: function (data) {
                    debugger;
                    var labels = [];
                    var value = [];
                    var color = [];
                    var bgColor = [];
                    var colorIndex = 0; 
                    for (var i = 0; i < data.d.length; i++)
                    {                        
                        labels[i] = data.d[i].TaskName;
                        value[i] = data.d[i].Minute;

                        if (colorIndex == 0) {
                            color[i] = 'rgba(13, 180, 98, 0.8)';
                            bgColor[i] = 'rgba(13, 180, 98, 0.8)';
                        }
                        else if (colorIndex == 1) {
                            color[i] = 'rgba(13, 71, 247, 0.8)';
                            bgColor[i] = 'rgba(13, 71, 247, 0.8)';
                        }
                        else if (colorIndex == 2) {
                            color[i] = 'rgba(244, 255, 55, 1)';
                            bgColor[i] = 'rgba(244, 255, 55, 1)';
                        }
                        else if (colorIndex == 3) {
                            color[i] = 'rgba(232, 33, 55, 1)';
                            bgColor[i] = 'rgba(232, 33, 55, 1)';
                        }                      
                        colorIndex++;
                        if (colorIndex > 3)
                            colorIndex = 0;
                    }


                    var ctx = document.getElementById('workTesting').getContext('2d');
                    
                    var myChart = new Chart(ctx, {
                        type: 'bar',                        
                        data: {                            
                            labels: labels,
                            datasets: [{
                                label: '# Time In HH.mm',
                                data:value,
                                backgroundColor: color,
                                borderColor: bgColor,
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
                },
                failure: function (error) {
                    alert(error);
                }
            });
        }

    </script>
    <!-- Admin Testing Dashboard Script End -->
</asp:Content>
