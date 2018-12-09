using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {
        public string WordFilter(string str)
        {
            //Array of stop words
            string[] StopWords = { "a", "above", "again", "all", "an", "any", "as", "be", "been", "being", "between", "but", "could", "do", "doing", "few", "from", "had", "have", "he", "he'll", "her", "here's",
            "herself", "himself", "how", "I", "I'll", "I've", "in", "is", "it's", "itself", "me", "most", "myself", "of", "once", "or", "ought", "ours", "out", "own", "she", "she'll", "should", "some", "than",
            "that's", "their", "them", "then", "there's", "they", "they'll", "they've", "those", "to", "under", "up", "was", "we'd", "we're", "were", "what's", "when's", "where's", "while", "who's", "why", "with",
            "you", "you'll", "you've", "yours", "yourselves", "about", "after", "against", "am", "and", "are", "at", "because", "before", "below", "both", "by", "did", "does", "down", "each", "for", "further",
            "has", "having", "he'd", "here", "he's", "hers", "him", "his", "how's", "I'd", "I'm", "if", "into", "it", "its", "let's", "more", "my", "nor", "on", "only", "other", "ours", "ourselves", "over", "same",
            "she's", "so", "such", "that", "the", "theirs", "themselves", "there", "these", "they'd", "they're", "this", "through", "too", "until", "very", "we", "we'll", "we've", "what", "when", "where", "which",
            "who", "whom", "why's", "would", "you'd", "you're", "your", "yourself"};

            //String where we are going to concatenate the final string 
            string FinalString = "-->";
            //Object that helps separate the string
            Regex rx = new Regex(@"\.?\s+?", RegexOptions.IgnoreCase);
            //Divide the string and saves it in an array
            string[] substrings = rx.Split(str);
            //Length of the array of the string
            int ArrayLength = substrings.Length;
            //Compare the array of the string with the array of StopWords defined aboved
            for (int i = 0; i < ArrayLength; i++)
            {
                bool Found = false;
                foreach (string stopWord in StopWords)
                    if (substrings[i] == stopWord)
                        Found = true;
                if (Found == false)
                    FinalString = FinalString + " " + substrings[i];
            }
            //Concatenates the string
            string sendString = FinalString.ToString();

            return sendString;
        }

        
    }
}
