using SLMD.SoftwareLicensing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace LipiRMS
{
    #region Class SoftwareKeyGen
    public class SoftwareKeyGen : SoftwareLock
    {
        new public String Reference
        {
            get { return _CustRef; }
            set
            {
                if (value.Length == 16)
                {
                    _CustRef = value;
                }
                //else
                //{
                //    MessageBox.Show("Reference string not proper", "Exception", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                //}
            }
        }

        new public String SerialKey
        {
            get
            {
                HashAlgorithm Hash;
                Byte[] HashBytes;
                //UnicodeEncoding UNIEncoding=new UnicodeEncoding();
                String temp;
                //_HashAlgorithm = HashAlgorithms.MD5;

                switch (_HashAlgorithm)
                {
                    case HashAlgorithms.MD5: Hash = new MD5CryptoServiceProvider(); break;
                    case HashAlgorithms.SHA1: Hash = new SHA1CryptoServiceProvider(); break;
                    case HashAlgorithms.SHA256: Hash = new SHA256Managed(); break;
                    case HashAlgorithms.SHA384: Hash = new SHA384Managed(); break;
                    case HashAlgorithms.SHA512: Hash = new SHA512Managed(); break;
                    default: Hash = new MD5CryptoServiceProvider(); break;
                }

                _CustRef = _CustRef.ToUpper();

                temp = _CustRef + _AppName + _Password;
                HashBytes = Hash.ComputeHash(System.Text.Encoding.ASCII.GetBytes(temp));

                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < HashBytes.Length; i++)
                {
                    sb.Append(HashBytes[i].ToString("X2"));
                }

                //_SerialKey = Convert.ToBase64String(HashBytes);
                _SerialKey = sb.ToString();
                if (_SerialKey.Trim().Length > 20)
                    _SerialKey = _SerialKey.Substring(0, 20);

                return _SerialKey.ToUpper();
            }
        }

        public String FormatSerialKey(String seperator)
        {
            string strKey = this.SerialKey;
            return strKey.Substring(0, 5) + seperator + strKey.Substring(5, 5) + seperator + strKey.Substring(10, 5) + seperator + strKey.Substring(15, 5);
        }
    }
    #endregion
}