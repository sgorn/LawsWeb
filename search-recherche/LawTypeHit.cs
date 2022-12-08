using System;
using System.Collections.Generic;
using System.Web;

namespace LimsSearch
{
    public class CategoryHit
    {
        private string typeName;
        public string TypeName
        {
            get { return typeName; }
            set { typeName = value; }
        }
        private int numDocs;
        public int NumDocs
        {
            get { return numDocs; }
            set { numDocs = value; }
        }

        public CategoryHit(string name, int num)
        {
            numDocs = num;
            typeName = name;
        }
    }
}
