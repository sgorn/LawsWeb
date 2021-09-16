using System;
using System.Collections.Generic;
using System.Web;

namespace LimsSearch
{
    public class UserSearchParams
    {
        private string keywords;
        public string Keywords
        {
            get { return keywords; }
            set { keywords = value; }
        }

        private string keywordsExact;
        public string KeywordsExact
        {
            get { return keywordsExact; }
            set { keywordsExact = value; }
        }
        private string keywordsNot;
        public string KeywordsNot
        {
            get { return keywordsNot; }
            set { keywordsNot = value; }
        }

        private string keywordsOr;
        public string KeywordsOr
        {
            get { return keywordsOr; }
            set { keywordsOr = value; }
        }

        private string autonomyID;
        public string AutonomyID
        {
            get { return autonomyID; }
            set { autonomyID = value; }
        }

        private string hitNumber;
        public string HitNumber
        {
            get { return hitNumber; }
            set { hitNumber = value; }
        }

        private string title;
        public string Title
        {
            get { return title; }
            set { title = value; }
        }

        private string alphanum;
        public string Alphanum
        {
            get { return alphanum; }
            set { alphanum = value; }
        }

        private string contentType;
        public string ContentType
        {
            get { return contentType; }
            set { contentType = value; }
        }

        private string inforceDate;
        public string InforceDate
        {
            get { return inforceDate; }
            set { inforceDate = value; }
        }

        private string enablingAct;
        public string EnablingAct
        {
            get { return enablingAct; }
            set { enablingAct = value; }
        }
        private string pageNum;
        public string PageNum
        {
            get { return pageNum; }
            set { pageNum = value; }
        }

        private bool hitsOnly;
        public bool HitsOnly
        {
            get { return hitsOnly; }
            set { this.hitsOnly = value; }
        }

        public UserSearchParams(string keyw, string w1, string dist, string w2, string tle, string alpha, 
                                        string contype, string inf, string eAct, string pNum)
        {
            keywords = keyw;
            title = tle;
            alphanum = alpha;
            contentType = contype;
            inforceDate = inf;
            enablingAct = eAct;
            pageNum = pNum;
        }

        public UserSearchParams(HttpRequest req, bool defaultHitsOnlySetting)
        {
            keywords = req.Params["txtS3archA11"];
            keywordsOr = req.Params["txtS3arch0r"];
            keywordsExact = req.Params["txtS3arch3xact"];
            keywordsNot = req.Params["txtS3archN0t"];
            title = req.Params["txtT1tl3"];
            alphanum = req.Params["txtAlpha"];
            contentType = req.Params["ddC0nt3ntTyp3"];
            inforceDate = req.Params["inf0rc3Dat3"];
            enablingAct = req.Params["txt3nabl3dBy"];
            pageNum = req.Params["h1dd3nPag3Num"];
            autonomyID = req.Params["h1dd3n1d"];
            hitNumber = req.Params["h1tNumb3r"];
            //links = req.Params["l1nks"];
            string hit = req.Params["h1ts0n1y"];
            if (String.IsNullOrEmpty(req.Params["h1ts0n1y"]))
                hitsOnly = defaultHitsOnlySetting;
            else
                hitsOnly = hit == "1";
        }
    }
}
