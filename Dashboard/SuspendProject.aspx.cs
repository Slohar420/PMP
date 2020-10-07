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
    static string empid = "";
    public static string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    private static string Retrivedtaskname = "";
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {

            GetActiveAndSuspendProjectCount();
        }      
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<SuspendProjectDetails> getSuspendProject()
    {
        List<SuspendProjectDetails> listProjectNameWithUserCount = new List<SuspendProjectDetails>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var res = webClient.UploadString(URL + "/GetSuspendProjectDetails", "POST", "");


        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response httpResponse = (Response)recv.ReadObject(ms);

        if (httpResponse.isValid)
        {
            int i = 0;
            foreach (DataRow item in httpResponse.DS.Tables[0].Rows)
            {
                TimeSpan spWorkMin = new TimeSpan();
                string workHours = "";

                if (httpResponse.DS.Tables[0].Rows[i]["minute"].ToString() != "")
                {
                    spWorkMin = TimeSpan.FromMinutes(Convert.ToDouble(httpResponse.DS.Tables[0].Rows[i]["minute"].ToString()));
                    workHours = spWorkMin.ToString(@"hh\:mm");
                }
                else
                {
                    workHours = "00:00";
                }
                listProjectNameWithUserCount.Add(new SuspendProjectDetails { ProjectName = item["project_name"].ToString(), UserCount = item["userCount"].ToString(), WorkingHour = workHours, taskcount = item["task"].ToString(), RecentActivity = item["lastactivity"].ToString(), idProjects = item["idProjects"].ToString() });
                i++;
            }
        }

        return listProjectNameWithUserCount;
    }
    protected void GetActiveAndSuspendProjectCount()
    {
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/GetActiveAndSuspendProjectCount", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);
            if (httpResponse.isValid)
            {
                if (httpResponse.DS.Tables[0].Rows.Count == 1)
                {
                    lblActiveProjectCount.Text = httpResponse.DS.Tables[0].Rows[0]["active"].ToString();
                    lblSuspendProjectCount.Text = httpResponse.DS.Tables[0].Rows[0]["Suspend"].ToString();
                    lblCompleteProjectCount.Text = httpResponse.DS.Tables[0].Rows[0]["Complete"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    [WebMethod]
    public static string ResumeProject(string ProjectName)
    {
        string response = "";
        try
        {
            Suspend reqSuspend = new Suspend();
            reqSuspend.projectName = ProjectName;
            reqSuspend.Type = "Resume";

            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(Suspend));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, reqSuspend);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/SuspendProject", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
            bool httpResponse = (bool)recv.ReadObject(ms);

            if (httpResponse)
            {
                response = "true";
            }
            else
                response = "false";
        }
        catch (Exception ex)
        {
            response = "false";
            ex.ToString();
        }
        return response;
    }
    public class SuspendProjectDetails
    {
        public string idProjects { get; set; }
        public string ProjectName { get; set; }
        public string UserCount { get; set; }
        public string WorkingHour { get; set; }
        public string taskcount { get; set; }
        public string RecentActivity { get; set; }
    }
}