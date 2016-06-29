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
using System.Reflection;

namespace LicsuWeb.Validado
{
    public partial class Ingreso : System.Web.UI.Page
    {
//
        SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["conexion"].ToString());
        string sErr = "";
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
            if (Request.QueryString["r"] == "exi")
            {
                MostrarMsjModal("Registro realizado con éxito. Ingresa con tú número de Cédula y Clave elegida.", "EXI");
                //PropertyInfo isreadonly = typeof(System.Collections.Specialized.NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                // make collection editable
                //isreadonly.SetValue(this.Request.QueryString, false, null);
                // remove
                //this.Request.QueryString.Remove("registro");
                
            }
        }
//
        protected void bAceptar_Click(object sender, EventArgs e)
        {
            string vSql = "";
            string CodigoUsuario = Usuario.Text.Trim();
            //string ClaveEncriptada = LicsuWeb.Clases.Encriptado.Encrypt(Clave.Text.Trim());
            string ClaveEncriptada = Clave.Text.Trim();
            // 0:Activo  1:UsuarioID  2:Nombre  3:SucursalID  4:RolID  5:ClienteID
            if (CodigoUsuario != "" && ClaveEncriptada != "")
            {
                vSql = "SELECT CAST(UsuarioActivo as VARCHAR(1))+'|'+CAST(U.UsuarioID as VARCHAR(20))+'|'+UsuarioNombre+' '+UsuarioApellido+'|'+CAST(SucursalID as VARCHAR(12))+'|'+CAST(ISNULL(ClienteID,'') as VARCHAR(20))+'|'+CAST(RolID as VARCHAR(4)) FROM dbo.Usuario U INNER JOIN dbo.UsuarioRol UR ON U.UsuarioID=UR.UsuarioID WHERE UsuarioCedula='" + CodigoUsuario + "' AND UsuarioClave='" + ClaveEncriptada + "'";
                lblValidado.Text = "PRUEBA";
                lblValidado.ForeColor = System.Drawing.Color.Red;
                string ResUsuario = Utilidades.EjeSQL(vSql, cn, ref sErr);
                if (sErr == string.Empty && ResUsuario != "-1")
                {
                    if (ResUsuario != string.Empty)
                    {
                        string[] aUsuario = ResUsuario.Split('|');
                        if (aUsuario.Length == 6)
                        {
                            if (aUsuario[0] == "1") //Usuario Activo
                            {
                                string sUsuarioID = aUsuario[1];
                                string sPlanID = "";
                                sPlanID = Utilidades.EjeSQL("SELECT TOP 1 PlanID FROM PlanAlumno WHERE UsuarioID=" + sUsuarioID, cn, ref sErr);
                                //0: UsuarioID  1:Nombre  2:SucursalID  3:ClienteID 4:PlanID
                                FormsAuthenticationTicket Tck = new FormsAuthenticationTicket(1, sUsuarioID + "|" + aUsuario[2] + "|" + aUsuario[3] + "|" + aUsuario[4] + "|" + sPlanID, DateTime.Now, DateTime.Now.AddHours(24), false, aUsuario[5], FormsAuthentication.FormsCookiePath);
                                Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(Tck)));
                                Response.Redirect("Inicio.aspx");
                            }
                            else
                            {
                                sErr = "Usuario no activo, consulte al Administrador";
                                MostrarMsjModal(sErr, "ERR");
                            }
                        }
                        else
                        {
                            sErr = "Error en la sentencia de búsqueda a la base de datos";
                            MostrarMsjModal(sErr, "ERR");
                        }
                    }
                    else
                    {
                        sErr = "Usuario no existe o clave inválida";
                        MostrarMsjModal(sErr, "ERR");
                    }
                }
            }
            else
            {
                MostrarMsjModal("Ingrese los datos solicitados", "ERR");
            } 
        }
//
        private void Page_PreRenderComplete(object sender, EventArgs e)
        {
            if (sErr != string.Empty)
            {
                lblValidado.Text = sErr;
                lblValidado.ForeColor = System.Drawing.Color.Red;
                lblValidado.Visible = true;
                Usuario.Text = "";
                Clave.Text = "";
            }
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
    }

}