using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using Newtonsoft.Json;
using System.Web.Services;
using System.Web.Script.Services;
using System.Collections;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;
using LayoutStructure;

public partial class Dashboard : System.Web.UI.Page
{
    public static string empid = "";
    public static string userType = "";
    public static string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["loginid"] != null)
        {
            if (!IsPostBack)
            {
                if (Session["loginid"] != null)
                {
                    empid = Session["loginid"].ToString();
                    userType = Session["usertype"].ToString();

                    if (userType.ToString().ToLower() == "admin")
                    {
                        divAdminDashboard.Visible = true;
                        divUserDashboard.Visible = false;
                        divAdminTesting.Visible = false;
                    }
                    else if (userType.ToString().ToLower().Contains("admintesting"))
                    {
                        divAdminDashboard.Visible = false;
                        divUserDashboard.Visible = false;
                        divAdminTesting.Visible = true;
                      
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "TaskDetails('" + empid + "');", true);
                    }
                    else
                    {
                        divAdminDashboard.Visible = false;
                        divUserDashboard.Visible = true;
                        divAdminTesting.Visible = false;
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "TaskDetails('" + empid + "');", true);
                    }
                }
                else
                {

                }
            }
            else
            {

            }
        }
        else
        {
            Response.Redirect("login.aspx", false);
        }

    }

    [WebMethod]

    public static List<TaskType> GetCharData(string TaskType)
    {
        /// string projectname = "";
        List<TaskType> listTaskType = new List<TaskType>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var Data = JsonConvert.SerializeObject(TaskType);
        var res = webClient.UploadString(URL + "/GetChartData", "POST", Data);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response objReply = (Response)recv.ReadObject(ms);


        if (objReply.isValid)
        {
            if (objReply.DS.Tables[0].Rows.Count != 0)
            {
                foreach (DataRow item in objReply.DS.Tables[0].Rows)
                {
                    listTaskType.Add(new TaskType { Inprocess = item["Inprocess"].ToString(), Active = item["Active"].ToString(), complete = item["complete"].ToString() });
                }
            }
        }
        return listTaskType;
    }

    [WebMethod]

    public static List<AllTaskTpe> GetCharDataAllProject()
    {
        /// string projectname = "";
        List<AllTaskTpe> listAllTaskType = new List<AllTaskTpe>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var res = webClient.UploadString(URL + "/GetChartDataAllTask", "POST", "");

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response objReply = (Response)recv.ReadObject(ms);


        if (objReply.isValid)
        {
            if (objReply.DS.Tables[0].Rows.Count != 0)
            {
                foreach (DataRow item in objReply.DS.Tables[0].Rows)
                {
                    listAllTaskType.Add(new AllTaskTpe { InprocessTask = item["Inprocess"].ToString(), ActiveTask = item["Suspend"].ToString(), completeTask = item["complete"].ToString() });
                }
            }
        }
        return listAllTaskType;
    }
    [WebMethod]
    public static List<RecentActivity> GetRecentActivity()
    {
        List<RecentActivity> RecentActivityList = new List<RecentActivity>();
        try
        {
            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";


            var res = webClient.UploadString(URL + "/GetRecentActivity", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response objReply = (Response)recv.ReadObject(ms);


            if (objReply.isValid)
            {
                if (objReply.DS.Tables[0].Rows.Count != 0)
                {
                    int i = 0;
                    foreach (DataRow item in objReply.DS.Tables[0].Rows)
                    {

                        string[] time = objReply.DS.Tables[0].Rows[i]["submission_date"].ToString().Split('_');
                        string[] timecondition = time[1].Split(':');

                        if (Convert.ToDouble(timecondition[0]) > 12)
                            time[1] = time[1] + " PM";
                        else
                            time[1] = time[1] + " AM";


                        RecentActivityList.Add(new RecentActivity { datetime = time[1], AssginedTo = item["user_name"].ToString() });
                        i++;
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return RecentActivityList;
    }

    [WebMethod]
    public static List<RecentActivity> GetRecentActivityTesting()
    {
        List<RecentActivity> RecentActivityList = new List<RecentActivity>();
        try
        {
            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";


            var res = webClient.UploadString(URL + "/GetRecentActivityTesting", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response objReply = (Response)recv.ReadObject(ms);


            if (objReply.isValid)
            {
                if (objReply.DS.Tables[0].Rows.Count != 0)
                {
                    int i = 0;
                    foreach (DataRow item in objReply.DS.Tables[0].Rows)
                    {

                        string[] time = objReply.DS.Tables[0].Rows[i]["submission_date"].ToString().Split('_');
                        string[] timecondition = time[1].Split(':');

                        if (Convert.ToDouble(timecondition[0]) > 12)
                            time[1] = time[1] + " PM";
                        else
                            time[1] = time[1] + " AM";


                        RecentActivityList.Add(new RecentActivity { datetime = time[1], AssginedTo = item["user_name"].ToString() });
                        i++;
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }
        return RecentActivityList;
    }
    protected void getProjectData1()
    {
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/GetProjectDetails", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Reply));
            Reply objReply = (Reply)recv.ReadObject(ms);

            if (objReply.result)
            {
                if (objReply.DS.Tables[0].Rows.Count != 0)
                {

                }
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<projectDetails> getProjectData()
    {
        List<projectDetails> liprojectDetails = new List<projectDetails>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var res = webClient.UploadString(URL + "/GetProjectDetails", "POST", "");

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Reply));
        Reply objReply = (Reply)recv.ReadObject(ms);

        if (objReply.result)
        {
            int i = 0;
            TimeSpan spWorkMin = new TimeSpan();
            string workHours = "";
            decimal totalexp , MainHourExp ,TourExp,OtherExp;
            foreach (DataRow item in objReply.DS.Tables[0].Rows)
            {
             
                if (objReply.DS.Tables[0].Rows[i]["minute"].ToString() != "")
                {
                    spWorkMin = TimeSpan.FromMinutes(Convert.ToDouble(objReply.DS.Tables[0].Rows[i]["minute"].ToString()));
                    workHours = spWorkMin.ToString(@"hh\:mm");
                }
                else
                {
                    workHours = "00:00";
                }

                if (objReply.DS.Tables[0].Rows[i]["main hour expence"].ToString() != "" && objReply.DS.Tables[0].Rows[i]["tour Expense"].ToString() != ""
                    && objReply.DS.Tables[0].Rows[i]["expsense"].ToString() != "")
                {
                    totalexp = Convert.ToDecimal(Convert.ToDouble(objReply.DS.Tables[0].Rows[i]["main hour expence"].ToString())
                                                                   + Convert.ToDouble(objReply.DS.Tables[0].Rows[i]["tour Expense"].ToString())
                                                                   + Convert.ToDouble(objReply.DS.Tables[0].Rows[i]["expsense"].ToString()));

                    MainHourExp = Convert.ToDecimal(item["main hour expence"]);
                    TourExp = Convert.ToDecimal(item["tour Expense"]);
                    OtherExp = Convert.ToDecimal(item["expsense"]);
                }
                else
                {
                    MainHourExp = 0;
                    TourExp = 0;
                    OtherExp = 0;
                    totalexp = 0;
                }
                    

                liprojectDetails.Add(new projectDetails
                {
                    SNo = Convert.ToString(i + 1),
                    Pname = item["project_name"].ToString(),
                    Status = item["status"].ToString(),
                    uCount = item["UserCount"].ToString(),
                    tCount = item["task"].ToString(),
                    MainHour = workHours,
                    MainHourExp = String.Format("{0:0.00}", MainHourExp),
                    TourExp =     String.Format("{0:0.00}", TourExp),
                    OtherExp = String.Format("{0:0.00}", OtherExp),
                    TotalExp = String.Format("{0:0.00}", totalexp),
                    LastActivity = item["lastactivity"].ToString(),
                });
                i++;
            }
        }

        return liprojectDetails;
    }


    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<taskDetails> getTaskDetails(string Userid)
    {
        List<taskDetails> liTaskDetails = new List<taskDetails>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";
        var data = JsonConvert.SerializeObject(Userid);
        var res = webClient.UploadString(URL + "/GetTaskDetails", "POST", data);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Reply));
        Reply objReply = (Reply)recv.ReadObject(ms);

        if (objReply.result)
        {
            int i = 0; 
            foreach (DataRow item in objReply.DS.Tables[0].Rows)
            {
                string workHours = "";
                if (objReply.DS.Tables[0].Rows[i]["minute"].ToString() != null && objReply.DS.Tables[0].Rows[i]["minute"].ToString() != "")
                {

                    TimeSpan spWorkMin = TimeSpan.FromMinutes(Convert.ToDouble(objReply.DS.Tables[0].Rows[i]["minute"].ToString()));
                     workHours = spWorkMin.ToString(@"hh\:mm");
                }
                else
                {
                    workHours = "00:00";
                }

                liTaskDetails.Add(new taskDetails
                {
                    SNo = Convert.ToString(i + 1),
                    pname = item["project_name"].ToString(),
                    totalTask = item["task"].ToString(),
                    completeTask = item["complete"].ToString(),
                    ActiveTask = item["active"].ToString(),
                    InprocessTask = item["inprocess"].ToString(),
                    PauseTask = item["pause"].ToString(),
                    SuspendTask = item["suspend"].ToString(),
                    totalMainHour = workHours,
                });
                i++;
            }
        }

        return liTaskDetails;
    }

    [WebMethod]
    public static List<RecentActivity> GetRecentAssignTask(string Userid)
    {

        List<RecentActivity> RecentActivityList = new List<RecentActivity>();

        if (RecentActivityList != null)
            RecentActivityList.Clear();
        try
        {
            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var data = JsonConvert.SerializeObject(Userid);
            var res = webClient.UploadString(URL + "/GetRecentAssignedTask", "POST", Userid);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response objReply = (Response)recv.ReadObject(ms);


            if (objReply.isValid)
            {
                if (objReply.DS.Tables[0].Rows.Count != 0)
                {
                    int i = 0;
                    foreach (DataRow item in objReply.DS.Tables[0].Rows)
                    {

                        string[] time = objReply.DS.Tables[0].Rows[i]["start_date"].ToString().Split('_');
                        string[] timecondition = time[1].Split(':');

                        if (Convert.ToDouble(timecondition[0]) > 12)
                            time[1] = time[1] + " PM";
                        else
                            time[1] = time[1] + " AM";


                        RecentActivityList.Add(new RecentActivity { datetime = time[1], AssginedTo = item["user_name"].ToString() });
                        i++;
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }
        return RecentActivityList;
    }
    [WebMethod]
    public static List<TaskStatusUser> GetTaskStatus(string Userid)
    {
        /// string projectname = "";
        List<TaskStatusUser> liTaskStatusUser = new List<TaskStatusUser>();
        if (liTaskStatusUser != null)
            liTaskStatusUser.Clear();
        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var data = JsonConvert.SerializeObject(Userid);
        var res = webClient.UploadString(URL + "/GetTaskStatusUser", "POST", data);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response objReply = (Response)recv.ReadObject(ms);


        if (objReply.isValid)
        {
            if (objReply.DS.Tables[0].Rows.Count != 0)
            {
                foreach (DataRow item in objReply.DS.Tables[0].Rows)
                {
                    liTaskStatusUser.Add(new TaskStatusUser
                    {
                        CompleteTask = item["complete"].ToString(),
                        ActiveTask = item["active"].ToString(),
                        InProcessTask = item["inprocess"].ToString(),
                        PauseTask = item["pause"].ToString(),
                        SuspendTask = item["suspend"].ToString()
                    });
                }
            }
        }
        return liTaskStatusUser;
    }



    [WebMethod]
    public static List<WorkOverview> GetWorkOverView(string Userid)
    {
        /// string projectname = "";
        List<WorkOverview> liWorkOverview = new List<WorkOverview>();
        if (liWorkOverview != null)
            liWorkOverview.Clear();
        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var data = JsonConvert.SerializeObject(Userid);
        var res = webClient.UploadString(URL + "/GetWorkOverView", "POST", data);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response objReply = (Response)recv.ReadObject(ms);


        if (objReply.isValid)
        {
            if (objReply.DS.Tables[0].Rows.Count != 0)
            {
                int i = 0;
                foreach (DataRow item in objReply.DS.Tables[0].Rows)
                {
                    TimeSpan spWorkMin = TimeSpan.FromMinutes(Convert.ToDouble(objReply.DS.Tables[0].Rows[i]["worked_minutes"].ToString()));
                    string workHours = spWorkMin.ToString(@"hh\:mm");
                    workHours = workHours.Replace(':', '.');
                    liWorkOverview.Add(new WorkOverview
                    {
                        TaskName = item["task_name"].ToString(),
                        Minute = workHours,                     
                    });
                    i++;
                }
            }
        }
        return liWorkOverview;
    }
    protected void GetTesterList()
    {
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/GetTesterList", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response objReply = (Response)recv.ReadObject(ms);
        }
        catch (Exception ex)
        {

            throw;
        }
    }   
}