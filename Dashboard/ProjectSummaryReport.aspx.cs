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

public partial class Dashboard : System.Web.UI.Page
{
    public static string empid = "";
    public static string userType = "";
    public static string URL = ConfigurationManager.AppSettings["ServiceURL1"];
    public static Reply objGlobalReply = new Reply();
    public DataTable dTable = new DataTable();
    public static DataTable dtPdetails = new DataTable();
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
    [WebMethod(enableSession: true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<projectDetails> getProjectData(string data)
    {
        List<projectDetails> liprojectDetails = new List<projectDetails>();

        WebClient webClient = new WebClient();
        webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

        var value = JsonConvert.SerializeObject(data);
        var res = webClient.UploadString(URL + "/GetProjectDetails", "POST", value);

        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(res));
        DataContractJsonSerializer recv = new DataContractJsonSerializer(typeof(Reply));
        Reply objReply = (Reply)recv.ReadObject(ms);

        if (objReply.result)
        {
            objGlobalReply.DS = objReply.DS;
            int i = 0;
            TimeSpan spWorkMin = new TimeSpan();
            string workHours = "";
            decimal totalexp, MainHourExp, TourExp, OtherExp;
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
                    TourExp = String.Format("{0:0.00}", TourExp),
                    OtherExp = String.Format("{0:0.00}", OtherExp),
                    TotalExp = String.Format("{0:0.00}", totalexp),
                    LastActivity = item["lastactivity"].ToString(),
                });

                i++;
            }
        }
        return liprojectDetails;
    }
    protected void DataTableExcelOrPdf()
    {
        try
        {
            dTable.Columns.Add("S No");
            dTable.Columns.Add("Project Name");
            dTable.Columns.Add("Status");
            dTable.Columns.Add("User");
            dTable.Columns.Add("Task");
            dTable.Columns.Add("Main Hour");
            dTable.Columns.Add("Main Hour Exp.");
            dTable.Columns.Add("Tour Exp.");
            dTable.Columns.Add("Other Exp.");
            dTable.Columns.Add("Total Exp.");


            TimeSpan spWorkMin = new TimeSpan();
            string workHours = "";
            decimal totalexp, MainHourExp, TourExp, OtherExp;
            for (int i = 0; i < objGlobalReply.DS.Tables[0].Rows.Count; i++)
            {

                DataRow drow = dTable.NewRow();

                if (objGlobalReply.DS.Tables[0].Rows[i]["minute"].ToString() != "")
                {
                    spWorkMin = TimeSpan.FromMinutes(Convert.ToDouble(objGlobalReply.DS.Tables[0].Rows[i]["minute"].ToString()));
                    workHours = spWorkMin.ToString(@"hh\:mm");
                }
                else
                {
                    workHours = "00:00";
                }

                if (objGlobalReply.DS.Tables[0].Rows[i]["main hour expence"].ToString() != "" && objGlobalReply.DS.Tables[0].Rows[i]["tour Expense"].ToString() != ""
                    && objGlobalReply.DS.Tables[0].Rows[i]["expsense"].ToString() != "")
                {
                    totalexp = Convert.ToDecimal(Convert.ToDouble(objGlobalReply.DS.Tables[0].Rows[i]["main hour expence"].ToString())
                                                                   + Convert.ToDouble(objGlobalReply.DS.Tables[0].Rows[i]["tour Expense"].ToString())
                                                                   + Convert.ToDouble(objGlobalReply.DS.Tables[0].Rows[i]["expsense"].ToString()));


                    MainHourExp = Convert.ToDecimal(objGlobalReply.DS.Tables[0].Rows[i]["main hour expence"]);
                    TourExp = Convert.ToDecimal(objGlobalReply.DS.Tables[0].Rows[i]["tour Expense"]);
                    OtherExp = Convert.ToDecimal(objGlobalReply.DS.Tables[0].Rows[i]["expsense"]);
                }
                else
                {
                    MainHourExp = 0;
                    TourExp = 0;
                    OtherExp = 0;
                    totalexp = 0;
                }
                drow["S No"] = i + 1;
                drow["Project Name"] = objGlobalReply.DS.Tables[0].Rows[i]["project_name"].ToString();
                drow["Status"] = objGlobalReply.DS.Tables[0].Rows[i]["status"].ToString();
                drow["User"] = objGlobalReply.DS.Tables[0].Rows[i]["UserCount"].ToString();
                drow["Task"] = objGlobalReply.DS.Tables[0].Rows[i]["task"].ToString();
                drow["Main Hour"] = workHours;
                drow["Main Hour Exp."] = String.Format("{0:0.00}", MainHourExp);
                drow["Tour Exp."] = String.Format("{0:0.00}", TourExp);
                drow["Other Exp."] = String.Format("{0:0.00}", OtherExp);
                drow["Total Exp."] = String.Format("{0:0.00}", totalexp);

                dTable.Rows.Add(drow);
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnPdfExport_Click(object sender, EventArgs e)
    {
        try
        {
            string Heading = "", filename = "" ;
           
            Heading = "PROJECT SUMMARY REPORT GENERATED ON";
            filename = "Project_Summary_Report_";
            DataTableExcelOrPdf();

            Response.ContentType = "application/pdf";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            MemoryStream memoryStream = new MemoryStream();

            //creating pdf document      
            iTextSharp.text.Document pdfDoc = new Document(PageSize.A4.Rotate(), 5f, 5f, 10f, 5f);
            // getting writer for pdf
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

            PdfWriter.GetInstance(pdfDoc, memoryStream);

            Paragraph para = new Paragraph();
            Paragraph para1 = new Paragraph();
            Paragraph para2 = new Paragraph();
            para.Alignment = 1;
            para.Font = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 30f, BaseColor.BLACK);

            para.SpacingBefore = 50;
            para.SpacingAfter = 50;
            para.Add("Project Management System");



            PdfPTable table = new PdfPTable(dTable.Columns.Count);  // -2 new
            //spacing before and after table
            table.TotalWidth = 823f;
            table.LockedWidth = true;
            table.SpacingBefore = 5f;
            table.SpacingAfter = 5f;
            table.HorizontalAlignment = 0;


            PdfPCell cell = new PdfPCell(new Phrase());
            int columnscount = dTable.Columns.Count;

            string login_ini_path = HttpRuntime.AppDomainAppPath + "Configuration\\machines_type.ini";

            string bank = null;

            string header1 = null;
            string header2 = null;

            header1 =  Heading +" "+ DateTime.Now.ToString("dd MMM yyyy, HH:mm tt");
            header2 = "REPORT";
            Response.AddHeader("content-disposition", "attachment;filename="+filename+"" + DateTime.Now.ToString("dd-MM-yy_HH:mm") + ".pdf");

            table.AddCell(GetCell(header1, columnscount, 1));
            table.AddCell(GetCell(header2, columnscount, 2));


            for (int j = 1; j <= columnscount; j++)
            {
                table.AddCell(GetCell(dTable.Columns[j - 1].ColumnName.ToString(), 3));  //
            }


            foreach (DataRow row in dTable.Rows)
            {
                for (int i = 0; i < dTable.Columns.Count; i++)
                {
                    table.AddCell(GetCell(row[i].ToString(), 4));
                }

            }
            string imageLogo = Server.MapPath(".") + "\\images\\logo1.png";
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imageLogo);
            logo.SetAbsolutePosition(pdfDoc.Left, pdfDoc.Top - 40);
            logo.ScaleToFit(45f, 45f);
            logo.SpacingBefore = 10f;
            logo.SpacingAfter = 1f;
            logo.Alignment = Element.ALIGN_TOP;

            pdfDoc.Open();
            pdfDoc.Add(para);

            pdfDoc.Add(logo);
            pdfDoc.Add(table);


            pdfDoc.Close();
            byte[] bytes = memoryStream.ToArray();
            memoryStream.Close();
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
    private PdfPCell GetCell(string text, int i)
    {
        return GetCell(text, 1, i);
    }
    private PdfPCell GetCell(string text, int colSpan, int i)
    {
        var whitefont = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14, BaseColor.BLACK);//"Times New Roman"
        var blackfont = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14, BaseColor.BLACK);//"Times New Roman"

        if (i < 3)
        {
            PdfPCell cell = new PdfPCell(new Phrase(text, whitefont));
            cell.HorizontalAlignment = 1;
            //cell.Rowspan = rowSpan;
            cell.Colspan = colSpan;
            //Header colour
            if (i == 1 || i == 2)
            {
                cell.BackgroundColor = BaseColor.LIGHT_GRAY;
            }
            //column name colour
            if (i == 3)
                cell.BackgroundColor = BaseColor.CYAN;
            return cell;
        }
        else if (i == 3)
        {
            PdfPCell cell = new PdfPCell(new Phrase(text, blackfont));
            cell.HorizontalAlignment = 1;
            //cell.Rowspan = rowSpan;
            cell.Colspan = colSpan;
            //Header colour
            if (i == 1 || i == 2)
            {
                cell.BackgroundColor = BaseColor.BLUE;
            }
            //column name colour
            if (i == 3)
                cell.BackgroundColor = BaseColor.CYAN;
            return cell;
        }
        else
        {
            PdfPCell cell = new PdfPCell(new Phrase(text));
            cell.HorizontalAlignment = 1;
            //cell.Rowspan = rowSpan;
            cell.Colspan = colSpan;
            //Header colour
            if (i == 1 || i == 2)
            {
                cell.BackgroundColor = BaseColor.BLUE;
            }
            //column name colour
            if (i == 3)
                cell.BackgroundColor = BaseColor.CYAN;
            string value = text.ToLower();
            if (value == "disconnected" || value.ToLower().Contains("jam") || value.ToLower().Contains("out") || value.ToLower().Contains("printererror") || value == "faulty")
                cell.BackgroundColor = BaseColor.RED;

            if (value.ToLower().Contains("low"))
                cell.BackgroundColor = BaseColor.YELLOW;
            return cell;
        }
    }
    protected void btnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            string Heading = "", filename = "";
        

            Heading = "PROJECT SUMMARY REPORT GENERATED ON";
            filename = "Project_Summary_Report_";
            DataTableExcelOrPdf();
            gvExportExceldata.DataSource = dTable;
            gvExportExceldata.DataBind();

            int count = gvExportExceldata.HeaderRow.Cells.Count;
            StringBuilder strHTMLBuilder = new StringBuilder();
            strHTMLBuilder.Append("<html >");
            strHTMLBuilder.Append("<head>");
            strHTMLBuilder.Append("</head>");
            strHTMLBuilder.Append("<body>");
            strHTMLBuilder.Append("<table border='1px' cellpadding='1' cellspacing='1' bgcolor='white' style='font-family:Times New Roman; font-size:Large'>");
            strHTMLBuilder.Append("<tr><td colspan='" + count + "' style='text-align:center;background-color: aqua;' > PROJECT MANAGEMENT SYSTEM </td></tr>");
            strHTMLBuilder.Append("<tr><td colspan='" + count + "' style='text-align:center;background-color: aqua;' > " + Heading +" " + DateTime.Now.ToString("dd-MM-yy_HH:mm") + " </td></tr>");
            strHTMLBuilder.Append("<tr >");

            foreach (GridViewRow myColumn in gvExportExceldata.Rows)
            {
                for (int i = 0; i < myColumn.Cells.Count; i++)
                {
                    strHTMLBuilder.Append("<td style='text-align:center; background-color: #367FA9; font-size:Large; color:white;  font-weight: bold;  '>");
                    strHTMLBuilder.Append(gvExportExceldata.HeaderRow.Cells[i].Text);
                    strHTMLBuilder.Append("</td>");
                }
                break;
            }
            strHTMLBuilder.Append("</tr>");
            foreach (GridViewRow myRow in gvExportExceldata.Rows)
            {
                strHTMLBuilder.Append("<tr >");
                for (int j = 0; j < myRow.Cells.Count; j++)
                {
                    if (myRow.Cells[j].Text.ToLower().Contains("out"))
                    {
                        strHTMLBuilder.Append("<td style='text-align:center; font-size:medium ; background-color:red' >");
                        strHTMLBuilder.Append(myRow.Cells[j].Text);
                        strHTMLBuilder.Append("</td>");
                    }
                    else if (myRow.Cells[j].Text.ToLower().Contains("low"))
                    {
                        strHTMLBuilder.Append("<td style='text-align:center; font-size:medium ; background-color:yellow' >");
                        strHTMLBuilder.Append(myRow.Cells[j].Text);
                        strHTMLBuilder.Append("</td>");
                    }
                    else
                    {
                        strHTMLBuilder.Append("<td style='text-align:center; font-size:medium' >");
                        strHTMLBuilder.Append(myRow.Cells[j].Text);
                        strHTMLBuilder.Append("</td>");
                    }

                }
                strHTMLBuilder.Append("</tr>");
            }
            //Close tags.  
            strHTMLBuilder.Append("</table>");
            strHTMLBuilder.Append("</body>");
            strHTMLBuilder.Append("</html>");
            string Htmltext = strHTMLBuilder.ToString();
            Response.AddHeader("content-disposition", "attachment;filename="+filename+".xls");
            Response.ContentType = "File/Data.xls";
            Response.Write(Htmltext);
            Response.End();
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }


   
}