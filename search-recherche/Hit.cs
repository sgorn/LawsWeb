using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Text;

namespace LimsSearch
{
    /// <summary>
    /// Summary description for Hit
    /// </summary>
    public class Hit
    {
        private Uri reference;
        public Uri Reference
        {
            get { return reference; }
            set { reference = value; }
        }
        private Result myResult; // The Result containing this hit
        public Result MyResult
        {
            get { return myResult; }
            set { myResult = value; }
        }
        private string id;
        public string ID
        {
            get { return id; }
            set { id = value; }
        }
        private double weight;
        public double Weight
        {
            get { return weight; }
            set { weight = value; }
        }

        private string summary;
        public string Summary  //the Autonomy summary - use for hits in context
        {
            get { return summary; }
            set { summary = value; }
        }
        private string title;
        public string Title
        {
            get { return title; }
            set { title = value; }
        }

        private TargetDocument myDoc;
        public TargetDocument Document
        {
            get { return myDoc; }
            set { myDoc = value; }
        }

        private string section;
        public string Section
        {
            get { return section; }
            set { section = value; }
        }

        private string links;
        public string Links
        {
            get { return links; }
            set { links = value; }
        }

        private string database;
        public string Database
        {
            get { return database; }
            set { database = value; }
        }

        public Hit()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public Hit(XmlReader reader)
        {
            string value;
            while (!reader.EOF)
            {
                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.Name)
                    {
                        case "autn:reference":
                            value = reader.ReadInnerXml();
                            if (String.IsNullOrEmpty(value) == false && value.Contains("AUTN-GEN") == false)
                                try
                                {
                                    this.Reference = new Uri(value);
                                }
                                catch
                                {
                                    this.Reference = new Uri("http://laws.justice.gc.ca/");
                                }
                            else
                                this.Reference = new Uri("http://laws.justice.gc.ca/");
                            break;
                        case "autn:id":
                            value = reader.ReadInnerXml();
                            if (value != null && value != "")
                                this.ID = value;
                            else
                                this.ID = RandomString(6);
                            break;
                        case "autn:section":
                            value = reader.ReadInnerXml();
                            this.Section = (value != null) ? value : "";
                            break;
                        case "autn:weight":
                            this.Weight = ConvertXMLToDouble(reader.ReadInnerXml());
                            break;
                        case "autn:links":
                            value = reader.ReadInnerXml();
                            this.Links = (value != null) ? value : "";
                            break;
                        case "autn:database":
                            value = reader.ReadInnerXml();
                            if (value != null && value != "")
                                this.Database = value;
                            else
                                this.Database = "LIMS";
                            break;
                        case "autn:summary":
                            value = reader.ReadInnerXml();
                            this.Summary = (value != null) ? value : "";
                            this.Summary = this.Summary.Replace("&gt;", ">").Replace("&lt;", "<");
                            break;
                        case "autn:content":
                            TargetDocument doc = new TargetDocument(reader.ReadSubtree());
                            if (doc != null)
                            {
                                this.Document = doc;
                                if (this.Document.XMLDocument == true && (! String.IsNullOrEmpty(doc.Reference)))
                                {
                                    try
                                    {
                                        this.Reference = new Uri(doc.Reference);
                                    }
                                    catch
                                    {
                                        this.Reference = new Uri("http://laws.justice.gc.ca/");
                                    }
                                }
                            }
                            break;
                        default:
                            // an element we are not interested in:
                            reader.Read();
                            break;
                    }
                }
                else
                    reader.Read();
            }

        }
        private double ConvertXMLToDouble(string p)
        {
            if (p == null)
                return -1;
            if (p == "")
                return -1;
            try
            {
                return Convert.ToDouble(p);
            }
            catch
            {
                return -1;
            }
        }

        private string RandomString(int size)
        {

            StringBuilder builder = new StringBuilder();
            Random random = new Random();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }
            return builder.ToString();
        }
    }
}
