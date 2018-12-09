using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Web;


namespace WcfService1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {
        public decimal WindIntensity(decimal latitude, decimal longitude)
        {
            //Current directory path where XML data is located
            string path = HttpRuntime.AppDomainAppPath;


            string XMLLocale = Path.Combine(HttpRuntime.AppDomainAppPath, @"App_data/data.txt");


            //Loding data
            string[] text = System.IO.File.ReadAllLines(@XMLLocale);
            //Creating dictionary to store key value pairs
            Dictionary<string, string> AveAnnualWindSpeedDic = new Dictionary<string, string>();

            //Split key value pairs and add them into the dictionary
            foreach (string line in text)
            {
                string[] aux = SplitColumns(line);
                AveAnnualWindSpeedDic.Add((string)aux[1], (string)aux[0]);
            }

            //Concatenate latitud and longitud into a string
            string LatLon = latitude.ToString() + "_" + longitude.ToString();
            //Look for the vaue corresponding to a specific lat and lon
            decimal aveWind = System.Convert.ToDecimal(AveAnnualWindSpeedDic[LatLon]);

            return aveWind;
        }
        
        static string[] SplitColumns(string s)
        {
            return Regex.Split(s, @"\s+");
        }

    }
}
