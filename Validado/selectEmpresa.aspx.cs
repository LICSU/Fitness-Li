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
    public partial class selectEmpresa : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        string Err = "", sSelectSQL = "";
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sSelectSQL = "SELECT ClienteID AS VAL, ClienteNombre AS TXT FROM Cliente ORDER BY TXT";
                Utilidades.CargarListado(ref dplUnidad, sSelectSQL, cn, ref Err, true);
            }
        }

        protected void ddlPlan_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dplUnidad.SelectedValue != "")
            {
                Response.Redirect("crearUsuarios.aspx?cliente=" + dplUnidad.SelectedValue);
            }
        }

    }
}