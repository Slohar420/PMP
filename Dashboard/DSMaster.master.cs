using System;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Configuration;
using Newtonsoft.Json;
using System.IO;
using LayoutStructure;

public partial class Dashboard_DSMaster : System.Web.UI.MasterPage
{
    //public static string URL = System.Configuration.ConfigurationManager.AppSettings["ServiceURL1"].ToString();
    //public const string AntiXsrfTokenKey = "__AntiXsrfToken";
    //public const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    //public string _antiXsrfTokenValue;
    //string healthpanel = System.Configuration.ConfigurationManager.AppSettings["HealthPanel"].ToString();
    //string transactionpanel = System.Configuration.ConfigurationManager.AppSettings["TransactionPanel"].ToString();
    //string adminpanel1 = System.Configuration.ConfigurationManager.AppSettings["AdminPanel"].ToString();
    //string calllogpanel = System.Configuration.ConfigurationManager.AppSettings["CallLogPanel"].ToString();
    //string user = System.Configuration.ConfigurationManager.AppSettings["UserManagement"].ToString();
    //string dashboard = System.Configuration.ConfigurationManager.AppSettings["Dashboard"].ToString();
    //static string UserName = "";
    //static string TerminalId = "";   
    public  string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    public static string userid = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null && Session["mail_id"] != null && Session["loginid"] != null)
                {
                    lblUSName.Text = Session["Username"].ToString();
                    username.InnerText = Session["Username"].ToString();
                    userrole.Value = Session["usertype"].ToString();
                    userid = Session["loginid"].ToString();
                }
                else {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }  
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
           
        }
    }

   

    //private void bindProjects() {
    //    try
    //    {
    //        WebClient webClient = new WebClient();
    //        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

    //        var res = webClient.UploadString(URL + "/allProjects", "POST", "");


    //        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
    //        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
    //        Response httpResponse = (Response)recv.ReadObject(ms);

    //        if (httpResponse.isValid)
    //        {
    //            ddlprojects.Items.Clear();
    //            DataTable dt = httpResponse.DS.Tables[0];
    //            foreach (DataRow item in dt.Rows)
    //            {
    //                ddlprojects.Items.Add(new ListItem { Text =item[2].ToString() ,Value=item[0].ToString() });
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        throw;
    //    }
    //}


    //protected void ddlprojects_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //       Session["selectedvalue"]= ddlprojects.SelectedItem.Value;
    //    }
    //    catch (Exception ex)
    //    {

    //        throw;
    //    }
    //}

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
        try
        {
            //var Jsonstring = JsonConvert.SerializeObject(userid);
            //WebClient client = new WebClient();
            //client.Headers[HttpRequestHeader.ContentType] = "Application/json";


            //string result = client.UploadString(URL + "/logout", "POST", Jsonstring);
            //System.IO.MemoryStream ms = new System.IO.MemoryStream(Encoding.UTF8.GetBytes(result));
            //DataContractJsonSerializer deserializer = new DataContractJsonSerializer(typeof(bool));

            //bool obj = (bool)deserializer.ReadObject(ms);
            //if (obj)
            //{
            //   
            //}
            
        }
        catch (Exception ex)
        {

            throw;
        }
    }
}



public class ReqLogout
{
  
    public string UserName { get; set; }

   
    public string TerminalID { get; set; }
}


public class RespLogout
{
  
    public bool Result { get; set; }

    
    public string Error { get; set; }
}