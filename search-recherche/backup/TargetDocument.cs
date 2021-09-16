using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
using System.Text.RegularExpressions;
using ca.gc.justice.lims.library.Xml;


namespace LimsSearch
{
    /// <summary>
    /// Summary description for Document
    /// </summary>
    public class TargetDocument
    {
        private XslCompiledTransform parseXml;
        private XslCompiledTransform stripXml;

        private string document;
        public string Document
        {
            get { return document; }
            set { document = value; }
        }
        private bool xmlDocument;
        public bool XMLDocument
        {
            get { return xmlDocument; }
            set { xmlDocument = value; }
        }
        private string reference;
        public string Reference
        {
            get { return reference; }
            set { reference = value; }
        }

        private string sectionLink;
        public string SectionLink
        {
            get { return sectionLink; }
            set { sectionLink = value; }
        }

        private string longTitle;
        public string LongTitle
        {
            get { return longTitle; }
            set { longTitle = value; }
        }

        private string title;
        public string Title
        {
            get { return title; }
            set { title = value; }
        }

        private string date;
        public string Date
        {
            get { return date; }
            set { date = value; }
        }

        private string dbname;
        public string DBName
        {
            get { return dbname; }
            set { dbname = value; }
        }

        private string contenttype;
        public string ContentType
        {
            get { return contenttype; }
            set { contenttype = value; }
        }

        private string documentclass;
        public string DocumentClass
        {
            get { return documentclass; }
            set { documentclass = value; }
        }

        private string documenttype;
        public string DocumentType
        {
            get { return documenttype; }
            set { documenttype = value; }
        }

        private string language;
        public string Language
        {
            get { return language; }
            set { language = value; }
        }

        private string encodings;
        public string Encodings
        {
            get { return encodings; }
            set { encodings = value; }
        }

        private string inforcestart;
        public string InForceStart
        {
            get { return inforcestart; }
            set { inforcestart = value; }
        }

        private string inforceend;
        public string InForceEnd
        {
            get { return inforceend; }
            set { inforceend = value; }
        }

        private string alphanum;
        public string AlphaNum
        {
            get { return alphanum; }
            set { alphanum = value; }
        }
        private string officialAlphaNumber;
        public string OfficialAlphaNumber
        {
            get { return officialAlphaNumber; }
            set { officialAlphaNumber = value; }
        }

        private string enablingacts;
        public string EnablingActs
        {
            get { return enablingacts; }
            set { enablingacts = value; }
        }

        private string lawtype;
        public string LawType
        {
            get { return lawtype; }
            set { lawtype = value; }
        }


        private string content;
        public string Content
        {
            get { return content; }
            set { content = value; }
        }

        private List<TermHit> termHits;
        public List<TermHit> TermHits
        {
            get { return termHits; }
            set { termHits = value; }
        }

        private string context;
        public string Context
        {
            get { return context; }
            set { context = value; }
        }

        private string clippedContent;
        public string ClippedContent
        {
            get { return clippedContent; }
            set { clippedContent = value; }
        }

        private string label;
        public string Label
        {
            get { return label; }
            set { label = value; }
        }


        public TargetDocument()
        {
            //
            // TODO: Add constructor logic here
            //
            parseXml = new XslCompiledTransform();
            this.parseXml.Load(typeof(LIMS2XHTML));

            stripXml = new XslCompiledTransform();
            this.stripXml.Load(typeof(StripXML));
        }

        public TargetDocument(XmlReader reader)
        {
            if (reader == null)
                return;
            parseXml = new XslCompiledTransform();
            stripXml = new XslCompiledTransform();
            this.stripXml.Load(typeof(StripXML));
            this.parseXml.Load(typeof(LIMS2XHTML));
            this.Label = "";
            while (reader.NodeType != XmlNodeType.Element)
            {
                reader.Read();
            }
            if (reader.Name == "autn:content")
                reader.Read();
            //if (reader.Name == "DOCUMENT")
            //    TargetHTMLDocument(reader);
            //else
            TargetXMLDocument(reader);

        }

        private void TargetXMLDocument(XmlReader reader)
        {
            string value;
            this.XMLDocument = true;
            this.Encodings = "utf8";
            this.Content = "";
            bool headingDoc = false;
            string[,] strParams = new string[4,2];
            strParams[0,0] = "language";
            strParams[0,1] = "en";
            strParams[1,0] = "LawType";
            strParams[1,1] = "Acts";
            strParams[2,0] = "ContextSize";
            strParams[2,1] = "60";
            strParams[3,0] = "InForce";
            strParams[3,1] = "True";

            int loopCounter = 0; //counter to protect again infinite loops caused by invalid xml data
            int loopLimit = 12345; //abitrary number

            while (!reader.EOF && loopCounter < loopLimit)
            {
                loopCounter++;

                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.Name)
                    {
                        case "Link":
                            value = reader.ReadInnerXml();
                            if (value != null)
                            {
                                this.Reference = value;
                            }
                            else
                                this.Reference = "";
                            break;
                        case "SectionLink":
                            value = reader.ReadInnerXml();
                            if (value != null)
                            {
                                this.SectionLink = value;
                            }
                            break;
                        case "Legis":
                        //case "Statute":
                            value = reader.GetAttribute("LawType");
                            if (value != null)
                            {
                                strParams[1, 1] = value;
                                this.LawType = value;
                            }
                            else
                                this.LawType = "";

                            value = reader.GetAttribute("xml:lang");
                            if (value == null)
                                value = reader.GetAttribute("Language");

                            if (value != null)
                            {
                                this.Language = value;
                                strParams[0, 1] = value;
                            }
                            
                            value = reader.GetAttribute("in-force");
                            if (value != null)
                            {
                                strParams[3, 1] = value;
                            }
                            reader.Read();
                            break;
                        //case "Regulation":
                        //    this.LawType = "Regulations";
                        //    strParams[1, 1] = "Regulations";
                        //    value = reader.GetAttribute("xml:lang");
                        //    if (value != null)
                        //    {
                        //        this.Language = value;
                        //        strParams[0, 1] = "en";
                        //    }
                        //    reader.Read();
                        //    break;
                        case "LongTitle":
                            if (reader.IsEmptyElement)
                                reader.Read();
                            else
                                this.longTitle = ParseInlineXML(reader.ReadSubtree(), strParams);
                            break;
                        case "DRETITLE":
                        case "Title":
                        case "ShortTitle":
                            if (reader.IsEmptyElement)
                                reader.Read();
                            else
                                this.Title = ParseInlineXML(reader.ReadSubtree(), strParams);
                            break;
                        case "Stages":
                            value = reader.GetAttribute("stage");
                            if (value != null && value == "consolidation")
                            {
                                this.Date = ParseInlineXML(reader.ReadSubtree(), strParams);
                            }
                            break;
                        case "ConsolidationDate":
                            this.Date = ParseInlineXML(reader.ReadSubtree(), strParams);
                            break;
                        case "OfficialAlphaNumber":
                            this.OfficialAlphaNumber = reader.ReadInnerXml();
                            break;
                        case "AlphaNum":
                        case "Alpha":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                this.AlphaNum = value;
                            else
                                this.AlphaNum = "";
                            break;
                        /*case "INFORCESTART":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                this.InForceStart = value;
                            else
                                this.InForceStart = "";
                            break;
                        case "INFORCEEND":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                this.InForceEnd = value;
                            else
                                this.InForceEnd = "";
                            break;*/
                        case "InstrumentNumber":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                this.AlphaNum = value;
                            else
                                this.AlphaNum = "";
                            break;
                        case "EnablingAuthority":
                            reader.Read(); // Just move on to its children
                            break;
                        case "AuthorityTitle":
                            value = ParseInlineXML(reader.ReadSubtree(), strParams);
                            if (value != null)
                            {
                                if (String.IsNullOrEmpty(this.EnablingActs))
                                    this.EnablingActs = value;
                                else
                                    this.EnablingActs += ", " + value;
                            }
                            else
                            {
                                if (String.IsNullOrEmpty(this.EnablingActs))
                                    this.EnablingActs = "";
                            }
                            break;
                        case "InForceStart":
                        case "StartDate":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                this.InForceStart = value;
                            else
                                this.InForceStart = "";
                            break;
                        case "InForceEnd":
                        case "EndDate":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                this.InForceEnd = value;
                            else
                                this.InForceEnd = "";
                            break;
                        case "Body":
                            this.Content = ParseInlineXML(reader.ReadSubtree(), strParams);
                            //next line only needed if SEARCH OPTION HIGHLIGHT=SUMMARY
                            //this.Content = this.Content.Replace("&gt;", ">").Replace("&lt;", "<");
                            //CreateTermHits(this.Content);
                            break;
                        case "Schedule":
                            this.Content += ParseInlineXML(reader.ReadSubtree(), strParams);
                            //this.Content = this.Content.Replace("&gt;", ">").Replace("&lt;", "<");
                            //CreateTermHits(this.Content);
                            break;
                        case "AUTOGENERATE":
                            reader.Read();
                            break;
                        //case "NextSection":
                        //    string strValue = reader.ReadInnerXml();
                        //    if (!String.IsNullOrEmpty(strValue))
                        //    {
                        //        this.Content += "<p class='Paragraph'><a href='";
                        //        this.Content += "http://ot1s0075:9800/action=query&print=all&text=*&FieldText=MATCH{" + strValue + "}:Section/_ATTR_Code";
                        //        this.Content += "'>Following section</a></p>";
                        //    }
                        //    break;
                        case "Heading":
                            if (this.LawType != "Annuals") //Headings are appended to sections in the Annuals IDOL XML
                                headingDoc = true;
                            this.Content += ParseInlineXML(reader.ReadSubtree(), strParams);
                            //this.Content = this.Content.Replace("&gt;", ">").Replace("&lt;", "<");
                            break;
                        case "section":
                            this.Content = reader.ReadInnerXml();
                            break;
                        default:
                            // an element we are not interested in:
                            // reader.Read();
                            this.Content += ParseInlineXML(reader.ReadSubtree(), strParams);
                            //this.Content = this.Content.Replace("&gt;", ">").Replace("&lt;", "<");
                            //CreateTermHits(this.Content);
                            break;
                    }
                }
                else
                    reader.Read();

            }
            this.Content = this.Content.Replace("&lt;/span&gt; &lt;", "&lt;/span&gt;&#x00A0;&lt;").Replace("&lt;span class='hit'&gt;", "<span class='hit'>").Replace("&lt;/span&gt;", "</span>");
            this.Title = this.Title.Replace("&lt;/span&gt; &lt;", "&lt;/span&gt;&#x00A0;&lt;").Replace("&lt;span class='hit'&gt;", "<span class='hit'>").Replace("&lt;/span&gt;", "</span>");
            this.Label = this.Label.Replace("&lt;/span&gt; &lt;", "&lt;/span&gt;&#x00A0;&lt;").Replace("&lt;span class='hit'&gt;", "<span class='hit'>").Replace("&lt;/span&gt;", "</span>");
            this.Reference = AddTermHits(this.Reference, this.Content, "<span class=\"hit\">");
            if (!String.IsNullOrEmpty(this.SectionLink))
            {
                this.SectionLink = AddTermHits(this.SectionLink, this.Content, "<span class=\"hit\">");
            }
            if (headingDoc == false)
            {
                //CreateTermHits(this.Content);
                this.Context = XMLUtilities.CreateXMLContext(this.Content, this.stripXml, this);
                //this.Context = this.Content;
                //CreateContext();
            }
            else
            {
                this.Context = this.Content;
            }
        }
        internal static string AddTermHits(string strReference, string strContent, string strStartTag)
        {
            try
            {
                string strTerms = "";
                string strOut;
                if (strContent.Contains(strStartTag) == false)
                    return strReference;
                Regex hit = new Regex(strStartTag + "([^<]+)</span>");
                MatchCollection matches = hit.Matches(strContent);
                if (matches == null)
                    return strReference;
                List<string> terms = new List<string>();
                string term = "";
                foreach (Match m in matches)
                {
                    term = m.Groups[1].Value.ToLower();
                    if (terms.Contains(term) == false)
                        terms.Add(term);
                }
                strTerms = "?texthighlight=";
                terms.Sort(SortTermHitsByLength);
                int i = 0;
                for (i = 0; i < terms.Count; i++)
                {
                    strTerms += terms[i];
                    if (i < terms.Count - 1)
                        strTerms += "+";
                }
                if (strReference.Contains("#"))
                {
                    int pos = strReference.IndexOf('#');
                    strOut = strReference.Insert(pos, strTerms);
                }
                else
                {
                    strOut = strReference + strTerms;
                }
                //remove spaces from URL 
                strOut = strOut.Replace(" ", "%20");
                return strOut;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return "";
            }
        }

        private static int SortTermHitsByLength(string y, string x) //switched x and y to reverse order
        {
            if (x == null)
            {
                if (y == null)
                {// If x is null and y is null, they're// equal. 
                    return 0;
                }
                else
                {// If x is null and y is not null, y // is greater. 
                    return -1;
                }
            }
            else
            {// If x is not null...
                if (y == null) // ...and y is null, x is greater.
                {
                    return 1;
                }
                else
                {// ...and y is not null, compare the // lengths of the two strings.
                    int retval = x.Length.CompareTo(y.Length);

                    if (retval != 0)
                    {// If the strings are not of equal length,// the longer string is greater.
                        return retval;
                    }
                    else
                    { // If the strings are of equal length,// sort them with ordinary string comparison.
                        return x.CompareTo(y);
                    }
                }
            }
        }



        public void args_XsltMessageEncountered(object sender, XsltMessageEncounteredEventArgs e)
        {
            string msg = e.Message.Trim();
            if (msg.StartsWith("~"))
            {
                if (String.IsNullOrEmpty(this.Label))
                {
                    this.label = msg.Substring(1);
                    if (this.label.EndsWith("."))
                        this.label = this.label.Substring(0, this.label.Length - 1);
                    this.label = "(" + this.label + ")";
                }
            }
            else
                Console.WriteLine(e.Message);
        }

        private string ParseInlineXML(XmlReader reader, string[,] strParams)
        {
            if (reader == null)
                return "";
            return XMLUtilities.TransformReaderToString(reader, this.parseXml, strParams, this);
        }

    }
    public class UsefulMethodsWithNowhereElse2Go
    {
        public static int GetTotalHitsFromXML(string strXML)
        {
            try
            {
                Regex totalhits = new Regex("<autn:totalhits>([^<]*)</autn:totalhits>");
                Match m = totalhits.Match(strXML);
                if (m != null)
                    return Convert.ToInt16(m.Groups[1].Value);
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        public static List<string> CreateFieldTextArgs(string strIn, string strFieldName)
        {
            try
            {
                List<string> strings = new List<string>();
                strIn = strIn.Trim();
                strIn = strIn.Replace("%", "~");
                strIn = strIn.Replace("&", "%26");
                strIn = strIn.Replace("\\", "%5C");
                strIn = strIn.Replace(",", "%2C");
                strIn = strIn.Replace("~", "%5C");
                strIn = strIn.Replace("'", "’");
                int pos = strIn.IndexOf('"');
                char[] chars = strIn.ToCharArray();
                char c;
                string strThis = "";
                string strOut = strIn;
                if (pos >= 0)
                {
                    Regex quotes = new Regex("\"([^\"]*)\"");
                    MatchCollection matches = quotes.Matches(strIn);
                    foreach (Match m in matches)
                    {
                        if (m.Groups.Count == 2)
                        {
                            //strThis = "(WILD{* " + m.Groups[1].Value + "*}:" + strFieldName;
                            strThis = "WILD{*" + m.Groups[1].Value + "*}:" + strFieldName;
                            // Using TERMEXACTPHRASE because WILD will not transliterate at all
                            // and therefore requires (for instance) a correct ’ instead of a '
                            //strThis = "TERMEXACTPHRASE{" + m.Groups[1].Value + "}";
                            //strThis += "+OR+WILD{" + m.Groups[1].Value + "*}:" + strFieldName + ")";
                            strings.Add(strThis);
                            strOut = strOut.Replace(m.Groups[0].Value, "");
                        }
                    }
                    strOut = strOut.Replace("\"", "");
                    strIn = strOut.Trim();
                    if (String.IsNullOrEmpty(strIn))
                        return strings;
                }
                Regex spaces = new Regex(" [ ]*");
                strIn = spaces.Replace(strIn, " ");
                string[] tokens = strIn.Split(' ');
                strThis = "";
                for (int i = 0; i < tokens.Length; i++)
                {
                    //strThis = "(WILD{* " + tokens[i] + "*}:" + strFieldName + "+OR+WILD{" + tokens[i] + "*}:" + strFieldName + ")";
                    strThis = "WILD{*" + tokens[i] + "*}:" + strFieldName;// +"+OR+WILD{" + tokens[i] + "*}:" + strFieldName;
                    strings.Add(strThis);
                    /*if (i < tokens.Length - 1)
                    {
                        strThis += ",";
                    }*/
                }
                //strThis = "TERMALL{" + strThis + "}";
                //strings.Add(strThis);
                return strings;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                List<string> fail = new List<string>();
                strIn = "WILD{" + strIn + "}";
                fail.Add(strIn);
                return fail;
            }
        }
    }
}
