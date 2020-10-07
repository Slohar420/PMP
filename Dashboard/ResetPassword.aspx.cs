using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;
using System.Data;
using System.Text;
using System.Net;
using System.IO;
using LipiRMS;
using Newtonsoft.Json;
public partial class Dashboard_Dashboard : System.Web.UI.Page
{
    
    //public static string Interval = System.Configuration.ConfigurationManager.AppSettings["TimerInterval"].ToString();
    public static DataSet objds;
    int CashConnected = 0, CashDisconnected = 0;
    int RecConnected = 0, RecDisconnected = 0;
    string add = "";
    Reply objGlobal = new Reply();
    static string UID = "";
    public static string URL = System.Configuration.ConfigurationManager.AppSettings["ServiceURL1"].ToString();
    //public static DataSet objds;

    public class UserDetailsCreation
    {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Role { get; set; }
        public string UserCreationDate { get; set; }
        public string Pwd { get; set; }
    }
    public struct UserDetails
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public string Location { get; set; }
        public string Role { get; set; }

    }

    public class ReqAddUser
    {

        public string UserName { get; set; }


        public string FirstName { get; set; }


        public string LastName { get; set; }
    }


    public class RespAddUser
    {

        public bool Result { get; set; }

        public string Error { get; set; }


        public string Password { get; set; }
    }
    public class Reply
    {
        public DataSet DS { get; set; }

        public bool res { get; set; }


        public string strError { get; set; }
    }
    public class UserDetailsReq
    {
        public string UserId { get; set; }
        public string Type { get; set; }
        public string Password { get; set; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //= Request.QueryString["Username"].ToString();
            //Response.Write(Name);
            if (Request.QueryString["Username"] != "" && Request.QueryString["Username"] != null)
            {
                string Name = Request.QueryString["Username"].ToString();
                UID = Request.QueryString["UID"].ToString();
                Name = Encoding.ASCII.GetString(Convert.FromBase64String(Name));
                UID = Encoding.ASCII.GetString(Convert.FromBase64String(UID));
                //lblUser.Text = Name;
                add = "Login for First Time.....Please Reset the Password";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Warning('" + add + "');", true);              
            }
            else
            {
                Response.Redirect("Default.aspx");
            }


        }

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtPwd.Text == "")
            {
                add = "Please Enter Password";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Warning('" + add + "');", true);               
                txtPwd.Focus();
                return;
            }
            else if(txtConfirmPwd.Text == "")
            {
                add = "Please Enter Confirm Password";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Warning('" + add + "');", true);
                txtConfirmPwd.Focus();
                return;
            }
            if (txtPwd.Text.ToString() != txtConfirmPwd.Text.ToString())
            {
                add = "Password and Confirm Password Is Diffrent Please Enter Same ! ";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Warning('" + add + "');", true);               
                txtConfirmPwd.Focus();
                return;
            }

            UserDetailsReq objUserDetailsReq = new UserDetailsReq();
            objUserDetailsReq.UserId = UID;
            objUserDetailsReq.Password = txtPwd.Text;
            objUserDetailsReq.Type = "ResetPassword";

            if (objds == null)
                objds = new DataSet();

            RespAddUser objRes = new RespAddUser();

            using (WebClient client = new WebClient())
            {
                client.Headers[HttpRequestHeader.ContentType] = "text/json";

                DataContractJsonSerializer objJsonSerSend = new DataContractJsonSerializer(typeof(UserDetailsReq));

                MemoryStream memStrToSend = new MemoryStream();

                objJsonSerSend.WriteObject(memStrToSend, objUserDetailsReq);

                string data = Encoding.Default.GetString(memStrToSend.ToArray());

                string result = client.UploadString(URL + "/UpdatePassword", "POST", data);

                string obj = JsonConvert.DeserializeObject<string>(result);

                if (obj == "true")
                {
                    var page1 = HttpContext.Current.CurrentHandler as Page;
                    add = "Password Reset Successfully ! ";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Success('" + add + "');", true);
                    Log.Write("Password Reset Successfully", "");
                }                
                else
                {
                    add = "Password Reset Failed ! ";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "Failed('" + add + "');", true);
                    Log.Write("Password Reset Failed", "");
                }
            }
        }
        catch (Exception excp)
        {
            Log.Write("Exception in Creat User :- " + excp, "");
        }
    }
   

}