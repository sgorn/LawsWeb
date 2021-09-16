using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;
using System.Text;

namespace LimsSearch
{
    public partial class _Default : System.Web.UI.Page
    {
        private UserSearchParams searchParams;
        private Result currentResult;
        private int maxResults = LimsSearch.Properties.Settings.Default.MaxResults;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                readSearchParams();
                populateFormValues();
                if (searchParams.Keywords != null)
                {
                    doSearch();
                }
            }
            else
            {
                h1dd3nPag3Num.Value = "1";
            }

        }
        private void readSearchParams()
        {
            searchParams = new UserSearchParams(this.Request);
        }

        private void populateFormValues()
        {
            if (searchParams.Keywords != null)
                this.txtS3archT3rms.Text = searchParams.Keywords;

           
            if (searchParams.ContentType != null)
            {
                switch (searchParams.ContentType)
                {
                    case "Acts":
                        this.ddC0nt3ntTyp3.SelectedValue = "Statutes";
                        break;
                    default:
                        ddC0nt3ntTyp3.SelectedValue = searchParams.ContentType;
                        break;
                }
            }

            if (searchParams.PageNum != null)
                this.h1dd3nPag3Num.Value = searchParams.PageNum;
        }

        private void doSearch()
        {
            string textParam;
            string fieldTextParam = "";

            int pagenum = Convert.ToInt32(this.h1dd3nPag3Num.Value);
            int startParam = ((pagenum - 1) * maxResults) + 1;

            Dictionary<string, string> queryParams = new Dictionary<string, string>();
            textParam = txtS3archT3rms.Text;

            queryParams.Add("text", textParam);
            queryParams.Add("combine", "simple");
            queryParams.Add("print", "all");
            queryParams.Add("Highlight", "Terms");
            queryParams.Add("Sentences", "4");
            queryParams.Add("QuerySummary", "true");
            queryParams.Add("AnyLanguage", "true");
            queryParams.Add("MatchAllTerms", "true");
            queryParams.Add("TotalResults", "true");
            queryParams.Add("MaxResults", (maxResults * pagenum).ToString());
            queryParams.Add("Start", startParam.ToString());
            queryParams.Add("DatabaseMatch", LimsSearch.Properties.Settings.Default.AutonomyDB);
            queryParams.Add("StartTag", "<span class='hit'>");

            switch (ddC0nt3ntTyp3.SelectedItem.Value)
            {
                case "Statutes":
                    fieldTextParam += "MATCH{Acts}:LAWTYPE";
                    break;
                case "Regulations":
                    fieldTextParam += "MATCH{Regulations}:LAWTYPE";
                    break;
                case "ActsRegs":
                    fieldTextParam += "(MATCH{Regulations}:LAWTYPE+OR+MATCH{Acts}:LAWTYPE)";
                    break;
                case "All":
                    fieldTextParam += "EXISTS{}:LAWTYPE";
                    break;
                default:
                    fieldTextParam += "MATCH{" + ddC0nt3ntTyp3.SelectedItem.Value + "}:LAWTYPE";
                    break;
            }

            //Set language of query
            fieldTextParam += "+AND+MATCH{en}:LANGUAGE";

            bool currentOnly = true;
            if (currentOnly)
            {
                if (!String.IsNullOrEmpty(fieldTextParam)) fieldTextParam += "+AND+";

                fieldTextParam += "(RANGE{01/01/9998,02/02/9999}:INFORCEEND+OR+EMPTY{}:INFORCEEND)";
                fieldTextParam += "+NOT+WILD{*section-*}:DREREFERENCE"; //section files only for PIT
            }

            if (!String.IsNullOrEmpty(fieldTextParam))
                queryParams.Add("FieldText", fieldTextParam);

            SearchService.Service service = new SearchService.Service();

            string[] parms = ConvertDict2Array(queryParams);
            string strXml = service.QueryAutonomy(parms);

            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(strXml);
            currentResult = new Result(xDoc);
            searchResults.DataSource = currentResult.SortedHits();
            searchResults.DataBind();

            createResultsDisplayInfoAndPageNav(pagenum, startParam);


        }

        private void createResultsDisplayInfoAndPageNav(int pagenum, int startParam)
        {
            if (currentResult.TotalHits > maxResults)
            {  //multiple pages are needed
                int lastResultOnPage = Math.Min((maxResults * pagenum), currentResult.TotalHits);
                Label1.Text = "Displaying " + startParam.ToString() + " to " + lastResultOnPage.ToString()
                            + " of " + currentResult.TotalHits + " matching pages";
                int nextpage = pagenum + 1;
                int prevpage = pagenum - 1;
                int lastpage = Convert.ToInt32(Math.Ceiling((double)currentResult.TotalHits / maxResults));
                divPageNav.Attributes.Remove("class"); //move hidden class
                string pageLinks = "";
                if (prevpage > 0)
                {
                    pageLinks += "<a href='" + this.BuildQueryString(filterType.Page, prevpage) + "'>Previous Results Page</a>";
                }
                if (prevpage > 0 && nextpage <= lastpage)
                {
                    pageLinks += " | ";
                }
                if (nextpage <= lastpage)
                {
                    pageLinks += "<a href='" + this.BuildQueryString(filterType.Page, nextpage) + "'>Next Results Page</a>";
                }
                divPageNav.InnerHtml = pageLinks;

            }
            else //all results on a single page
                Label1.Text = currentResult.TotalHits + " hits";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            doSearch();
        }

        private string[] ConvertDict2Array(Dictionary<string, string> queryParams)
        {
            int length = queryParams.Count * 2;
            string[] result = new string[length];

            int i = 0;
            foreach (KeyValuePair<string, string> item in queryParams)
            {
                result[i] = item.Key.ToString();
                result[i + 1] = item.Value.ToString();
                i = i + 2;
            }
            return result;
        }

        public string AddTermsToLink(object ob)
        {
            if (!String.IsNullOrEmpty(txtS3archT3rms.Text))
            {
                string link = ob.ToString() + "?term=" + txtS3archT3rms.Text.Replace(" ", "+").Replace("\"", "");
                return link;
            }
            else
            {
                return ob.ToString();
            }

        }

        public string BuildQueryString(filterType ft, object ob)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("Default.aspx?");
            sb.Append("&ddC0nt3ntTyp3=" + HttpUtility.UrlEncode(ddC0nt3ntTyp3.SelectedValue));
            sb.Append("&txtS3archT3rms=" + HttpUtility.UrlEncode(txtS3archT3rms.Text));

            switch (ft)
            {
                case filterType.Page:
                    
                    sb.Append("&h1dd3nPag3Num=" + ob.ToString());
                    break;
            }

            return sb.ToString();
        }

    }
}
