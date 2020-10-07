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
using iTextSharp.text.pdf;
using iTextSharp.text;
using LipiRMS;
using System.Globalization;

public partial class Dashboard : System.Web.UI.Page
{
    public static string empid = "";
    public static string userType = "";
    public static string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    public static Reply objGlobalReply = new Reply();
    public DataTable dTable = new DataTable();
    public static DataTable dtPdetails = new DataTable();
    static byte[] filebytes = new byte[0];
    static string downloadFN = "";
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
                    bindProjects();
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

    private void bindProjects()
    {
        try
        {
            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var res = webClient.UploadString(URL + "/allProjects", "POST", "");


            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response httpResponse = (Response)recv.ReadObject(ms);

            if (httpResponse.isValid)
            {
                ddlprojects.Items.Clear();
                DataTable dt = httpResponse.DS.Tables[0];
                foreach (DataRow item in dt.Rows)
                {
                    ddlprojects.Items.Add(new System.Web.UI.WebControls.ListItem { Text = item[2].ToString().ToUpper(), Value = item[0].ToString() });
                }
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<File> GetFileData(string projectid)  //MARK:- it retrives all Task accordingly previews tasks
    {
        List<File> file = new List<File>();
        try
        {

            WebClient webClient = new WebClient();
            webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

            var data = JsonConvert.SerializeObject(projectid);            
            var res = webClient.UploadString(URL + "/getFileData", "POST", data);

            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
            DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Response));
            Response resp = (Response)recv.ReadObject(ms);

            if (resp.isValid)
            {
                if (resp.DS.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow item in resp.DS.Tables[0].Rows)
                    {
                        file.Add(new File
                        {
                            Task = item[0].ToString(),
                            file = item[1].ToString(),
                            uploadby = item[2].ToString(),
                            date_time = item[3].ToString(),
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
            throw;
        }
        return file;
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
                //Page.ClientScript.R
                
            }
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    public class File
    {
        public string Task { get; set; }
        public string file { get; set; }
        public string uploadby { get; set; }

        public string date_time { get; set; }
    }

}