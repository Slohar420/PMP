using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.InteropServices;
using System.Text;
namespace Reg
{
    public class RegEdit
    {
        public string path;

        [DllImport("kernel32")]
        private static extern long WritePrivateProfileString(string section, string key, string val, string filePath);
        [DllImport("kernel32")]
        private static extern int GetPrivateProfileString(string section, string key, string def, StringBuilder retVal, int size, string filePath);


        
        public RegEdit(string regPath)
        {
            path = regPath ;
        }

        public void RegWriteValue(string Section, string Key, string Value)
        {
            WritePrivateProfileString(Section, Key, Value, this.path);
        }

        public string RegReadValue(string Section, string Key)
        {
            StringBuilder temp = new StringBuilder(15000);
            int i = GetPrivateProfileString(Section, Key, "", temp, 15000, this.path);
            return temp.ToString();
        }
    }
}