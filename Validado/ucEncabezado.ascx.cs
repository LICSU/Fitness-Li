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
    public partial class ucEncabezado : System.Web.UI.UserControl
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        //SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnStringMedical"].ConnectionString);
        string sSelectSql = "", Err = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!fIdentity.IsAuthenticated)
            {
                Response.Redirect("default.aspx");
            }
            _autenticado = new UsuarioAutenticado(fIdentity);
        }
//
        protected void lnkCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            string sHttpCookie = FormsAuthentication.FormsCookieName;
            if (Request.Cookies[sHttpCookie] != null)
            {
                Response.Cookies[sHttpCookie].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
            Response.Redirect("~/Validado/Ingreso.aspx");
        }

        protected void estadisticas_Click(object sender, ImageClickEventArgs e)
        {
            /*sSelectSql = "Select Nombre FROM Empresa";
            string p = Utilidades.EjeSQL(sSelectSql, cn, ref Err, true);
            lblPrueba.Text = p;
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarEstadisticas2", "MostrarEstadisticas2();", true);*/
        }


        protected void medidas_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarMedidas", "MostrarMedidas();", true);
        }
    }
}