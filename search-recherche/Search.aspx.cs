using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace LimsSearch
{
    public partial class Search : System.Web.UI.Page
    {

        private UserSearchParams searchParams;
        private Result currentResult;
        public bool textIsEmpty = true;
        private int maxResults = LimsSearch.Properties.Settings.Default.MaxResults;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                readSearchParams();
                populateFormValues();

                if (!String.IsNullOrEmpty(this.searchParams.AutonomyID) && !String.IsNullOrEmpty(searchParams.HitNumber))
                {
                    LoadResultByID(this.searchParams.AutonomyID, this.searchParams.HitNumber);
                }
                else if (searchParams.Keywords != null || searchParams.Title != null)
                {  //at least one of the keyword fields must have data
                    doSearch();
                }
            }
            else
            {   //reset hidden values if the Search button is clicked
                h1dd3nPag3Num.Value = "1";
                h1dd3nld.Value = "0";
                //txtS3arch3xact.Value = "";
            }
        }

        //Returns a single hit when the hits only item is selected
        private void LoadResultByID(string strID, string strHit)
        {
            try
            {
                categories.Attributes.Remove("class");
                this.chkTitlesOnly.Checked = false;
                Dictionary<string, string> queryParams = new Dictionary<string, string>();
                string textParam;
                textParam = this.GetTextParam();
                h1dd3nld.Value = strID; //.Substring(0, strID.IndexOf("["));
                if (String.IsNullOrEmpty(textParam) == false)
                    queryParams.Add("text", textParam);

                queryParams.Add("print", "all");
                queryParams.Add("Highlight", "Terms");
                queryParams.Add("action", "Query");
                queryParams.Add("statematchid", strID + "[" + strHit + "]");
                queryParams.Add("StartTag", "<span class='hit'>");

                queryParams.Add("QuerySummary", "true");

                XMLQuery1.Service service = new LimsSearch.XMLQuery1.Service();

                //Get the query results
                string[] parms; //string array to use to send to Web service
                string strXml;  //to store the result returned by Web service

                parms = ConvertDict2Array(queryParams);
                strXml = service.QueryAutonomy(parms);
                strXml = ca.gc.justice.lims.library.Xml.XMLUtilities.EncodeSpanTag(strXml);

                XmlDocument xDoc = new XmlDocument();
                xDoc.LoadXml(strXml);
                currentResult = new Result(xDoc);

                queryParams.Add("TotalResults", "true");
                queryParams["statematchid"] = strID; //.Substring(0, strID.IndexOf("["));
                queryParams.Add("noresults", "true");
                parms = ConvertDict2Array(queryParams);
                strXml = service.QueryAutonomy(parms);
                currentResult.TotalHits = UsefulMethodsWithNowhereElse2Go.GetTotalHitsFromXML(strXml);
                queryParams.Remove("noresults");

                if (queryParams.ContainsKey("TotalResults"))
                    queryParams.Remove("TotalResults");
                queryParams.Remove("action");
                queryParams.Add("action", "GetQueryTagValues");
                queryParams.Add("DocumentCount", "True");
                queryParams.Add("Sort", "DocumentCount");
                queryParams.Add("FieldName", "Legis/_ATTR_LawType");
                parms = ConvertDict2Array(queryParams);
                //Label1.Text = String.Join("&", parms);
                strXml = service.QueryAutonomy(parms);
                xDoc.LoadXml(strXml);
                currentResult.GetCategories(xDoc, CategoryType.LAWTYPE, false);

                queryParams["FieldName"] = "Title";
                parms = ConvertDict2Array(queryParams);
                strXml = service.QueryAutonomy(parms);
                xDoc.LoadXml(strXml);
                currentResult.GetCategories(xDoc, CategoryType.LAWTITLE, false);

                //remove the class=hidden setting
                bottomPanel.Attributes.Remove("class");
                categories.Attributes.Remove("class");
                results.Attributes["class"] = "mainContent";
                //rptRelatedTerms.DataSource = currentResult.RelatedPhrases;
                //rptRelatedTerms.DataBind();
                rptContentTypes.DataSource = currentResult.LawTypes;
                rptContentTypes.DataBind();

                rptAlphas.DataSource = currentResult.LawTitles; //.Alphas;
                rptAlphas.DataBind();

                searchResults.DataSource = currentResult.Hits;
                searchResults.DataBind();

                createResultsDisplayInfoAndPageNav(1, 1);
            }
            catch (Exception e)
            {
                ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile("Exception in LoadResult : " + DateTime.Now.ToShortDateString() + e.Message);
            }
        }

        private void readSearchParams()
        {
            searchParams = new UserSearchParams(this.Request, true);
        }

        private void populateFormValues()
        {
            if (searchParams.Keywords != null)
                this.txtS3archA11.Text = searchParams.Keywords;

            if (searchParams.Title != null)
                this.txtT1tl3.Text = searchParams.Title;

            if (searchParams.ContentType != null)
            {
                switch (searchParams.ContentType)
                {
                    case "Acts":
                        this.ddC0nt3ntTyp3.SelectedValue = "Statutes";
                        break;
                    case "Table of Private Acts":
                        this.ddC0nt3ntTyp3.SelectedValue = "TOPA";
                        break;
                    case "Table of Public Statutes":
                        this.ddC0nt3ntTyp3.SelectedValue = "TOPS";
                        break;
                    default:
                        ddC0nt3ntTyp3.SelectedValue = searchParams.ContentType;
                        break;
                }
            }

            if (searchParams.PageNum != null)
                this.h1dd3nPag3Num.Value = searchParams.PageNum;

            this.chkTitlesOnly.Checked = searchParams.HitsOnly;
        }

        private void doSearch()
        {
            try
            {

                string textParam = "";
                string fieldTextParam = "";

                int pagenum = Convert.ToInt32(this.h1dd3nPag3Num.Value);
                int startParam = ((pagenum - 1) * maxResults) + 1;
                //build the Text= portion of the Query
                Dictionary<string, string> queryParams = new Dictionary<string, string>();

                textParam = this.GetTextParam();

                if (!String.IsNullOrEmpty(textParam))
                {
                    queryParams.Add("text", textParam);
                    fieldTextParam += "NOT+MATCH{true}:*/Legis/_ATTR_tocfragment+AND+";
                    textIsEmpty = false;
                }
                else
                {
                    // no text param?
                    textIsEmpty = true;
                    if (String.IsNullOrEmpty(txtT1tl3.Text))
                    {
                        // No title and no text was specified.
                        return;
                    }
                    fieldTextParam += "MATCH{true}:*/Legis/_ATTR_tocfragment+AND+";
                }

                switch (ddC0nt3ntTyp3.SelectedItem.Value)
                {
                    case "Statutes":
                        fieldTextParam += "MATCH{Acts}:Legis/_ATTR_LawType";
                        break;
                    case "Regulations":
                        fieldTextParam += "MATCH{Regulations}:Legis/_ATTR_LawType";
                        break;
                    case "ActsRegs":
                        fieldTextParam += "(MATCH{Regulations}:Legis/_ATTR_LawType+OR+MATCH{Acts}:Legis/_ATTR_LawType)";
                        break;
                    case "All":
                        fieldTextParam += "EXISTS{}:Legis/_ATTR_LawType";
                        break;
                    default:
                        fieldTextParam += "MATCH{" + ddC0nt3ntTyp3.SelectedItem.Value + "}:Legis/_ATTR_LawType";
                        break;
                }

                //Set language of query
                fieldTextParam += "+AND+MATCH{en}:Legis/_ATTR_Language";
                // Only search in-force fragments
                //fieldTextParam += "+AND+(NOT+MATCH{False}:Legis/_ATTR_in-force)";
                // Only current PIT
                fieldTextParam += "+AND+(RANGE{01/01/9998,02/02/9999}:InForceEnd+OR+EMPTY{}:InForceEnd)";

                if (!String.IsNullOrEmpty(txtT1tl3.Text))
                {
                    //fieldTextParam += "+AND+WILD{*" + txtT1tl3.Text + "*}:Title:LongTitle";
                    List<string> fieldParams = UsefulMethodsWithNowhereElse2Go.CreateFieldTextArgs(txtT1tl3.Text, "Title:LongTitle");
                    foreach (string s in fieldParams)
                    {
                        fieldTextParam += "+AND+" + s;
                    }
                }


                if (!String.IsNullOrEmpty(fieldTextParam))
                    queryParams.Add("FieldText", fieldTextParam);

                queryParams.Add("noresults", "true");
                queryParams.Add("MaxResults", "2000");

                //SearchService.Service service = new SearchService.Service();
                XMLQuery1.Service service = new LimsSearch.XMLQuery1.Service();

                //Get the query results
                string[] parms; //string array to use to send to Web service
                string strXml;  //to store the result returned by Web service

                string strStateToken;
                if (this.searchParams != null && !String.IsNullOrEmpty(this.searchParams.AutonomyID))
                {
                    strStateToken = this.searchParams.AutonomyID;
                    queryParams.Add("statematchid", strStateToken);
                    parms = ConvertDict2Array(queryParams);
                }
                else
                {
                    // Let's try storing a state and then using it again and again with Autonomy:
                    queryParams.Add("storestate", "true");
                    parms = ConvertDict2Array(queryParams);
                    strStateToken = service.GetTokenState(parms);
                }

                bool useToken = true;
                if (String.IsNullOrEmpty(strStateToken))
                {
                    // Failed to get the token for some reason
                    useToken = false;
                }
                else
                {
                    //strStateToken += "[" + (startParam - 1).ToString() + "-" + ((maxResults * pagenum) - 1).ToString() + "]";
                    h1dd3nld.Value = strStateToken;
                }

                queryParams.Remove("storestate");
                queryParams.Remove("noresults");
                if (useToken && queryParams.ContainsKey("statematchid") == false)
                    queryParams.Add("statematchid", strStateToken);


                if (!this.chkTitlesOnly.Checked)
                    queryParams.Add("print", "all");
                else //dont return the big text fields if we dont need them
                {
                    queryParams.Add("print", "fields");
                    queryParams.Add("printfields", "Legis,Legis/_ATTR_Language,Legis/_ATTR_tocfragment,Legis/_ATTR_LawType,EnablingAuthority/AuthorityTitle,InforceEnd,AlphaNum,OfficialAlphaNumber,OfficialAlphaNumber/*,Link,Title,Title/*,Section/Label,Schedule/ScheduleFormHeading/Label,ScheduleFormHeading/TitleText,LongTitle,LongTitle/*");
                }

                queryParams.Add("QuerySummary", "true");
                queryParams.Add("AnyLanguage", "true");
                queryParams.Add("TotalResults", "true");
                queryParams["MaxResults"] = (maxResults * pagenum).ToString();
                //queryParams.Add("MaxResults", (maxResults * pagenum).ToString());
                queryParams.Add("Start", startParam.ToString());
                //queryParams.Add("DatabaseMatch", LimsSearch.Properties.Settings.Default.AutonomyDB);

                if (String.IsNullOrEmpty(textParam) == false && !this.chkTitlesOnly.Checked)
                {
                    queryParams.Add("Highlight", "Terms");
                    //queryParams.Add("MatchAllTerms", "true"); //removed because we now have separate AND OR NOT boxes
                    queryParams.Add("StartTag", "<span class='hit'>");
                }


                parms = ConvertDict2Array(queryParams);
                strXml = service.QueryAutonomy(parms);
                strXml = ca.gc.justice.lims.library.Xml.XMLUtilities.EncodeSpanTag(strXml);

                XmlDocument xDoc = new XmlDocument();
                xDoc.LoadXml(strXml);
                currentResult = new Result(xDoc);
                if (currentResult.Successful)
                {

                    //Query Autonomy again to get the categories totals
                    if (queryParams.ContainsKey("storestate"))
                        queryParams.Remove("storestate");
                    if (queryParams.ContainsKey("MaxResults"))
                        queryParams.Remove("MaxResults");
                    if (queryParams.ContainsKey("Start"))
                        queryParams.Remove("Start");
                    queryParams.Add("action", "GetQueryTagValues");
                    queryParams.Add("DocumentCount", "True");
                    queryParams.Add("Sort", "DocumentCount");
                    queryParams.Add("FieldName", "Legis/_ATTR_LawType");
                    parms = ConvertDict2Array(queryParams);
                    //Label1.Text = String.Join("&", parms);
                    strXml = service.QueryAutonomy(parms);

                    xDoc.LoadXml(strXml);
                    currentResult.GetCategories(xDoc, CategoryType.LAWTYPE, false);

                    queryParams["FieldName"] = "Title,Title/*";
                    parms = ConvertDict2Array(queryParams);
                    strXml = service.QueryAutonomy(parms);
                    xDoc.LoadXml(strXml);
                    currentResult.GetCategories(xDoc, CategoryType.LAWTITLE, false);


                    //remove the class=hidden setting
                    bottomPanel.Attributes.Remove("class");

                    rptContentTypes.DataSource = currentResult.LawTypes;
                    rptContentTypes.DataBind();
                    rptAlphas.DataSource = currentResult.LawTitles; //.Alphas;
                    rptAlphas.DataBind();

                    categories.Attributes.Remove("class");
                    results.Attributes["class"] = "mainContent";
                    searchResults.DataSource = currentResult.Hits;
                    searchResults.DataBind();

                    createResultsDisplayInfoAndPageNav(pagenum, startParam);
                }
                else if (currentResult.Response == "responseexception") //not successful query
                {
                    ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile("ResponseException : " + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString());
                    if (!String.IsNullOrEmpty(strXml))
                    {
                        ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile(strXml);
                        ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile("SEARCH PARAMS " + ca.gc.justice.lims.library.Xml.XMLUtilities.concatArray(parms));

                        if (strXml.Contains("stopwords"))
                        {
                            createErrorPage("responseexception");
                        }
                        else
                        {
                            createErrorPage("error");
                        }
                    }
                    else
                        createErrorPage("error");
                }
                else
                {
                    ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile("Not Success from Autonomy : " + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString());
                    if (!String.IsNullOrEmpty(strXml))
                        ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile(strXml);
                    ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile("SEARCH PARAMS " + ca.gc.justice.lims.library.Xml.XMLUtilities.concatArray(parms));

                    createErrorPage("error");
                }
            }
            catch (Exception e)
            {
                ca.gc.justice.lims.library.Xml.XMLUtilities.UpdateLogFile("Exception in doSearch : " + DateTime.Now.ToShortDateString() + e.Message);
                createErrorPage("error");
            }
        }


        private void createErrorPage(string errorType)
        {
            if (errorType == "error")
            {
                Label1.Text = "The search application is temporarily unavailable. Please try again later.";
                bottomPanel.Attributes.Remove("class");
                results.Attributes["class"] = "mainContent";
            }
            else if (errorType == "responseexception")
            {
                Label1.Text = "The search application was unable to process your query due to an invalid request.  Please adjust the search terms and try again.";
                bottomPanel.Attributes.Remove("class");
                results.Attributes["class"] = "mainContent";
            }
        }

        public string GetTextParam()
        {
            string textParam = "";
            if (!String.IsNullOrEmpty(txtS3archA11.Text))
            {
                //string[] splitTerms = txtS3archT3rms.Text.Split(" ");
                if (txtS3archA11.Text.Contains("\""))
                {// Leave the quotes for an exact phrase search
                    textParam += txtS3archA11.Text.Trim();
                }
                else
                {
                    //fix to strip out spaces and strip brackets
                    textParam += txtS3archA11.Text.Trim().Replace("  ", " ").Replace("(","").Replace(")","").Replace(" ", "+AND+");
                }
            }
            return textParam;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            doSearch();
        }

        private void createResultsDisplayInfoAndPageNav(int pagenum, int startParam)
        {
            if (searchParams != null && !String.IsNullOrEmpty(this.searchParams.AutonomyID) && !String.IsNullOrEmpty(this.searchParams.HitNumber))
            {
                Label1.Text = "Result ";
                divPageNav.Attributes.Remove("class"); //move hidden class
                divPageNav2.Attributes.Remove("class");

                string hitID = this.searchParams.HitNumber;
                int hitid = -1;
                try
                {
                    hitid = Convert.ToInt16(hitID);
                }
                catch { }
                string pageLinks = "";
                Label1.Text += (hitid + 1).ToString() + " of " + currentResult.TotalHits.ToString();
                //if (currentResult.TotalHits == 1)
                //    Label1.Text = "Displaying the only result";
                Label2.Text = "Didn't find what you're looking for? <br /><a href='http://search-recherche.gc.ca/rGs/s_r?st=s&s5bm3ts21rch=x&num=10&st1rt=0&langs=eng&cdn=canada&q=" + txtS3archA11.Text + "'>Search all Government of Canada websites</a>";
                if (hitid > 0)
                {
                    pageLinks += "<a href='" + this.BuildQueryString(filterType.PreviousID, hitID, true) + "'>Previous Result</a>";
                    pageLinks += " | ";
                }
                pageLinks += "<a href='" + this.BuildQueryString(filterType.PageID, hitID, false) + "'>Back to search results</a>";
                if (hitid >= 0 && (hitid + 1) < currentResult.TotalHits)
                {
                    pageLinks += " | ";
                    pageLinks += "<a href='" + this.BuildQueryString(filterType.NextID, hitID, true) + "'>Next Result</a>";
                }
                divPageNav.InnerHtml = pageLinks;
                divPageNav2.InnerHtml = pageLinks;

            }
            else if (currentResult.TotalHits > maxResults)
            {  //multiple pages are needed
                int lastResultOnPage = Math.Min((maxResults * pagenum), currentResult.TotalHits);
                Label1.Text = "Results " + startParam.ToString() + "-" + lastResultOnPage.ToString()
                            + " of " + currentResult.TotalHits;
                Label2.Text = "Didn't find what you're looking for? <br /><a href='http://search-recherche.gc.ca/rGs/s_r?st=s&s5bm3ts21rch=x&num=10&st1rt=0&langs=eng&cdn=canada&q=" + txtS3archA11.Text + "'>Search all Government of Canada websites</a>";
                int nextpage = pagenum + 1;
                int prevpage = pagenum - 1;
                int lastpage = Convert.ToInt32(Math.Ceiling((double)currentResult.TotalHits / maxResults));
                divPageNav.Attributes.Remove("class"); //move hidden class
                divPageNav2.Attributes.Remove("class");

                string pageLinks = "";
                if (prevpage > 0)
                {
                    pageLinks += "<a href='" + this.BuildQueryString(filterType.Page, prevpage, ! this.chkTitlesOnly.Checked) + "'>Previous Results Page</a>";
                }
                if (prevpage > 0 && nextpage <= lastpage)
                {
                    pageLinks += " | ";
                }
                if (nextpage <= lastpage)
                {
                    pageLinks += "<a href='" + this.BuildQueryString(filterType.Page, nextpage, ! this.chkTitlesOnly.Checked) + "'>Next Results Page</a>";
                }

                divPageNav.InnerHtml = pageLinks;
                divPageNav2.InnerHtml = pageLinks;

            }
            else //all results on a single page
            {
                Label1.Text = currentResult.HitsReturned + " result";
                if (currentResult.HitsReturned > 1)
                    Label1.Text += "s";
                Label2.Text = "Didn't find what you're looking for? <br /><a href='http://search-recherche.gc.ca/rGs/s_r?st=s&s5bm3ts21rch=x&num=10&st1rt=0&langs=eng&cdn=canada&q=" + txtS3archA11.Text + "'>Search all Government of Canada websites</a>";
            }
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

        //builds the querystring attached to the links on the results page - for subsearches
        public string BuildQueryString(filterType ft, object ob, bool hitsOnlyOff)
        {
            string contentType;
            string exactPhrase = "";
            string title = "";
            string pageNum = "1"; //Reset search to page one
            string stateId = "";
            string strHitNumber = "";

            StringBuilder sb = new StringBuilder();
            sb.Append("Search.aspx?");

            //gather the values to use in the query string
            contentType = HttpUtility.UrlEncode(ddC0nt3ntTyp3.SelectedValue);

            if (!String.IsNullOrEmpty(txtT1tl3.Text))
                title = HttpUtility.UrlEncode(txtT1tl3.Text);

            if (!String.IsNullOrEmpty(this.h1dd3nld.Value) && (this.h1dd3nld.Value != "0"))
                stateId = HttpUtility.UrlEncode(this.h1dd3nld.Value);

            //if (!String.IsNullOrEmpty(this.txtS3arch3xact.Value))
            //    exactPhrase = txtS3arch3xact.Value;

            switch (ft)
            {
                case filterType.Related:
                    exactPhrase = HttpUtility.UrlEncode(ob.ToString());
                    break;
                case filterType.LawTitle: //override title field if an exact phrase title is selected
                    //title = HttpUtility.UrlEncode(ob.ToString());
                    title = HttpUtility.UrlEncode("\"" + ob.ToString() + "\"");
                    stateId = ""; // force the creation of a new state token
                    break;
                case filterType.AllTitles:
                    title = "";
                    stateId = ""; // force the creation of a new state token
                    break;
                case filterType.LawType:
                    contentType = HttpUtility.UrlEncode(ob.ToString());
                    stateId = ""; // force the creation of a new state token
                    break;
                case filterType.Page:
                    pageNum = ob.ToString();
                    break;
                case filterType.ID:
                    int hitNum = Convert.ToInt32(ob); //hit number for this page
                    int hitNum2 = hitNum + ((Convert.ToInt32(h1dd3nPag3Num.Value) - 1) * maxResults); //actual hit number in result set
                    strHitNumber = hitNum2.ToString();
                    //stateId = HttpUtility.UrlEncode(this.h1dd3nld.Value + "[" + hitNum2 + "]");
                    break;
                case filterType.PreviousID:
                    int previousHit = Convert.ToInt32(ob) - 1; //hit number for the hit before
                    strHitNumber = previousHit.ToString();
                    //stateId = HttpUtility.UrlEncode(this.h1dd3nld.Value + "[" + previousHit + "]");
                    break;
                case filterType.NextID:
                    int nextHit = Convert.ToInt32(ob) + 1; //hit number for the hit before
                    strHitNumber = nextHit.ToString();
                    //stateId = HttpUtility.UrlEncode(this.h1dd3nld.Value + "[" + nextHit + "]");
                    break;
                case filterType.PageID:
                    int intHit = 0;
                    try
                    {
                        intHit = Convert.ToInt16(ob);
                        if (intHit > 0)
                        {
                            // Need to figure out what page we should be on
                            int remainder = intHit % maxResults;
                            intHit -= remainder;
                            intHit = intHit / maxResults;
                        }
                    }
                    catch { }
                    intHit++;
                    pageNum = intHit.ToString();
                    //remainder = pageCount + 10;
                    //sb.Append("&h1ts0n1y=1");
                    //stateId = HttpUtility.UrlEncode(this.h1dd3nld.Value + "[" + pageCount.ToString() + "-" + remainder.ToString() + "]");
                    break;
            }

            if (!String.IsNullOrEmpty(stateId))
                sb.Append("&amp;h1dd3n1d=" + stateId);

            if (!String.IsNullOrEmpty(strHitNumber))
                sb.Append("&amp;h1tNumb3r=" + strHitNumber);

            if (!String.IsNullOrEmpty(contentType))
                sb.Append("&amp;ddC0nt3ntTyp3=" + contentType);

            if (!String.IsNullOrEmpty(exactPhrase))
                sb.Append("&amp;txtS3arch3xact=" + exactPhrase);

            if (!String.IsNullOrEmpty(pageNum))
                sb.Append("&amp;h1dd3nPag3Num=" + pageNum);

            if (!String.IsNullOrEmpty(title))
                sb.Append("&amp;txtT1tl3=" + title);

            if (!String.IsNullOrEmpty(txtS3archA11.Text))
                sb.Append("&amp;txtS3archA11=" + HttpUtility.UrlEncode(txtS3archA11.Text));

            if (hitsOnlyOff == true)
                sb.Append("&amp;h1ts0n1y=0");
            else
                sb.Append("&amp;h1ts0n1y=1");

            return sb.ToString() + "#results";
        }

        //Called from the aspx page repeater to process the link to the hit
        public string GetHitLink(object dataItem)
        {
            string link;
            Hit theHit = (Hit)dataItem;
            link = theHit.Reference.ToString();
            return link.Replace(" ", "%20");
        }

        public string WriteAllTitlesLink()
        {
            string txt="";
            if (!String.IsNullOrEmpty(this.txtT1tl3.Text))
            {
                txt = "<li class='allCategoryLink'><a href='" + this.BuildQueryString(filterType.AllTitles, "", ! this.chkTitlesOnly.Checked)+ "'>All</a></li>";
            }

            return txt;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            //Server.Transfer("Advanced.aspx");
            clearForm();
        }

        private void clearForm()
        {
            txtS3archA11.Text = "";   
            txtT1tl3.Text = "";
            ddC0nt3ntTyp3.SelectedIndex = 0;
            //txtS3arch3xact.Value = "";
        }
    }
}
