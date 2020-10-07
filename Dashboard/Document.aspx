<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Document.aspx.cs" MasterPageFile="~/Dashboard/DSMaster.master" Inherits="Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="head" ContentPlaceHolderID="mainContent" runat="server">
    
    <div id="exportContent">
    <center><img src="images/logo1.png"/><br />
        <img src=" http://49.50.69.79/LIPI_PM_WEB/dashboard/images/logo1.png"/><br />
       
        <img src="https://res.cloudinary.com/dmsxwwfb5/image/upload/v1580916756/buy-me-min.png"/>
        <p>heello</p></center>
</div>
    <button onclick="Export2Doc('exportContent', 'word-content');">Export as .doc</button>
    
    <script>
        function Export2Doc(element,filename) {
            debugger;
            var preHtml = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'><head><meta charset='utf-8'><title>Export HTML To Doc</title></head><body>";
            var postHtml = "</body></html>";
            var html = preHtml+document.getElementById(element).innerHTML+postHtml;

            var blob = new Blob(['\ufeff', html], {
                type: 'application/msword'
            });
    
            // Specify link url
            var url = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(html);
    
            // Specify file name
            filename = filename?filename+'.doc':'document.doc';
    
            // Create download link element
            var downloadLink = document.createElement("a");

            document.body.appendChild(downloadLink);
    
            if(navigator.msSaveOrOpenBlob ){
                navigator.msSaveOrOpenBlob(blob, filename);
            }else{
                // Create a link to the file
                downloadLink.href = url;
        
                // Setting the file name
                downloadLink.download = filename;
        
                //triggering the function
                downloadLink.click();
            }
    
            document.body.removeChild(downloadLink);
        }
    </script>
</asp:Content>
