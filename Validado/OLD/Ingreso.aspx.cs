using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using LicsuWeb.Validado.Clases;

namespace LicsuWeb.Validado
{
    public partial class Ingreso : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["conexion"].ToString());
        string Err = "";
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            this.PreRenderComplete += new EventHandler(Page_PreRenderComplete);
            //if (!IsPostBack)
            //{
            //}
            lblValidado.Text = "Debe iniciar sesión primero";
            lblValidado.ForeColor = System.Drawing.Color.White;
            lblValidado.Visible = true;
            //Usuario.Focus();
        }
        protected void bAceptar_Click(object sender, EventArgs e)
        {
            string vSql = "";
            string CodigoUsuario = Usuario.Text.Trim();
            //string ClaveEncriptada = LicsuWeb.Clases.Encriptado.Encrypt(Clave.Text.Trim());
            string ClaveEncriptada = Clave.Text.Trim();
            // 0:Activo  1:UsuarioID  2:Nombre  3:SucursalID  4:RolID  5:ClienteID
            vSql = "SELECT CAST(UsuarioActivo as VARCHAR(1))+'|'+CAST(U.UsuarioID as VARCHAR(20))+'|'+UsuarioNombre+' '+UsuarioApellido+'|'+CAST(SucursalID as VARCHAR(12))+'|'+CAST(ISNULL(ClienteID,'') as VARCHAR(20))+'|'+CAST(RolID as VARCHAR(4)) FROM dbo.Usuario U INNER JOIN dbo.UsuarioRol UR ON U.UsuarioID=UR.UsuarioID WHERE UsuarioCedula='" + CodigoUsuario + "' AND UsuarioClave='" + ClaveEncriptada + "'";
            string ResUsuario = Utilidades.EjeSQL(vSql, cn, ref Err);
            if (Err == string.Empty && ResUsuario != "-1")
            {
                if (ResUsuario != string.Empty)
                {
                    string[] aUsuario = ResUsuario.Split('|');
                    if (aUsuario.Length == 6)
                    {
                        if (aUsuario[0] == "1") //Usuario Activo
                        {
                            //0: UsuarioID  1:Nombre  2:SucursalID  3:ClienteID
                            FormsAuthenticationTicket Tck = new FormsAuthenticationTicket(1, aUsuario[1] + "|" + aUsuario[2] + "|" + aUsuario[3] + "|" + aUsuario[4], DateTime.Now, DateTime.Now.AddHours(24), false, aUsuario[5], FormsAuthentication.FormsCookiePath);
                            Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(Tck)));
                            Response.Redirect("Inicio.aspx");
                        }
                        else
                            { Err = "Usuario no activo, consulte al Administrador"; }
                    }
                    else
                        {Err = "Error en la sentencia de búsqueda a la base de datos";}
                }
                else
                {
                    Err = "Usuario no existe o clave inválida";
                }
            }
        }
        private void Page_PreRenderComplete(object sender, EventArgs e)
        {
            if (Err != string.Empty)
            {
                lblValidado.Text = Err;
                lblValidado.ForeColor = System.Drawing.Color.Red;
                lblValidado.Visible = true;
                Usuario.Text = "";
                Clave.Text = "";
            }
        }
    }
}
