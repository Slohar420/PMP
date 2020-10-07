using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using LayoutStructure;
using System.Data;

public partial class UserOrange : System.Web.UI.Page
{
    public static string URL = System.Configuration.ConfigurationManager.AppSettings["ServiceURL1"].ToString();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetDepartMentId();
            getUserCount();
        }

    }

    //Get DepartMentId and load in Dropdown list
    protected void GetDepartMentId()
    {
        try
        {
            Reply objReply = new Reply();
            WebClient client = new WebClient();
            client.Headers[HttpRequestHeader.ContentType] = "text/json";

            string result = client.UploadString(URL + "/GetDepartmetnId", "POST", "");

            MemoryStream memstrToReceive = new MemoryStream(Encoding.UTF8.GetBytes(result));

            DataContractJsonSerializer objJsonSerRecv = new DataContractJsonSerializer(typeof(Reply));

            objReply = (Reply)objJsonSerRecv.ReadObject(memstrToReceive);

            if (objReply.result)
            {
                //ddlDepartment.DataValueField = objReply.DS.Tables[0].Columns["iddepartments"].ToString();
                //ddlDepartment.DataTextField = objReply.DS.Tables[0].Columns["department_name"].ToString();
                //ddlDepartment.DataSource = objReply.DS;
                ddlDepartment.Items.Clear();
                //ddlDepartment.DataBind();                
                ddlDepartment.Items.Add(new ListItem { Value = "0", Text = "Select"});
                for (int i = 0; i < objReply.DS.Tables[0].Rows.Count; i++)
                {
                    ddlDepartment.Items.Add(new ListItem { Value = objReply.DS.Tables[0].Rows[i]["iddepartments"].ToString(), Text = objReply.DS.Tables[0].Rows[i]["department_name"].ToString() });
                }
            }
            else
            {
                ddlDepartment.DataValueField = "";
                ddlDepartment.DataValueField = "";
                ddlDepartment.DataSource = "";
                ddlDepartment.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<UserDetail> getUsers()
    {

        List<UserDetail> list = new List<UserDetail>();
        List<UserDetail> filteredlist = new List<UserDetail>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var res = webClient.UploadString(URL+ "/allUsers", "POST", "");


        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response httpResponse = (Response)recv.ReadObject(ms);



        if (httpResponse.isValid)
        {
            string projects = "";
            string shortname = "";

            foreach (DataRow item in httpResponse.DS.Tables[0].Rows)
            {
                projects = "";
                UserDetail user = new UserDetail();
                for (int i = 0; i < httpResponse.DS.Tables[0].Rows.Count; i++)
                {
                    if (item["idlogin"].ToString() == httpResponse.DS.Tables[0].Rows[i]["idlogin"].ToString())
                    {
                        if (httpResponse.DS.Tables[0].Rows[i]["project_name"].ToString() != "")
                          
                                projects += httpResponse.DS.Tables[0].Rows[i]["project_name"].ToString() + " , ";

                    }

                }


                shortname = "";
                if (item["user_name"].ToString() != "" && item["user_name"].ToString().Trim().Contains(" "))
                {

                    //shortname = item["user_name"].ToString().Split(' ')[0].Substring(0, 1) + item["user_name"].ToString().Split(' ')[1].Substring(0, 1);
                    shortname = item["user_name"].ToString().Trim().Split(' ')[0].ToString();
                }
                else
                {
                    shortname = item["user_name"].ToString();
                }
                if (projects.Length > 30) {
                   projects= projects.Remove(30)+"....";
                }

                user.email = item[2].ToString();
                user.usershortname = shortname;
                user.id = item[0].ToString();
                user.name = item[1].ToString();
                user.projects = projects;
                user.userrole = item["user_role"].ToString();

                list.Add(user);

               


            }



            foreach (var item in list)
            {
                bool found = false;
                foreach (UserDetail item1 in filteredlist)
                {
                    if (item.id == item1.id)
                    {
                        found = true;
                    }
                }

                if (!found)
                {
                    filteredlist.Add(item);
                }
            }
        }

        return filteredlist;
    }


    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EmployeeReq editUser(string id)
    {
        EmployeeReq listEmployee = new EmployeeReq();
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var data = JsonConvert.SerializeObject(id);

            var res = webClient.UploadString(URL+"/getUser", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);



            if (httpResponse.isValid)
            {
                var dt = httpResponse.DS.Tables[0];

                if (dt.Rows.Count > 0)
                {
                    listEmployee.FullName = dt.Rows[0][1].ToString();
                    listEmployee.EmployeeCode = dt.Rows[0][4].ToString();
                    listEmployee.Email = dt.Rows[0][2].ToString();
                    listEmployee.Desgination = dt.Rows[0][5].ToString();
                    listEmployee.Experince = dt.Rows[0][7].ToString();
                    listEmployee.Skills = dt.Rows[0][8].ToString();
                    listEmployee.Salary = dt.Rows[0][9].ToString();
                    listEmployee.JoningDate = dt.Rows[0][6].ToString();
                    listEmployee.Role = dt.Rows[0][10].ToString();
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }



        return listEmployee;
    }

    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string deleteUser(string id)
    {
        string returnedParam = "";
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var data = JsonConvert.SerializeObject(id);

            var res = webClient.UploadString(URL+ "/deleteUser", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(bool));
            bool httpResponse = (bool)recv.ReadObject(ms);



            if (httpResponse)
            {
                returnedParam = "User Deleted Succesfully";
            }
            else
            {
                returnedParam = "Unable To Deleted User!";
            }
        }
        catch (Exception ex)
        {

            throw;
        }



        return returnedParam;
    }



    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string msg = "";
        try
        {            
           
                EmployeeReq objEmployeeReq = new EmployeeReq();

                objEmployeeReq.FullName = txtFirstName.Text + " " + txtLastName.Text;
                objEmployeeReq.EmployeeCode = txtEmployeecode.Text;
                objEmployeeReq.Desgination = txtDesgination.Text;
                objEmployeeReq.JoningDate = txtDOJ.Text;
                objEmployeeReq.Experince = txtExperience.Text;
                objEmployeeReq.Skills = txtSkills.Text;
                objEmployeeReq.Salary = txtSallery.Text;
                objEmployeeReq.Email = txtMailId.Text;
                if(ddlType.SelectedIndex == 2)
                   objEmployeeReq.Role = "admintesting";
                else
                   objEmployeeReq.Role = ddlType.SelectedItem.Text;
            objEmployeeReq.UserType = ddlUserType.SelectedItem.Text;
                objEmployeeReq.Password = "lipi@123";
                if (txtDepartment.Text != "")
                    objEmployeeReq.DepartmetnID = txtDepartment.Text;
                else
                    objEmployeeReq.DepartmetnID = ddlDepartment.SelectedItem.Value;

                WebClient client = new WebClient();
                client.Headers[HttpRequestHeader.ContentType] = "text/json";

                string data = JsonConvert.SerializeObject(objEmployeeReq);
                string result = client.UploadString(URL + "/addEmployee", "POST", data);

                Response response = JsonConvert.DeserializeObject<Response>(result);

                if (response.isValid)
                {
                    clearAll();
                    string add = "User Add Successfully !";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "OnError('" + response.Error + "');", true);
                }
            
        }
        catch (Exception ex)
        {
        }
    }
    protected void clearAll()
    {
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtDOJ.Text = "";
        txtSallery.Text = "";
        txtEmployeecode.Text = "";
        txtDepartment.Text = "";
        txtExperience.Text = "";
        txtSkills.Text = "";
        txtMailId.Text = "";
        ddlType.SelectedIndex = 0;
        ddlDepartment.SelectedIndex = 0;
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        try
        {
            EmployeeUpdateReq objEmployeeReq = new EmployeeUpdateReq();

            objEmployeeReq.FullName = txtFirstName.Text + " " + txtLastName.Text;
            objEmployeeReq.id = hiddenID.Value;
            objEmployeeReq.EmployeeCode = txtEmployeecode.Text;
            objEmployeeReq.Desgination = txtDesgination.Text;
            objEmployeeReq.JoningDate = txtDOJ.Text;
            objEmployeeReq.Experince = txtExperience.Text;
            objEmployeeReq.Skills = txtSkills.Text;
            objEmployeeReq.Salary = txtSallery.Text;
            objEmployeeReq.Email = txtMailId.Text;
            objEmployeeReq.Role = ddlType.SelectedItem.Text;
            objEmployeeReq.Password = "lipi@123";
            if (txtDepartment.Text != "")
                objEmployeeReq.DepartmetnID = txtDepartment.Text;
            else
                objEmployeeReq.DepartmetnID = ddlDepartment.SelectedItem.Value;

            WebClient client = new WebClient();
            client.Headers[HttpRequestHeader.ContentType] = "text/json";

            DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(EmployeeUpdateReq));
            MemoryStream memStrToSend = new MemoryStream();
            objJsonSerSend.WriteObject(memStrToSend, objEmployeeReq);
            string data = Encoding.Default.GetString(memStrToSend.ToArray());

            string result = client.UploadString(URL + "/updateUser", "POST", data);

            bool response = JsonConvert.DeserializeObject<bool>(result);

            if (response)
            {
                clearAll();
                string add = "User Updated Successfully ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "InCorrectUserName();", true);
            }

        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void getUserCount()
    {
        WebClient client = new WebClient();
        client.Headers[HttpRequestHeader.ContentType] = "text/json";
        

        string result = client.UploadString(URL + "/GetUserCount", "POST", "");

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(result));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
        Response httpResponse = (Response)recv.ReadObject(ms);

        if (httpResponse.isValid)
        {
            lblUserCount.Text = httpResponse.DS.Tables[0].Rows[0]["user"].ToString();
        }
        else
            lblUserCount.Text = "0";
    }
}