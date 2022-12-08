using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Security.Permissions;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;

namespace ca.gc.justice.lims.library.Xml
{

    public class XMLUtilities
    {
        private static string logPath = @"C:\temp\Wolfe\SearchErrorLog" + ".log";

        public enum ContentType { TagStart, TagClose, FoundTerm, PlainText };
        
        public XMLUtilities()
        {

        }

        public static void UpdateLogFile(string strMsg)
        {
            try
            {
                StreamWriter log = new StreamWriter(logPath, true, Encoding.UTF8);
                log.WriteLine("------");
                log.WriteLine(strMsg);
                log.Close();
            }
            catch (Exception e)
            {
                return;
            }
        }

        public static string concatArray(string[] parms)
        {
            string val = "";

            foreach (string s in parms)
            {
                val += s + " ";
            }
            return val;
        }

        private static string MemoryStreamToString(MemoryStream mem, bool deleteByteOrderMark)
        {
            byte[] bytes = mem.ToArray();
            if (bytes.Length == 0)
            {
                return "";
            }
            byte[] newBytes;
            if (bytes.Length > 2 && bytes[0] == 239 && bytes[1] == 187 && bytes[2] == 191)
            {
                // The byte array starts with the Byte Order Mark, we'll strip it out:
                newBytes = new byte[bytes.Length - 3];
                int x, i;
                x = 0;
                for (i = 3; i < bytes.Length; i++)
                {
                    newBytes[x] = bytes[i];
                    x++;
                }
            }
            else
            {
                newBytes = bytes;
            }
            Encoding enc = new System.Text.UTF8Encoding(false);
            return enc.GetString(newBytes);
        }

        public static string TransformXMLToString(string strXML, XslCompiledTransform XSLT, string[,] strParams, LimsSearch.TargetDocument targetDoc)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(strXML);
                return TransformToString(doc, XSLT, strParams, targetDoc);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return "";
            }
        }

        private static string TransformToString(XmlDocument doc, XslCompiledTransform XSLT, string[,] strParams, LimsSearch.TargetDocument targetDoc)
        {
            try
            {
                XsltSettings settings = new XsltSettings(true, true);
                MemoryStream mStream = new MemoryStream();
                XSLT.Transform(doc, CreateXSLTArgs(strParams, targetDoc), mStream);
                string strXML = MemoryStreamToString(mStream, true);
                return strXML;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return "";
            }
        }

        public static string TransformReaderToString(XmlReader reader, XslCompiledTransform XSLT, string[,] strParams, LimsSearch.TargetDocument targetDoc)
        {
            try
            {
                XsltSettings settings = new XsltSettings(true, true);
                MemoryStream mStream = new MemoryStream();
                XSLT.Transform(reader, CreateXSLTArgs(strParams, targetDoc), mStream);
                string strXML = MemoryStreamToString(mStream, true);
                return strXML;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return "";
            }
        }

        private static XsltArgumentList CreateXSLTArgs(string[,] parameters)
        {
            XsltArgumentList args = new XsltArgumentList();
            try
            {
                if (parameters != null)
                {
                    for (int i = 0; i < (parameters.Length / 2); i++)
                    {
                        if ((parameters[i, 0] != null) && (parameters[i, 0] != String.Empty) && (parameters[i, 1] != String.Empty))
                        {
                            args.AddParam(parameters[i, 0], "", parameters[i, 1]);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return args;
        }

        private static XsltArgumentList CreateXSLTArgs(string[,] parameters, LimsSearch.TargetDocument doc)
        {
            XsltArgumentList args = new XsltArgumentList();
            try
            {
                if (parameters != null)
                {
                    for (int i = 0; i < (parameters.Length / 2); i++)
                    {
                        if ((parameters[i, 0] != null) && (parameters[i, 0] != String.Empty) && (parameters[i, 1] != String.Empty))
                        {
                            args.AddParam(parameters[i, 0], "", parameters[i, 1]);
                        }
                    }
                }
                if (doc != null)
                    args.XsltMessageEncountered += new XsltMessageEncounteredEventHandler(doc.args_XsltMessageEncountered);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return args;
        }
 

        /// <summary>
        /// This method strips out the pieces of the result file that do not
        /// contain a relevant hit.  The StripXML is run and then the ellipsis chunks are removed using Regex
        /// </summary>
        /// <returns></returns>
        internal static string CreateXMLContext(string p, XslCompiledTransform trans, LimsSearch.TargetDocument targetDoc)
        {
            string strOut = TransformXMLToString("<Root>"+p+"</Root>", trans, null, targetDoc);
            try
            {
                if (strOut.Trim() == "")
                    return p;

                Regex ellipsis = new Regex(@"(<p[^>]*>\[\.\.\.\]</p>)(\s*<p[^>]*>\[\.\.\.\]</p>)+");
                strOut = ellipsis.Replace(strOut, "$1");

                Regex listEllipsis = new Regex(@"(<li>\s*<p[^>]*>\[\.\.\.\]</p>\s*</li>)(\s*<li>\s*<p[^>]*>\[\.\.\.\]</p>\s*</li>)+");
                strOut = listEllipsis.Replace(strOut, "$1");

                //remove ellipsis at the end of lists so that there are not consecutive trailing [...]
                Regex ListEndEllipsis = new Regex(@"<li>\s*<p[^>]*>\[\.\.\.\]</p>\s*</li>\s*</ul>");
                strOut = ListEndEllipsis.Replace(strOut, "</ul>");

                return strOut;
            }
            catch (Exception e)
            {
                return p;
            }
        }

        public static string EncodeSpanTag(string strXml)
        {
            strXml = strXml.Replace("&lt;/span&gt; &lt;", "&lt;/span&gt;&#x00A0;&lt;").Replace("&lt;span class='hit'&gt;", "<span class='hit'>").Replace("&lt;/span&gt;", "</span>");
            return strXml;
        }
    }


}