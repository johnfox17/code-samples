using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            WindIntensityService.Service1Client myPxy = new WindIntensityService.Service1Client();
            decimal latitude = System.Convert.ToDecimal(this.textBox1.Text);
            decimal longitude = System.Convert.ToDecimal(this.textBox2.Text);
            decimal result = myPxy.WindIntensity(latitude,longitude);
            this.label3.Text = result.ToString();
        }
    }
}
