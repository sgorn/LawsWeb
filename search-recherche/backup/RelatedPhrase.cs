using System;
using System.Collections.Generic;
using System.Web;

namespace LimsSearch
{
    public class RelatedPhrase
    {
        private string phrase;
        public string Phrase
        {
            get { return phrase; }
        }

        private int docs;
        public int Docs
        {
            get { return docs; }
        }

        private int totalHits;
        public int TotalHits
        {
            get { return totalHits; }
        }

        public RelatedPhrase(string p, int d, int h)
        {
            phrase = p;
            docs = d;
            totalHits = h;
        }
    }
}
