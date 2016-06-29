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

namespace LicsuWeb
{
    public partial class index : System.Web.UI.Page
    {
        string Err = "", sSelecSQL = "", sErr = "";
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            cargarImagenes();
        }

        protected void cargarImagenes()
        { 
            //Cargar cada una de las imagenes de los botones..
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

        protected void imgButton1_Click(object sender, ImageClickEventArgs e)
        {
        }

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
                                Response.Redirect("Validado/Inicio.aspx");
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

        private void MostrarImagen() {
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarImagen", "MostrarImagen();", true);
        }

        protected void video1_Click(object sender, EventArgs e)
        {
            lpVideo.Visible = false;
            Literal literal = new Literal();
            literal.Text = sSelecSQL;
            lpVideo.Visible = false;
            lpImage.Visible = true;
            imagen1.Visible = true;
            phImagen.Visible = false;
            lblAviso.Attributes.CssStyle.Add("opacity", "1");
            videoCentral.Attributes.CssStyle.Add("opacity", "1");
            if (sender.Equals(video1))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video1'";
            }
            else if (sender.Equals(video2))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video2'";
            }
            else if (sender.Equals(video3))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video3'";
            }
            else if (sender.Equals(video4))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video4'";
            }
            else if (sender.Equals(video5))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video5'";
            }
            else if (sender.Equals(video6))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video6'";
            }
            else if (sender.Equals(video7))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video7'";
            }
            else if (sender.Equals(video8))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video8'";
            }
            else if (sender.Equals(video9))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video9'";
            }
            else if (sender.Equals(video10))
            {
                sSelecSQL = "SELECT UrlVideo FROM Videos WHERE NumeroVideo = 'video10'";
            }

            string UrlVideo = Utilidades.EjeSQL(sSelecSQL, cn, ref Err, true) + "?autoplay=1&controls=0&showinfo=0&rel=0";
            literal.Text = "<iframe class='redondo2' width='260' height='190' src='" + UrlVideo + "' frameborder='0' allowfullscreen></iframe>";
            panelCentral.Controls.Add(literal);
        }
    }
}