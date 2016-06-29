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
    public partial class verCalificaciones : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "", AlumnoID = "";
        string sSelectSQL = "", sSelectSQL2 = "";
        string clases = "", alumno = ""; 
        DataTable dt;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                clases = Request.QueryString["clase"];
                alumno = Request.QueryString["user"];
                ViewState["sSelectSQL2"] = "SELECT " +
                               " Alumno_Nivel_Clase_Elemento.AlumNivClasElemID as AlumNivClasElemID, " +
                               " Alumno_Nivel_Clase_Elemento.CalificacionID as CalificacionID, " +
                               " (SELECT CalificacionNombre FROM Calificacion " +
                               " where CalificacionID = Alumno_Nivel_Clase_Elemento.CalificacionID) as CalificacionNombre," +
                               " Alumno_Nivel_Clase.ClaseID as ClaseID, " +
                               " (SELECT ClaseDescripcion FROM Clase WHERE ClaseID = Alumno_Nivel_Clase.ClaseID) as ClaseDescripcion," +
                               " Clase_Nivel_Elemento.ElementoID as ElementoID," +
                               " (SELECT ElementoNombre FROM Elemento WHERE ElementoID = Clase_Nivel_Elemento.ElementoID) as ElementoNombre" +
                               " FROM Alumno_Nivel_Clase_Elemento INNER JOIN" +
                               " Alumno_Nivel_Clase ON Alumno_Nivel_Clase_Elemento.AluNivClaseID = Alumno_Nivel_Clase.AluNivClaseID INNER JOIN" +
                               " Clase_Nivel_Elemento ON Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID AND " +
                               " Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID" +
                               " WHERE (Alumno_Nivel_Clase.ClaseID = " + clases + " AND " +
                               " Alumno_Nivel_Clase.UsuarioID = " + alumno + ")";
                BindGridView2();
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }
        protected void BindGridView2()
        {
            try
            {
                cn.Open();
                string cmd2 = ViewState["sSelectSQL2"].ToString();
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "AlumNivClasElemID";
                GridView2.DataKeyNames = TablaID;
                GridView2.DataSource = dt;
                GridView2.DataBind();
                cn.Close();
            }
            catch (SqlException ex)
            {
                Err += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
                MostrarMsjModal(Err, "ERR");
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