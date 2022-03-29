using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;
using System.ServiceModel.Web;
using System.Xml;

namespace PersonJSONService
{
    public class PersonJSONService : IPersonJSONService
    {
        public string RawContent(string lang, string type, string standard)
        {

            string path = "C:\\Users\\anguyen\\Desktop\\FileSearch\\" + lang + "\\" + type + "\\" + standard + "." + type;
            string text = System.IO.File.ReadAllText(@path);
            return text;
        }

        public System.IO.Stream RenderedContent(string lang, string type, string standard)
        {
            string path = "C:\\Users\\anguyen\\Desktop\\FileSearch\\" + lang + "\\" + type + "\\" + standard + "." + type;
            if (File.Exists(path))
            {
                string text = System.IO.File.ReadAllText(@path);
                byte[] resultBytes = Encoding.UTF8.GetBytes(text);
                WebOperationContext.Current.OutgoingResponse.ContentType = "text/html";
                return new MemoryStream(resultBytes);
            }
            else
            {
                string errorPath = "C:\\Users\\anguyen\\Desktop\\FileSearch\\404\\404.html";
                string text = System.IO.File.ReadAllText(@errorPath);
                byte[] resultBytes = Encoding.UTF8.GetBytes(text);
                WebOperationContext.Current.OutgoingResponse.ContentType = "text/html";
                return new MemoryStream(resultBytes);
            }
        }
    }
}
