using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace API
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IAPI
    {

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate="RC?lang={lang}&type={type}&standard={standard}")]
        System.IO.Stream RC(string lang, string type, string standard);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate = "GetSection?lawtype={lawtype}&filenumber={filenumber}&lang={lang}&sectionnumber={sectionnumber}")]
        System.IO.Stream GetSection(string lawtype, string filenumber, string lang, string sectionnumber);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate = "TestMessage?message={message}")]
        System.IO.Stream TestMessage(string message);


        // TODO: Add your service operations here
    }


}
