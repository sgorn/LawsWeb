using System;
using System.Collections.Generic;
using System.Web;

namespace LimsSearch
{
    public class TermHit
    {
        private string term;
        public string Term
        {
            get { return term; }
        }
        private string context;
        public string Context
        {
            get { return context; }
        }

        public TermHit(string t, string c)
        {
            term = t;
            context = c;
        }
    }

   

}
