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
    static string mytaskType = "";
    static byte[] filebytes = new byte[0];
    static string downloadFN = "";
    static string userRole = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            userRole = Session["usertype"].ToString();
            bindProjects();
            GetTesterList();
            if (object.ReferenceEquals(Session["loginid"], null)) { Response.Redirect("~/Default.aspx"); }
        }


        if (userRole == "admintesting")
        {
            divAssignTo.Visible = false;
            divAssignToTesting.Visible = true;
            divTaskType.Visible = false;
        }
        else
        {
            divTaskType.Visible = true;
            divAssignTo.Visible = true;
            divAssignToTesting.Visible = false;
        }
        empid = Session["loginid"].ToString();
        
        if (Session["usertype"].ToString().ToLower() == "developer")
        {
            mytaskType = "new development";
        }
        else if (Session["usertype"].ToString().ToLower() == "tester") {
            mytaskType = "";
        }

    }

    private void bindProjects()
    {
        try
        {
            string data = "";
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            if (userRole == "admintesting")
                data = "admintesting";
            else
                data = "";
            data = JsonConvert.SerializeObject(data);
            var res = webClient.UploadString(URL + "/allProjects", "POST", data);


            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);

            if (httpResponse.isValid)
            {
                ddlprojects.Items.Clear();
                DataTable dt = httpResponse.DS.Tables[0];
                foreach (DataRow item in dt.Rows)
                {
                    ddlprojects.Items.Add(new ListItem { Text = item[2].ToString().ToUpper(), Value = item[0].ToString() });
                }
            }
        }
        catch (Exception ex)
        {
            throw;
        }
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

            if (objReply.isValid)
            {
                if (objReply.DS.Tables[0].Rows.Count != 0)
                {
                    ddlAssignToTesting.Items.Clear();
                    ddlAssignToTesting.Items.Add(new ListItem { Value = "0", Text = "Select Team Member" });
                    for (int i = 0; i < objReply.DS.Tables[0].Rows.Count; i++)
                    {
                        ddlAssignToTesting.Items.Add(new ListItem { Value = objReply.DS.Tables[0].Rows[i][0].ToString(), Text = objReply.DS.Tables[0].Rows[i][12].ToString() });

                    }


                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    /// <summary>
    /// Load team accordingly selected project from dropdown
    /// </summary>
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static Dictionary<string, string> loadProjectTeam(string pid)
    {
        Dictionary<string, string> keyValues = new Dictionary<string, string>();
        try
        {
            // lblpid = (Label)(Master).FindControl("lblpid");

            var projectid = pid;

            //projectid =lblpid.Text;

            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var json = JsonConvert.SerializeObject(projectid);

            var res = webClient.UploadString(URL + "/projectTeam", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response resp = (Response)recv.ReadObject(ms);

            if (resp.isValid)
            {
                if (resp.DS.Tables[0].Rows.Count > 0)
                {

                    keyValues.Clear();
                    foreach (DataRow item in resp.DS.Tables[0].Rows)
                    {
                        keyValues.Add(item[0].ToString(), item[1].ToString());

                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw;
        }
        return keyValues;
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string getTaskName(string id)  //MARK:- it retrives taskname accordingly previews tasks
    {

        try
        {
            Dictionary<string, string> list = new Dictionary<string, string>();

            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var json = JsonConvert.SerializeObject(id);

            var res = webClient.UploadString(URL + "/getTaskName", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(string));
            string taskname = (string)recv.ReadObject(ms);

            if (taskname != "")
            {
                Retrivedtaskname = taskname;
                return taskname;
            }
            else
            {
                return "";
            }
        }
        catch (Exception ex)
        {
            return "";
            throw;
        }

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="taskname_pid">this parameter contains project id as well as taskname to update start time</param>
    /// <returns></returns>
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string timerStarted(string taskname_pid)  //Saving timer data when it starts
    {
        try
        {

            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var json = JsonConvert.SerializeObject(taskname_pid);

            var res = webClient.UploadString(URL + "/UpdateTask", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(string));
            string isupdated = (string)recv.ReadObject(ms);

            if (isupdated != "")
            {
                Retrivedtaskname = isupdated;
                return isupdated;
            }
            else
            {
                return "";
            }
        }
        catch (Exception ex)
        {
            return "";
            throw;
        }
    }




    protected void ddlprojects_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Session["selectedvalue"] = ddlprojects.SelectedItem.Value;
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Tasks tasks = new Tasks();
            if (Retrivedtaskname != "")
            {
                tasks.task_name = Retrivedtaskname;
                tasks.task_descriptions = txtDescription.Text;

                if (attachmentfile.HasFile)
                {
                    tasks.task_attachment = attachmentfile.FileName.ToString();
                    tasks.attachmentBytes = attachmentfile.FileBytes;                   
                }
                else
                {
                    tasks.task_attachment = "N/A";
                }

                //if (teamMemberID.Value == "" || teamMemberID.Value == "0")
                //{
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('Select team member!');", true);
                //    return;
                //}
                //else if (ddlTaskType.SelectedIndex < 1)
                //{
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('Select task type!');", true);
                //    return;
                //}
                //else if (txtDescription.Text.Length < 200) {
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('Task description must contain at least 200 characters...');", true);
                //    return;
                //}



                tasks.task_status = "Active";
                tasks.duedate = txtDueDate.Text;
                tasks.email_status = "";
                tasks.fk_idlogin = Session["loginid"].ToString();
                tasks.start_date = DateTime.Now.ToString("dd/MM/yyyy_HH:mm:ss");
            
                tasks.projectid = ddlprojects.SelectedItem.Value;
                if (userRole == "admintesting")
                {
                    tasks.assigned_to = ddlAssignToTesting.SelectedValue;
                    tasks.task_type = "Testing";
                }
                else
                {
                    tasks.assigned_to = teamMemberID.Value;
                    tasks.task_type = ddlTaskType.SelectedItem.Text;
                }
                


                if (rdHigh.Checked)
                {
                    tasks.task_priority = "high";
                }
                else if (rdMedium.Checked)
                {
                    tasks.task_priority = "medium";
                }
                else if (rdLow.Checked)
                {
                    tasks.task_priority = "low";
                }


                WebClient webClient = new WebClient();
                webClient.Headers[HttpRequestHeader.ContentType] = "application/json";


                DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(Tasks));
                MemoryStream memStrToSend = new MemoryStream();
                objJsonSerSend.WriteObject(memStrToSend, tasks);
                string json = Encoding.Default.GetString(memStrToSend.ToArray());

                var res = webClient.UploadString(URL + "/addTask", "POST", json);

                MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
                DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
                bool resp = (bool)recv.ReadObject(ms);

                if (resp)
                {
                    string add = "Task Added Successfully ! ";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);

                    txtDueDate.Text = "";
                    ddlTaskType.SelectedIndex = 0;
                    txtDescription.Text = "";

                }
                else
                {
                    string add = "Task Added Failed ! ";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + add + "');", true);
                }
            }
            else
            {
                string add = "Task Added Failed ! Task  Name Is Empty ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + add + "');", true);
            }
           
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    private void DownloadFile(string filename,byte[] file) {
        try
        {
            string extention = filename.Split('#')[0].Substring(filename.Split('#')[0].LastIndexOf('.') + 1);  // Extracting file extension

            HttpContext.Current.Response.Clear();
            MemoryStream ms = new MemoryStream(file);
            //HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            //HttpContext.Current.Response.AppendHeader("content-disposition", "attachment; filename=myfile.xls");
            HttpContext.Current.Response.ContentType  = "application/pdf";
            HttpContext.Current.Response.AppendHeader("content - disposition", "attachment;filename=labtest.pdf");
            //  HttpContext.Current.Response.Buffer = true;
            //ms.WriteTo(HttpContext.Current.Response.OutputStream);
            HttpContext.Current.Response.Write(ms);
            // HttpContext.Current.Response.End();
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string downloadAttachment(string filename_pname)  //MARK:- it retrives attachment file 
    {
      
        try
        {

            Dashboard dashboard = new Dashboard();

            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var json = JsonConvert.SerializeObject(filename_pname);

            var res = webClient.UploadString(URL + "/downloadAttachment", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            //DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(string));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(byte[]));

            filebytes = (byte[])recv.ReadObject(ms);
            downloadFN = filename_pname.Split('#')[0];

            if (filebytes.Length > 0)
            {
                return "true";
            }
            else
            {
                return "false";
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Tasks> loadMyTasks(string id)  //MARK:- it retrives all logged in user's Task accordingly projectid
    {
        List<Tasks> tasks = new List<Tasks>(); // Property:- List of task to populate in view

        try
        {

            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var json = JsonConvert.SerializeObject(id);

            var res = webClient.UploadString(URL + "/retriveAllTask", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response resp = (Response)recv.ReadObject(ms);

            if (resp.isValid)
            {
                if (resp.DS.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow item in resp.DS.Tables[0].Rows)
                    {
                        string tasktype = item[10].ToString().ToLower().Trim();
                       // if (item[4].ToString() == empid&&tasktype==mytaskType)
                        if (item[4].ToString() == empid)
                        {
                            tasks.Add(new Tasks
                            {
                                tid = item[0].ToString(),
                                task_name = item[1].ToString(),
                                task_descriptions = item[2].ToString(),
                                start_date = item[7].ToString(),
                                duedate = item[3].ToString(),
                                assigned_to = item[16].ToString(),
                                task_status = item[8].ToString(),
                                projectid = item[5].ToString(),
                                task_type = item[6].ToString(),
                                task_priority = item[8].ToString(),
                                task_attachment = item[11].ToString(),
                                fk_idlogin = item["assigned_by"].ToString()
                            });
                        }
                    }
                }
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            throw;
        }
        return tasks;
    }


    protected void savebtn_Click(object sender, EventArgs e)
    {
        try
        {
            if (filebytes.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + downloadFN);
                Response.BinaryWrite(filebytes);
                Response.End();
            }
        }
        catch (Exception ex)
        {

            throw;
        }
    }


    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<Tasks> loadAllTasks(string id)  //MARK:- it retrives all Task accordingly previews tasks
    {
        List<Tasks> tasks = new List<Tasks>();
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var json = JsonConvert.SerializeObject(id);

            var res = webClient.UploadString(URL + "/retriveAllTask", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response resp = (Response)recv.ReadObject(ms);

            if (resp.isValid)
            {
                if (resp.DS.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow item in resp.DS.Tables[0].Rows)
                    {
                        tasks.Add(new Tasks
                        {
                            tid = item[0].ToString(),
                            task_name = item[1].ToString(),
                            task_descriptions = item[2].ToString(),
                            start_date = item[7].ToString(),
                            duedate = item[3].ToString(),
                            assigned_to = item["task_member"].ToString(),
                            task_status = item[8].ToString(),
                            projectid = item[5].ToString(),
                            task_type = item[6].ToString(),
                            task_priority = item[8].ToString(),
                            task_attachment = item[11].ToString(),
                            fk_idlogin = item["assigned_by"].ToString()
                        });
                    }
                }
            }
            else
            {

            }
        }
        catch (Exception ex)
        {         
        }
        return tasks;
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string dailySubmission(string taskname_pid)  //MARK:- it updates Task status 
    {
        string updatestatus = "";
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";



            var json = JsonConvert.SerializeObject(taskname_pid);

            var res = webClient.UploadString(URL + "/UpdateTask", "POST", json);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(string));
            string resp = (string)recv.ReadObject(ms);

            updatestatus = resp;
        }
        catch (Exception ex)
        {
            throw;
        }
        return updatestatus;
    }

}