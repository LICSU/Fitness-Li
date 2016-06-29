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
namespace LicsuWeb.Validado
{
    public partial class Perfil : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "";
        GridView grid;
        DataTable dt;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);
        string sSelectSQL = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!fIdentity.IsAuthenticated)
            {
                Response.Redirect("default.aspx");
            }
            _autenticado = new UsuarioAutenticado(fIdentity);
            if (!IsPostBack)
            {                
                if (_autenticado.RolID == "2")
                {
                    phProfesor.Visible = true;
                }
                else
                {
                    phProfesor.Visible = false;
                }
                CargarDatosUsuario();
            }
        }
        //
        private void CargarDatosUsuario()
        {
            sSelectSQL = "SELECT * FROM Usuario WHERE UsuarioID=" + _autenticado.UsuarioID;
            SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = cn;
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                while (dr.Read())
                {
                    txtNombre.Text = dr["UsuarioNombre"].ToString();
                    txtApellido.Text = dr["UsuarioApellido"].ToString();
                    txtCedula.Text = dr["UsuarioCedula"].ToString();
                    txtCedula.Enabled = false;
                    txtEmail.Text = dr["UsuarioCorreo"].ToString();
                    txtFechaNacimiento.Text = dr["UsuarioFechaNacimiento"].ToString(); //(usuario.UsuarioFechaNacimiento == null) ? string.Empty : usuario.UsuarioFechaNacimiento.Value.ToShortDateString();
                    ddlEstadoCivil.SelectedValue = dr["UsuarioEstadoCivil"].ToString();
                    if (dr["UsuarioSexo"].ToString() == "F")
                        rdF.Checked = true;
                    else
                        rdM.Checked = true;
                    txtTelefono.Text = dr["UsuarioTelefono"].ToString();
                    txtCelular.Text = dr["UsuarioCelular1"].ToString();
                    txtCelular2.Text = dr["UsuarioCelular2"].ToString();
                    txtClaveNueva.Attributes.Add("value", dr["UsuarioClave"].ToString());
                    txtClaveRepetir.Attributes.Add("value", dr["UsuarioClave"].ToString());
                    txtObservacion.Text = dr["UsuarioObservacion"].ToString();
                    txtEPS.Text = dr["UsuarioEPS"].ToString();
                    txtRiesgos.Text = dr["UsuarioRiesgos"].ToString();
                    txtPension.Text = dr["UsuarioPension"].ToString();
                }
                //foto
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al obtener los datos del usuario. Detalle" + ex, "ERR");
            }
            finally
            {
                dr.Close();
                cn.Close();
            }
        }
        //
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                string UsuarioNombre = txtNombre.Text;
                string UsuarioApellido = txtApellido.Text;
                string UsuarioCorreo = txtEmail.Text;
                string UsuarioFechaNacimiento = txtFechaNacimiento.Text;
                string UsuarioTelefono = txtTelefono.Text;
                string UsuarioCelular1 = txtCelular.Text;
                string UsuarioCelular2 = txtCelular2.Text;
                string UsuarioRiesgo = txtRiesgos.Text;
                string UsuarioPension = txtPension.Text;
                string UsuarioClave = txtClaveNueva.Text;
                string UsuarioEdoCivil = ddlEstadoCivil.SelectedValue;
                string UsuarioSexo = "";
                if (rdM.Checked == true) UsuarioSexo = "M";
                else UsuarioSexo = "F";
                string UsuarioEPS = txtEPS.Text;
                string UsuarioObservacion = txtObservacion.Text;
                string sConn = System.Configuration.ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
                SqlConnection cn = new SqlConnection(sConn);
                string sSelect = "UPDATE Usuario SET UsuarioNombre = '" + UsuarioNombre + "'," +
                                " UsuarioApellido = '" + UsuarioApellido + "'," +
                                " UsuarioCorreo = '" + UsuarioCorreo + "'," +
                                " UsuarioFechaNacimiento = '" + UsuarioFechaNacimiento + "'," +
                                " UsuarioTelefono = '" + UsuarioTelefono + "'," +
                                " UsuarioCelular1 = '" + UsuarioCelular1 + "'," +
                                " UsuarioCelular2 = '" + UsuarioCelular2 + "'," +
                                " UsuarioPension = '" + UsuarioPension + "'," +
                                " UsuarioRiesgos = '" + UsuarioRiesgo + "'," +
                                " UsuarioClave = '" + UsuarioClave + "'," +
                                " UsuarioEstadoCivil = '" + UsuarioEdoCivil + "'," +
                                " UsuarioSexo = '" + UsuarioSexo + "'," +
                                " UsuarioEPS = '" + UsuarioEPS + "'," +
                                " UsuarioObservacion = '" + UsuarioObservacion + "'" +
                                " WHERE UsuarioID = " + _autenticado.UsuarioID;
                try
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(sSelect, cn);
                    int iRes = cmd.ExecuteNonQuery();
                    if (iRes > 0)
                        MostrarMsjModal("Datos Actualizados con Éxito", "EXI");
                    cn.Close();

                }
                catch (SqlException sq)
                {
                    MostrarMsjModal("Error: " + sq.Message, "ERR");
                    cn.Close();
                }
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error tratanto de actualizar datos del usuario "+ex.Message, "ERR");
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

        protected void lkAtras_Click(object sender, EventArgs e)
        {
            //Buscar Regresar a la Ultima Pagina
        }

    }
}