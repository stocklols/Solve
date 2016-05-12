/// Program.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectToAPI
{
    class Program
    {
        static void Main(string[] args)
        {
            var ApiConnection = new API();
            ApiConnection.Key = "NEWKEY";
            ApiConnection.User = "USER123";
            ApiConnection.Url = "https://www.mydogs.com/api?";

            string fullvalue = ApiConnection.returnFullUrl();
            Console.WriteLine(fullvalue);
            Console.ReadLine();
        }
    }
}





//// API.cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace ConnectToAPI
{
    public class API
    {
        private string user;
        private string key;
        private string wid;
        private string url;

        public string User
        {
            get { return user; }
            set { user = value; }
        }

        public string Key
        {
            get { return key; }
            set { key = value; }
        }

        public string Wid
        {
            get { return wid; }
            set { wid = value; }
        }
        
        public string Url
        {
            get { return url; }
            set { url = value; }
        }        

        public string returnFullUrl()
        {
            return Url + "&" + User + "&" + Key;
        }

    }
}
