using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for LayoutStructure
/// </summary>
/// 
namespace LayoutStructure
{
    public class EmpProject
    {

        public string Project_Name { get; set; }
        public string fk_idlogin { get; set; }
        public string project_subtype { get; set; }
        public string Project_duedate { get; set; }
        public string project_manager { get; set; }
        public string[] TeamID { get; set; }
        public string Project_Type { get; set; }
        public string Description { get; set; }
        public string Source { get; set; }
    }
    public class LayoutStructure
    {
        public int height;
        public int width;
        public int xPos;
        public int yPos;
        public string Desc;
        public string name;
        public string type;

    }
    public class TickerStructure
    {
        public string TickDesc;
        public string TickFunc;
        public string divId;
        public string labID;
    }
    public class EmployeeReq
    {

        public string FullName { get; set; }
        public string EmployeeCode { get; set; }
        public string Desgination { get; set; }

        public string JoningDate { get; set; }
        public string Skills { get; set; }

        public string Email { get; set; }
        public string Salary { get; set; }

        public string Role { get; set; }

        public string DepartmetnID { get; set; }

        public string Experince { get; set; }

        public string Password { get; set; }

        public string UserType { get; set; }
    }

    public class EmployeeUpdateReq
    {

        public string FullName { get; set; }
        public string id { get; set; }
        public string EmployeeCode { get; set; }
        public string Desgination { get; set; }

        public string JoningDate { get; set; }
        public string Skills { get; set; }

        public string Email { get; set; }
        public string Salary { get; set; }

        public string Role { get; set; }

        public string DepartmetnID { get; set; }

        public string Experince { get; set; }

        public string Password { get; set; }
    }
    public class Response
    {

        public DataSet DS { get; set; }

        public string Error { get; set; }
        public bool isValid { get; set; }
        public bool FirstTimeLogin { get; set; }
    }

    public class LoginCred 
    {
        public string username { get; set; }
        public string password { get; set; }

    }
    public class UserDetail
    {
        public string id { get; set; }
        public string name { get; set; }
        public string userrole { get; set; }
        public string usershortname { get; set; }
        public string email { get; set; }
        public string lastactivity { get; set; }
        public string projects { get; set; }
    }
    public class Reply
    {
        public bool result { get; set; }
        public DataSet DS { get; set; }

        public string Error { get; set; }

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

    public class RespAddService
    {
        public bool Result { get; set; }
        public string Error { get; set; }
    }
    public class ReqAddTerminal
    {
        public string TerminalID { get; set; }
        public string Type { get; set; }
    }
    public class RespAddTerminal
    {
        public bool Result { get; set; }
        public string Error { get; set; }
    }
    public class RespIssueTerminalsList
    {
        public bool Result { get; set; }

        public string Error { get; set; }

        public Terminal[] Terminals { get; set; }
    }
    public class Terminal
    {
        public string TerminalName { get; set; }

        public int TerminalID { get; set; }
    }
    public class ReqIssueToken
    {
        public string TerminalID { get; set; }
        public string ServiceType { get; set; }


    }
    public class RespIssueToken
    {
        public bool Result { get; set; }
        public string Error { get; set; }
        public string TokenNo { get; set; }
    }
    public class ReqFetchNextToken
    {
        public string ServiceType { get; set; }
        public string TerminalID { get; set; }
        public string UserName { get; set; }
        public bool IsNeedToSkip { get; set; }
    }
    public class RespFetchNextToken
    {
        public bool Result { get; set; }
        public string Error { get; set; }
        public string TokenNo { get; set; }
    }
    public class ReqUpdateTokenStatus
    {
        public string TokenNo { get; set; }
        public string Status { get; set; }
    }
    public class RespUpdateTokenStatus
    {
        public bool Result { get; set; }
        public string Error { get; set; }
    }
    public class ReqServiceWithTokenStatus
    {
        public string ServiceId { get; set; }
        public string TerminalId { get; set; }

    }
    public class ReqChartData
    {
        public string ToDT { get; set; }

        public string FromDT { get; set; }
    }
    public class AddProjectUserReq
    {
        public string ProjectName { get; set; }

        public string TeamMemberId { get; set; }
    }
    public class ReqAddUserInThisProject
    {
        public string projectName { get; set; }
        public string[] userID { get; set; }
        public string type { get; set; }
    }
    public class Tasks
    {

        public string tid;

        public string task_descriptions;

        public string assigned_to;

        public string task_name;

        public string duedate;

        public string fk_idlogin;

        public string email_status;

        public string start_date;

        public string task_status;

        public string projectid;

        public string task_type;

        public string task_attachment;

        public string task_priority;
        public byte[] attachmentBytes;
    }

    public class Suspend
    {
        public string projectName { get; set; }

        public string Reson { get; set; }

        public string ExpeseType { get; set; }

        public string Amount { get; set; }

        public string duedate { get; set; }

        public string ExpensesDescription { get; set; }
        public string Type { get; set; }
    }
    public class TaskType
    {
        public string Inprocess { get; set; }
        public string Active { get; set; }
        public string complete { get; set; }
    }

    public class AllTaskTpe
    {
        public string InprocessTask { get; set; }
        public string ActiveTask { get; set; }
        public string completeTask { get; set; }
    }

    public class TaskStatusUser
    {
        public string CompleteTask { get; set; }
        public string ActiveTask { get; set; }
        public string InProcessTask { get; set; }
        public string PauseTask { get; set; }
        public string SuspendTask { get; set; }
    }
    public class WorkOverview
    {
        public string TaskName { get; set; }
        public string Minute { get; set; }
    }
    public class RecentActivity
    {
        public string datetime { get; set; }
        public string AssginedTo { get; set; }
    }
    public class projectDetails
    {
        public string SNo { get; set; }
        public string Pname { get; set; }
        public string Status { get; set; }

        public string uCount { get; set; }

        public string tCount { get; set; }

        public string MainHour { get; set; }

        public string MainHourExp { get; set; }

        public string TourExp { get; set; }

        public string OtherExp { get; set; }

        public string LastActivity { get; set; }

        public string TotalExp { get; set; }

        public string Task { get; set; }
        public string overdue { get; set; }

        public string employee { get; set; }

        public string desgination { get; set; }

        public string empoloyeeType { get; set; }

        public string ProjectStatus { get; set; }

    }

    public class taskDetails
    {
        public string SNo { get; set; }
        public string pname { get; set; }
        public string totalTask { get; set; }

        public string completeTask { get; set; }

        public string InprocessTask { get; set; }

        public string ActiveTask { get; set; }

        public string SuspendTask { get; set; }
        public string PauseTask { get; set; }

        public string totalMainHour { get; set; }

    }
}