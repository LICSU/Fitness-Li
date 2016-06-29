using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Security;
using LicsuWeb.Validado.Clases;
using System.Web.UI.HtmlControls;

namespace LicsuWeb.Validado
{
    public partial class FormularioPrueba : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        string Err = "", sSelectSQL = "";
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);
        //protected HtmlForm Form1;
        protected TextBox TextBox1;
        protected CheckBox CheckBox1;
        int contTxt = 0, contChk = 0;
        string cliente = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            cliente = Request.QueryString["cliente"];
            sSelectSQL = "SELECT Parametros.idParametro, "
                         + " Parametros.tipoParametro as tipoParametro, "
                         + " Parametros.labelParametro as labelParametro, "
                         + " Parametros.obserParametro obserParametro, "
                         + " Parametros.activoParametro as activoParametro, "
                         + " Parametros.ClienteID, "
                         + " Cliente.ClienteID AS Expr1"
                         + " FROM Cliente INNER JOIN"
                         + " Parametros ON Cliente.ClienteID = Parametros.ClienteID INNER JOIN"
                         + " TipoParametro ON Parametros.tipoParametro = TipoParametro.idTipoParametro"
                         + " WHERE (Cliente.ClienteID = " + cliente + " AND Parametros.activoParametro = 1) ";
            cn.Open();
            SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            string tipoParametro = "";
            try
            {
                while (dr.Read())
                {
                    tipoParametro = dr["tipoParametro"].ToString();
                    if (tipoParametro == "1")
                    {
                        //Creamos TEXTBOX
                        contTxt++;
                        agregarTextBox(dr["labelParametro"].ToString(), contTxt);
                    }
                    else if (tipoParametro == "2") 
                    {
                        contChk++;
                        agregarCheckbox(dr["labelParametro"].ToString(), contChk);
                    }
                }
                cn.Close();
            }
            catch (SqlException sq)
            {
                Err = sq.Message;
                cn.Close();
            }
        }
        protected void agregarTextBox(string ID, int cont) 
        {
            //Mostramos el Formulario
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='form-group'>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<label class='col-xs-4 control-label'>"+ID+": </label>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<div class='col-xs-6'>";
            panel1.Controls.Add(literal);
            TextBox1 = new TextBox();
            TextBox1.ID = "txtBox"+cont;
            TextBox1.CssClass = "form-control";
            panel1.Controls.Add(TextBox1);
            literal = new Literal();
            literal.Text = "<div class='col-xs-4'></div>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
        }

        protected void agregarCheckbox(string ID, int cont) 
        {
            //Mostramos el Formulario
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='form-group'>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<label class='col-xs-4 control-label'>"+ID+": </label>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<div class='col-xs-6'>";
            panel1.Controls.Add(literal);
            CheckBox1 = new CheckBox();
            CheckBox1.ID = "chkBox"+cont;
            CheckBox1.CssClass = "checkbox";
            panel1.Controls.Add(CheckBox1);
            literal = new Literal();
            literal.Text = "<div class='col-xs-4'></div>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
        }

        private void MostrarMsjModal(string msj, string tipo)
        {
            string sTitulo = "Información";
            string sCcsClase = "fa fa-check fa-2x text-info";
            switch (tipo)
            {
                case "ERR":
                    sTitulo = "ERROR";
                    sCcsClase = "fa fa-times fa-2x text-danger";
                    break;
                case "ADV":
                    sTitulo = "ADVERTENCIA"; //
                    sCcsClase = "fa fa-exclamation-triangle fa-2x text-warning";
                    break;
                case "EXI":
                    sTitulo = "ÉXITO";
                    sCcsClase = "fa fa-check fa-2x text-success";
                    break;
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarMsjModal", "MostrarMsjModal('" + msj.Replace("'", "").Replace("\r\n", " ") + "','" + sTitulo + "','" + sCcsClase + "');", true);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Panel p = (Panel)FindControl("panel1");
            String Cadena = "", Cadena2 ="";
            TextBox txtBox;
            CheckBox chkBox;
            for (int i = 1; i <= contTxt; i++) {
                txtBox = (TextBox)p.FindControl("txtBox"+i);
                Cadena = Cadena + txtBox.Text+", ";
            }
            for (int i = 1; i <= contChk; i++)
            {
                chkBox = (CheckBox)p.FindControl("chkBox" + i);
                Cadena2 = Cadena2 + chkBox.Checked + ", ";
            }
            MostrarMsjModal(Cadena + " " + Cadena2, "INF");
        }
    }
}