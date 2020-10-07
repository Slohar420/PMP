using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LayoutStructure;
using Newtonsoft.Json;
using LipiRMS;

public partial class _Default : System.Web.UI.Page
{
    string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // Response.Redirect("~/Dashboard/Dashboard.aspx", true);
        try
        {
            Reply response = new Reply();
            LoginCred objUserDetailsReq = new LoginCred();

            objUserDetailsReq.username = txtUserName.Text;


            objUserDetailsReq.password = txtPwd.Text;

            var Jsonstring = JsonConvert.SerializeObject(objUserDetailsReq);
            WebClient client = new WebClient();
            client.Headers[HttpRequestHeader.ContentType] = "Application/json";


            string result = client.UploadString(URL + "/checkLogin", "POST", Jsonstring);
            System.IO.MemoryStream ms = new System.IO.MemoryStream(Encoding.UTF8.GetBytes(result));
            DataContractJsonSerializer deserializer = new DataContractJsonSerializer(typeof(Reply));
            Reply obj = (Reply)deserializer.ReadObject(ms);

            if (obj.result)
            {
                    Session["loginid"] = obj.DS.Tables[0].Rows[0]["idlogin"].ToString();
                    Session["mail_id"] = obj.DS.Tables[0].Rows[0]["mail_id"].ToString();
                    Session["Username"] = obj.DS.Tables[0].Rows[0]["user_name"].ToString();
                    Session["usertype"] = obj.DS.Tables[0].Rows[0]["user_role"].ToString();
                string Uname = Session["Username"].ToString();
                string uid = Session["loginid"].ToString();
                if (obj.DS.Tables[0].Rows[0]["password"].ToString().ToLower().Contains("lipi@123"))
                {
                    Response.Redirect("Dashboard/updatepassword.aspx?Username=" + Convert.ToBase64String(Encoding.ASCII.GetBytes(Uname)) + "&UID=" + Convert.ToBase64String(Encoding.ASCII.GetBytes(uid)), false);
                }
                else {
                    Response.Redirect("~/Dashboard/Dashboard.aspx", true);
                }             

            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "wrongUserNameAndPwd();", true);
            }
        }
        catch (Exception ex)
        {
            Log.Write("Exception in Login Error :- " + ex.ToString(), "");
        }
    }       

}

