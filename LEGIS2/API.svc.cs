using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace API
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class API : IAPI
    {
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        /// <summary>
        /// Method name reproduced from original service to support Transport - MVSR standards API pilot
        /// </summary>
        public System.IO.Stream RC(string lang, string type, string standard)
        {

            string path = Properties.Settings.Default.PathToData + "\\" + lang + "\\" + type + "\\" + standard + "." + type;
            if (File.Exists(path))
            {
                string text = System.IO.File.ReadAllText(path);
                byte[] resultBytes = Encoding.UTF8.GetBytes(text);
                WebOperationContext.Current.OutgoingResponse.ContentType = "text/html";
                return new MemoryStream(resultBytes);
            }
            else
            {
                string errorPath = "C:\\Users\\anguyen\\Desktop\\FileSearch\\404\\404.html";
                string text = System.IO.File.ReadAllText(errorPath);
                byte[] resultBytes = Encoding.UTF8.GetBytes(text);
                WebOperationContext.Current.OutgoingResponse.ContentType = "text/html";
                return new MemoryStream(resultBytes);
            }
        }

        /// <summary>
        /// Method name reproduced from original service to support Transport - MVSR standards API pilot
        /// </summary>
        public System.IO.Stream GetSection(string lawtype, string filenumber, string lang, string sectionnumber)
        {
            string path = Properties.Settings.Default.WebRoot + "\\" + lang + "\\" + lawtype + "\\" + filenumber + "\\content-section-" + sectionnumber + ".html";
            if (File.Exists(path))
            {
                string text = System.IO.File.ReadAllText(path, Encoding.UTF8);
                byte[] resultBytes = Encoding.UTF8.GetBytes(text);
                WebOperationContext.Current.OutgoingResponse.ContentType = "text/html";
                Encoding thisEnc = WebOperationContext.Current.OutgoingResponse.BindingWriteEncoding;

                return new MemoryStream(resultBytes);
            }
            else
            {
                string errorPath = "C:\\Users\\anguyen\\Desktop\\FileSearch\\404\\404.html";
                string text = System.IO.File.ReadAllText(errorPath);
                byte[] resultBytes = Encoding.UTF8.GetBytes(text);
                WebOperationContext.Current.OutgoingResponse.ContentType = "text/html";
                return new MemoryStream(resultBytes);
            }
        }


        public Stream TestMessage(string message)
        {
            // convert string to stream
            byte[] byteArray = Encoding.ASCII.GetBytes(message);
            MemoryStream stream = new MemoryStream(byteArray);
            return stream;
        }
    }
}
