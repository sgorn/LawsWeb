using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Text;

namespace LimsSearch
{
    public enum CategoryType { LAWTYPE, ALPHANUM,LAWTITLE };

    /// <summary>
    /// Autonomy returns an xml file containing the response to a query
    /// This class represents the root element of the search results
    /// It contains some overall info and also a collection of hits
    /// </summary>
    public class Result
    {
        

        private static int RankByWeight(Hit hit1, Hit hit2)
        {
            if (hit1.Weight < hit2.Weight)
                return 1;
            else if (hit2.Weight < hit1.Weight)
                return -1;
            else
                return 0;
        }

        private string response;
        public string Response
        {
            get { return response; }
            set { response = value; }
        }

        private string storedState;
        public string StoredState
        {
            get { return storedState; }
            set { storedState = value; }
        }

        private bool successful;
        public bool Successful
        {
            get { return successful; }
            set { successful = value; }
        }

        private List<CategoryHit> lawTypes;
        public List<CategoryHit> LawTypes
        {
            get { return lawTypes; }
            set { lawTypes = value; }
        }

        private List<CategoryHit> alphas;
        public List<CategoryHit> Alphas
        {
            get { return alphas; }
            set { alphas = value; }
        }

        private List<CategoryHit> lawTitles;
        public List<CategoryHit> LawTitles
        {
            get { return lawTitles; }
            set { lawTitles = value; }
        }

        private int RelatedPhrasesMAX = LimsSearch.Properties.Settings.Default.MaxRelatedPhrases;
        public List<RelatedPhrase> RelatedPhrases; //from the autonomy query summary

        private List<Hit> hits;
        public List<Hit> Hits
        {
            get { return hits; }
            set { hits = value; }
        }

        public int AddHit(Hit newHit)
        {
            if (hits == null)
            {
                hits = new List<Hit>();
            }
            hits.Add(newHit);
            return hits.Count;
        }

        public Hit GetHit(string id)
        {
            foreach (Hit h in hits)
            {
                if (h.ID == id)
                    return h;
            }
            return null;
        }

        public List<Hit> SortedHits()
        {
            if (hits == null)
                return null;
            hits.Sort(RankByWeight); 
            return hits;
        }

        private int hitsReturned;
        public int HitsReturned
        {
            get { return hitsReturned; }
            set { hitsReturned = value; }
        }

        private int totalHits;
        public int TotalHits
        {
            get { return totalHits; }
            set { totalHits = value; }
        }

        private int totalDocs;
        public int TotalDocs
        {
            get { return totalDocs; }
            set { totalDocs = value; }
        }

        private int totalSecs;
        public int TotalSecs
        {
            get { return totalSecs; }
            set { totalSecs = value; }
        }

        public Result()
        {
            this.successful = false;
            this.storedState = "";
        }

        public Result(XmlDocument xDoc)
        {
            XmlNodeReader reader = new XmlNodeReader(xDoc);
            Hit currentHit;
            this.RelatedPhrases = new List<RelatedPhrase>();
            this.LawTypes = new List<CategoryHit>();
            this.Alphas = new List<CategoryHit>();
            this.LawTitles = new List<CategoryHit>();
            this.storedState = "";
            string value;
            while (!reader.EOF)
            {
                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.Name)
                    {
                        case "response":
                            value = reader.ReadInnerXml();
                            if (value != null)
                                value = value.ToLower();
                            this.response = value;  //to save the possible error code
                            this.Successful = value == "success";
                            break;
                        case "autn:numhits":
                            this.HitsReturned = ConvertXMLToInt(reader.ReadInnerXml());
                            break;
                        case "autn:qs":
                            ProcessQuerySummary(reader.ReadSubtree());
                            break;
                        //case "autn:querysummary":
                        //    ProcessQuerySummary(reader.ReadSubtree());
                        //    break;
                        case "autn:totalhits":
                            this.TotalHits = ConvertXMLToInt(reader.ReadInnerXml());
                            break;
                        case "autn:totaldbdocs":
                            this.TotalDocs = ConvertXMLToInt(reader.ReadInnerXml());
                            break;
                        case "autn:totaldbsecs":
                            this.TotalSecs = ConvertXMLToInt(reader.ReadInnerXml());
                            break;
                        case "autn:hit":
                            currentHit = new Hit(reader.ReadSubtree());
                            currentHit.MyResult = this;
                            if (currentHit != null)
                                this.AddHit(currentHit);
                            break;
                        case "autn:state":
                            this.StoredState = reader.ReadInnerXml();
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

        private void ProcessQuerySummary(XmlReader reader)
        {
            string value;

            while (!reader.EOF)
            {
                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.Name)
                    {
                        case "autn:element":
                            int docs = Convert.ToInt32(reader.GetAttribute("pdocs"));
                            int total = Convert.ToInt32(reader.GetAttribute("poccs"));
                            value = reader.ReadInnerXml();
                            if (value != null && this.RelatedPhrases.Count < RelatedPhrasesMAX)
                                this.RelatedPhrases.Add(new RelatedPhrase(value,docs,total));
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

        private int ConvertXMLToInt(string p)
        {
            if (p == null)
                return -1;
            if (p == "")
                return -1;
            try
            {
                return Convert.ToInt32(p);
            }
            catch
            {
                return -1;
            }
        }

        internal void GetCategories(XmlDocument xDoc, CategoryType catType, bool isFrench)
        {
            string value;

            XmlNodeReader reader = new XmlNodeReader(xDoc);

            while (!reader.EOF)
            {
                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.Name)
                    {
                        case "autn:value":
                            int docs = Convert.ToInt32(reader.GetAttribute("count"));
                            value = reader.ReadInnerXml();
                            if (catType == CategoryType.LAWTYPE)
                            {
                                value = this.TranslateLawType(value, isFrench);
                                this.LawTypes.Add(new CategoryHit(value, docs));
                            }
                            else if (catType == CategoryType.ALPHANUM)
                            {
                                this.Alphas.Add(new CategoryHit(value, docs));
                            }
                            else if (catType == CategoryType.LAWTITLE)
                            {
                                this.LawTitles.Add(new CategoryHit(value, docs));
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

        private string TranslateLawType(string value, bool isFrench)
        {
            if (isFrench)
            {
                switch (value)
                {
                    case "Acts":
                        return "Lois";

                    case "Regulations":
                        return "Règlements";

                    case "Annuals":
                        return "Lois annuelles";

                    case "Constitution":
                        return "Textes constitutionnels";
                        
                    case "TOPA":
                        return "Tableau des lois d'intérêt privé";

                    case "TOPS":
                        return "Tableau des lois d'intérêt public";

                    case "Help":
                        return "Pages d'aides";

                    default:
                        return value;

                }
            }
            else
            {
                switch (value)
                {
                    case "TOPA":
                        return "Table of Private Acts";

                    case "TOPS":
                        return "Table of Public Statutes";

                    default:
                        return value;
                }
            }
        }
    } //Result
} //end namespace
