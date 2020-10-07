using LayoutStructure;
using LipiRMS;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Projects : System.Web.UI.Page
{
    public static string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"].ToString() != "")
        {
            if (!IsPostBack)
            {
                ProjectManagers();
                ProjectMembers();
                GetActiveAndSuspendProjectCount();
                GetTesterList();
            }
        }
        else
        {
            Response.Redirect("Default.aspx",true);
        }        
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static bool saveProject(string Projectname)
    {

        var createdate = "10-10-20";
        EmpProject project = new EmpProject { Project_Name = Projectname };

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(EmpProject));
        MemoryStream memStrToSend = new MemoryStream();
        objJsonSerSend.WriteObject(memStrToSend, project);
        string data = Encoding.Default.GetString(memStrToSend.ToArray());

        var res = webClient.UploadString(URL + "/addProject", "POST", data);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
        bool httpResponse = (bool)recv.ReadObject(ms);



        return httpResponse;
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<ProjecNameWithUserCount> getProject()
    {
        List<ProjecNameWithUserCount> listProjectNameWithUserCount = new List<ProjecNameWithUserCount>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var res = webClient.UploadString(URL + "/GetUserInProjects", "POST", "");


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


                listProjectNameWithUserCount.Add(new ProjecNameWithUserCount { ProjectName = item["project_name"].ToString(), UserCount = item["userCount"].ToString(), WorkingHour = workHours, taskcount = item["task"].ToString(), RecentActivity = item["lastactivity"].ToString(), idProjects = item["idProjects"].ToString() });
                i++;
            }
        }

        return listProjectNameWithUserCount;
    }



    protected void btncreate_Click(object sender, EventArgs e) //MARK:- it adds new project
    {
        try
        {

            var members = listmembers.SelectedValue.ToString();
            string[] membs = new string[0];
            var k = 0;
            for (int i = 0; i < listmembers.Items.Count; i++)
            {
                if (listmembers.Items[i].Selected)
                {
                    Array.Resize(ref membs, membs.Length + 1);
                    membs[k] = listmembers.Items[i].Value;
                    k++;
                }
            }



            EmpProject project = new EmpProject
            {
                Project_Name = txtProjectName.Text,
                Project_Type = ddlptype.SelectedValue.ToString(),
                project_subtype = ddlsubtype.SelectedValue.ToString(),
                Project_duedate = txtduedate.Text,
                project_manager = ddlprojectmanager.SelectedValue.ToString(),
                Description = txtDescription.Text,
                Source = txtSource.Text,
                TeamID = membs,
                fk_idlogin = "1"
            };


            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(EmpProject));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, project);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/addProject", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
            bool httpResponse = (bool)recv.ReadObject(ms);

            if (httpResponse)
            {
                allClear();
                listmembers.ClearSelection();
                    GetActiveAndSuspendProjectCount();
                string add = "Project Create Successfully ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
            }
            else
            {
                string add = "Project Create Failed ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + add + "');", true);
            }


        }
        catch (Exception ex)
        {
            Log.Write("Exception In Add Project " + ex.ToString(), "");
        }
    }


    public class Response1
    {

        public DataSet DS { get; set; }

        public string Error { get; set; }
        public bool isValid { get; set; }
        public bool FirstTimeLogin { get; set; }
    }


    private void ProjectManagers()
    {
        try
        {


            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/GetAllManager", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);

            if (httpResponse.isValid)
            {
                ddlprojectmanager.Items.Clear();
                ddlprojectmanager.Items.Add(new ListItem { Value = "0", Text = "Select Manager" });
                for (int i = 0; i < httpResponse.DS.Tables[0].Rows.Count; i++)
                {
                    ddlprojectmanager.Items.Add(new ListItem { Value = httpResponse.DS.Tables[0].Rows[i][1].ToString(), Text = httpResponse.DS.Tables[0].Rows[i][0].ToString() });
                    ddlEditProjectManager.Items.Add(new ListItem { Value = httpResponse.DS.Tables[0].Rows[i][1].ToString(), Text = httpResponse.DS.Tables[0].Rows[i][0].ToString() });

                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    private void ProjectMembers()
    {
        try
        {
            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/GetAllMember", "POST", "");

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);

            listmembers.Items.Clear();

            if (httpResponse.isValid)
            {
               
                for (int i = 0; i < httpResponse.DS.Tables[0].Rows.Count; i++)
                {
                    listmembers.Items.Add(new ListItem { Value = httpResponse.DS.Tables[0].Rows[i][1].ToString(), Text = httpResponse.DS.Tables[0].Rows[i][0].ToString() });



                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void ddlptype_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlptype.SelectedIndex == 1)
            {
                ddlsubtype.Items.Clear();

                ddlsubtype.Items.Add("RMS");
                ddlsubtype.Items.Add("ATM");
                ddlsubtype.Items.Add("PB");

            }
            else if (ddlptype.SelectedIndex == 2)
            {
                ddlsubtype.Items.Clear();

                ddlsubtype.Items.Add("RMS");
                ddlsubtype.Items.Add("ATM");
                ddlsubtype.Items.Add("PB");

            }
            else if (ddlptype.SelectedIndex == 3)
            {
                ddlsubtype.Items.Clear();

                ddlsubtype.Items.Add("RMS");
                ddlsubtype.Items.Add("ATM");
                ddlsubtype.Items.Add("PB");

            }
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "GetTableValues();", true);
    }


    [WebMethod]
    public static string AddUserInThisProject(string ProjectName, string UserId)
    {
        string response = "";
        try
        {

            string[] UserIDdata = UserId.Split(',');
            ReqAddUserInThisProject objReqAddUserInThisProject = new ReqAddUserInThisProject();

            objReqAddUserInThisProject.projectName = ProjectName;
            objReqAddUserInThisProject.type = "Add";
            int count = 0;
            for (int i = 0; i < UserIDdata.Length; i++)
            {
                if (UserIDdata[i] != "")
                {
                    count++;
                }
            }
            objReqAddUserInThisProject.userID = new string[count];
            int k = 0;
            for (int i = 0; i < UserIDdata.Length; i++)
            {
                if (UserIDdata[i] != "")
                {
                    objReqAddUserInThisProject.userID[k] = UserIDdata[i];
                    k++;
                }
            }

            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(ReqAddUserInThisProject));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, objReqAddUserInThisProject);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/addUserInThisProject", "POST", data);

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


    [WebMethod]
    public static string RemoveUserInThisProject(string ProjectName, string UserId)
    {
        string response = "";
        try
        {

            string[] UserIDdata = UserId.Split(',');

            ReqAddUserInThisProject objReqAddUserInThisProject = new ReqAddUserInThisProject();

            objReqAddUserInThisProject.projectName = ProjectName;
            objReqAddUserInThisProject.type = "Remove";
            int count = 0;
            for (int i = 0; i < UserIDdata.Length; i++)
            {
                if (UserIDdata[i] != "")
                {
                    count++;
                }
            }
            objReqAddUserInThisProject.userID = new string[count];
            int k = 0;
            for (int i = 0; i < UserIDdata.Length; i++)
            {
                if (UserIDdata[i] != "")
                {
                    objReqAddUserInThisProject.userID[k] = UserIDdata[i];
                    k++;
                }
            }

            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(ReqAddUserInThisProject));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, objReqAddUserInThisProject);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/addUserInThisProject", "POST", data);

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

    [WebMethod]
    public static List<Users> GetProjectAddInThisProject(string ProjectName)
    {
        /// string projectname = "";
        List<Users> lu = new List<Users>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var Data = JsonConvert.SerializeObject(ProjectName);
        var res = webClient.UploadString(URL + "/GetProjectUser", "POST", Data);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Reply));
        Reply objReply = (Reply)recv.ReadObject(ms);


        if (objReply.result)
        {
            if (objReply.DS.Tables[0].Rows.Count != 0)
            {
                foreach (DataRow item in objReply.DS.Tables[0].Rows)
                {
                    lu.Add(new Users { Name = item["user_name"].ToString(), Email = item["mail_id"].ToString(), idlogin = item["idlogin"].ToString() });
                }
            }
        }
        return lu;
    }



    [WebMethod]
    public static List<Users> getuserinthisproject(string ProjectName)
    {
        List<Users> lu = new List<Users>();
        try
        {
            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var Data = JsonConvert.SerializeObject(ProjectName);
            var res = webClient.UploadString(URL + "/GetUserInThisProjectAllreadyExist", "POST", Data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Reply));
            Reply objReply = (Reply)recv.ReadObject(ms);


            if (objReply.result)
            {
                if (objReply.DS.Tables[0].Rows.Count != 0)
                {
                    foreach (DataRow item in objReply.DS.Tables[0].Rows)
                    {
                        lu.Add(new Users { Name = item["user_name"].ToString(), Email = item["mail_id"].ToString(), idlogin = item["idlogin"].ToString() });
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }
        return lu;
    }
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ProjectReq editProject(string ProjectName)
    {
        ProjectReq listProjectReq = new ProjectReq();
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var data = JsonConvert.SerializeObject(ProjectName);

            var res = webClient.UploadString(URL + "/getEditProject", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);



            if (httpResponse.isValid)
            {
                var dt = httpResponse.DS.Tables[0];

                if (dt.Rows.Count > 0)
                {
                    listProjectReq.idProjets = dt.Rows[0][0].ToString();
                    listProjectReq.ProjectName = dt.Rows[0][2].ToString();
                    listProjectReq.projectType = dt.Rows[0][3].ToString();
                    listProjectReq.ProjectSubType = dt.Rows[0][4].ToString();
                    listProjectReq.ProjectDueDate = dt.Rows[0][5].ToString();
                    listProjectReq.ProjectManager = dt.Rows[0][6].ToString();
                    listProjectReq.ProjectSource = dt.Rows[0][9].ToString();
                    listProjectReq.ProjectTeamMember = dt.Rows[0][7].ToString();
                    listProjectReq.ProjectDescription = dt.Rows[0][8].ToString();

                }
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
        return listProjectReq;
    }



    protected void btnupdate_Click(object sender, EventArgs e)
    {

    }

    protected void btnUpdateProject_Click(object sender, EventArgs e)
    {
        try
        {
            EmpProject project = new EmpProject
            {
                Project_Name = txtEditProjectName.Text,
                Project_Type = ddlEditProjectType.SelectedValue.ToString(),
                project_subtype = ddlEditProjectSubType.SelectedValue.ToString(),
                Project_duedate = txtEditDueDate.Text,
                project_manager = ddlEditProjectManager.SelectedValue.ToString(),
                Description = txtEditDescription.Text,
                Source = txtEditProjectSource.Text,
                fk_idlogin = "1"
            };


            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(EmpProject));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, project);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/UpdateProject", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
            bool httpResponse = (bool)recv.ReadObject(ms);

            if (httpResponse)
            {
                allClear();
                string add = "Project Update Successfully ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
            }
            else
            {
                string error = "Project Update Failed ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + error + "');", true);
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    protected void allClear()
    {
        txtProjectName.Text = "";
        ddlptype.SelectedIndex = 0;
        ddlsubtype.SelectedIndex = 0;
        txtduedate.Text = "";
        ddlprojectmanager.SelectedIndex = 0;
        txtSource.Text = "";
        listmembers.ClearSelection();
        txtDescription.Text = "";


        txtEditProjectName.Text = "";
        txtEditDescription.Text = "";
        txtEditDueDate.Text = "";
        txtEditProjectSource.Text = "";

        txtTestingDescription.Text = "";
        ddlTestingLeader.SelectedIndex = 0;
        ddlExpenseTypeTesting.SelectedIndex = 0;
        txtExpenseDescriptionTesting.Text = "";
        txtExpenseAmountTesting.Text = "";

        txtSuspendReson.Text = "";
        ddlExpenseType.SelectedIndex = 0;
        txtAmount.Text = "";
        txtExpesneDescription.Text = "";

        txtFinalSubmisionDescription.Text = "";
        ddlFinalSubmisionExpenseType.SelectedIndex = 0;
        txtFinalSubmisionAmount.Text = "";
        txtFinalSubmisionExpenseDescription.Text = "";
    }

    protected void btnSuspend_Click(object sender, EventArgs e)
    {
        try
        {
            Suspend reqSuspend = new Suspend();
            reqSuspend.projectName = txtheadProjectName.Text;
            reqSuspend.Reson = txtSuspendReson.Text;
            reqSuspend.ExpeseType = ddlExpenseType.SelectedItem.Text;
            reqSuspend.ExpensesDescription = txtExpesneDescription.Text;
            reqSuspend.Amount = txtAmount.Text;
            reqSuspend.Type = "Suspend";

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
                GetActiveAndSuspendProjectCount();
                allClear();
                string add = "Project Suspend Successfully ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
            }
            else
            {
                string error = "Project Suspend Failed ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + error + "');", true);
            }
        }
        catch (Exception ex)
        {
        }
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
                    ddlTestingLeader.Items.Clear();
                    ddlTestingLeader.Items.Add(new ListItem { Value = "0", Text = "Select Testing Leader" });
                    for (int i = 0; i < objReply.DS.Tables[0].Rows.Count; i++)
                    {
                        ddlTestingLeader.Items.Add(new ListItem { Value = objReply.DS.Tables[0].Rows[i][0].ToString(), Text = objReply.DS.Tables[0].Rows[i][12].ToString() });

                    }


                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ReqAllExpense GetAllExpensesFinalSubmit(string projectname)
    {
        ReqAllExpense listReqAllExpense = new ReqAllExpense();
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var data = JsonConvert.SerializeObject(projectname);

            var res = webClient.UploadString(URL + "/GetAllExpenses", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);



            if (httpResponse.isValid)
            {
                var dt = httpResponse.DS.Tables[0];
                TimeSpan spWorkMin = new TimeSpan();
                string workHours = "";
                string totalexp = "";
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0][0].ToString() != "")
                    {
                        spWorkMin = TimeSpan.FromMinutes(Convert.ToDouble(dt.Rows[0][0].ToString()));
                        workHours = spWorkMin.ToString(@"hh\:mm");
                    }
                    else
                    {
                        workHours = "00:00";
                    }

                    if (dt.Rows[0][1].ToString() != ""
                        && dt.Rows[0][2].ToString() != ""
                        && dt.Rows[0][3].ToString() != ""
                         && dt.Rows[0][4].ToString() != ""
                          && dt.Rows[0][5].ToString() != "")
                    {
                        totalexp = Convert.ToString(Convert.ToDouble(dt.Rows[0][1].ToString())
                                                                       + Convert.ToDouble(dt.Rows[0][2].ToString())
                                                                       + Convert.ToDouble(dt.Rows[0][3].ToString())
                                                                       + Convert.ToDouble(dt.Rows[0][4].ToString())
                                                                       + Convert.ToDouble(dt.Rows[0][5].ToString())
                                                                       );
                        listReqAllExpense.MainHours = workHours;
                        listReqAllExpense.MainHoursExpense = dt.Rows[0][1].ToString();
                        listReqAllExpense.Hardware = dt.Rows[0][2].ToString();
                        listReqAllExpense.Software = dt.Rows[0][3].ToString();
                        listReqAllExpense.TourExpense = dt.Rows[0][4].ToString();
                        listReqAllExpense.Other = dt.Rows[0][5].ToString();
                        listReqAllExpense.totalExpense = totalexp;
                    }
                    else
                    {
                        totalexp =
                        listReqAllExpense.MainHours = workHours;
                        listReqAllExpense.MainHoursExpense = "0.00";
                        listReqAllExpense.Hardware = "0.00";
                        listReqAllExpense.Software = "0.00";
                        listReqAllExpense.TourExpense = "0.00";
                        listReqAllExpense.Other = "0.00";
                        listReqAllExpense.totalExpense = "0.00";
                    }


                }
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
        return listReqAllExpense;
    }

    protected void btnFinalSubmitt_Click(object sender, EventArgs e)
    {
        try
        {
            ReqProjectFinalSubmitt objReqProjectFinalSubmitt = new ReqProjectFinalSubmitt();

            objReqProjectFinalSubmitt.projectName = txtheadProjectName.Text;
            objReqProjectFinalSubmitt.ProjectConclusion = txtFinalSubmisionDescription.Text;
            objReqProjectFinalSubmitt.expenseType = ddlFinalSubmisionExpenseType.SelectedItem.Text;
            objReqProjectFinalSubmitt.expenseDescription = txtFinalSubmisionExpenseDescription.Text;
            objReqProjectFinalSubmitt.expenseAmount = txtFinalSubmisionAmount.Text;

            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(ReqProjectFinalSubmitt));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, objReqProjectFinalSubmitt);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/FinalProjectSubmit", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
            bool httpResponse = (bool)recv.ReadObject(ms);
            if (httpResponse)
            {
                GetActiveAndSuspendProjectCount();
                allClear();
                string add = "Project Submitt  Successfully ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
            }
            else
            {

                string error = "Project Submitt  Failed ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + error + "');", true);
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    protected void btnTestingSubmitt_Click(object sender, EventArgs e)
    {
        try
        {
            ReqTestingSubmitt objReqTestingSubmitt = new ReqTestingSubmitt();

           

            objReqTestingSubmitt.projectName = txtheadProjectName.Text;
            objReqTestingSubmitt.testingDescritption = txtTestingDescription.Text;
            objReqTestingSubmitt.testingLeader = ddlTestingLeader.SelectedValue;
            objReqTestingSubmitt.expenseType = ddlExpenseTypeTesting.SelectedItem.Text;
            objReqTestingSubmitt.expenseDescription = txtExpenseDescriptionTesting.Text;
            objReqTestingSubmitt.expenseAmount = txtExpenseAmountTesting.Text;

            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(ReqTestingSubmitt));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, objReqTestingSubmitt);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            //string data = JsonConvert.SerializeObject(employee);
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/SubmittTestingProject", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
            bool httpResponse = (bool)recv.ReadObject(ms);
            if (httpResponse)
            {
                allClear();
                string add = "Project Submitt For Testing Successfully ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
            }
            else
            {
                string error = "Project Submitt For Testing Failed ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + error + "');", true);
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }


}


public class ProjectReq
{
    public string ProjectName { get; set; }
    public string projectType { get; set; }
    public string ProjectSubType { get; set; }
    public string ProjectDueDate { get; set; }
    public string ProjectManager { get; set; }
    public string ProjectTeamMember { get; set; }
    public string ProjectSource { get; set; }
    public string ProjectDescription { get; set; }

    public string idProjets { get; set; }

}
public class Users
{

    public string Name
    {
        get;
        set;
    }
    public string Email
    {
        get;
        set;
    }
    public string idlogin
    {
        get;
        set;
    }
}
public class UserAllreadyIn
{
    public string UserName
    {
        get;
        set;
    }

}
public class ProjecNameWithUserCount
{
    public string idProjects { get; set; }
    public string ProjectName { get; set; }
    public string UserCount { get; set; }
    public string WorkingHour { get; set; }
    public string taskcount { get; set; }
    public string RecentActivity { get; set; }
}
public class ReqTestingSubmitt
{
    public string projectName { get; set; }
    public string testingLeader { get; set; }
    public string testingDescritption { get; set; }
    public string expenseType { get; set; }
    public string expenseAmount { get; set; }
    public string expenseDescription { get; set; }

    public byte[] attachmentBytes;
    public string task_attachment;
}
public class ReqProjectFinalSubmitt
{

    public string projectName { get; set; }

    public string ProjectConclusion { get; set; }

    public string expenseType { get; set; }

    public string expenseAmount { get; set; }

    public string expenseDescription { get; set; }
}
public class ReqAllExpense
{
    public string TourExpense { get; set; }
    public string Hardware { get; set; }
    public string Software { get; set; }
    public string Other { get; set; }
    public string MainHoursExpense { get; set; }
    public string MainHours { get; set; }
    public string totalExpense { get; set; }
}