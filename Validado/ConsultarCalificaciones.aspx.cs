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
    public partial class ConsultarCalificaciones : System.Web.UI.Page
    {
        string Err = "", sSelectSQL = "";
        DataTable dt;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;

        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity);
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        protected void BindGridView()
        {
            try
            {
                cn.Open();
                string cmd2 = " SELECT " +
                            " Reserva.ReservaID as ReservaID, " +
                            " ClasePlantilla.ClasePlantillaID as ClasePlantillaID, " +
                            " Reserva.UsuarioID as UsuarioID, " +
                            " (Select UsuarioNombre From Usuario WHERE UsuarioID = Reserva.UsuarioID) as UsuarioNombre," +
                            " (Select UsuarioApellido From Usuario WHERE UsuarioID = Reserva.UsuarioID) as UsuarioApellido," +
                            " (Select UsuarioCedula From Usuario WHERE UsuarioID = Reserva.UsuarioID) as UsuarioCedula," +
                            " ClasePlantilla.ProfesorID as ProfesorID, " +
                            " (Select ClienteNombre from Cliente Where ClienteID = ClasePlantilla.ClienteID) as ClienteNombre," +
                            " ClasePlantilla.ClienteID as ClienteID" +
                            " FROM ClasePlantilla " +
                            " INNER JOIN Reserva ON ClasePlantilla.ClasePlantillaID = Reserva.ClasePlantillaID" +
                            " WHERE (ClasePlantilla.ProfesorID = " + _autenticado.UsuarioID + ")";
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "ReservaID";
                GridView1.DataKeyNames = TablaID;
                GridView1.DataSource = dt;
                GridView1.DataBind();
                cn.Close();
            }
            catch (SqlException ex)
            {
                Err += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
                MostrarMsjModal(Err, "ERR");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView1.Rows[index];
            if (e.CommandName.Equals("consultarAlumno"))
            {
                string UsuarioID = (gvrow.FindControl("UsuarioID") as Label).Text;
                Response.Redirect("AlumnoClasesC.aspx?user=" + UsuarioID);
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