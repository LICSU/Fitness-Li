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
    public partial class AlumnoClases : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "", AlumnoID="";
        string sSelectSQL="", sSelectSQL2 ="";
        DataTable dt;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            AlumnoID = Request.QueryString["user"];
            if (!IsPostBack)
            {
                _autenticado = new UsuarioAutenticado(fIdentity);                
                sSelectSQL = "SELECT Alumno_Nivel_Clase.ClaseID as VAL, " +
                                " Clase.ClaseDescripcion as TXT " +
                                " FROM Alumno_Nivel_Clase INNER JOIN" +
                                " Clase ON Alumno_Nivel_Clase.ClaseID = Clase.ClaseID" +
                                " WHERE (Alumno_Nivel_Clase.UsuarioID = " + AlumnoID + ")";
                Utilidades.CargarListado(ref dplClasesUsuario, sSelectSQL, cn, ref Err, true);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView1.Rows[index];
            if (e.CommandName.Equals("Evaluar"))
            {
                hdfAluNivClaseID.Value = (gvrow.FindControl("AluNivClaseID") as Label).Text;
                hdfClaseElemNivID.Value = (gvrow.FindControl("ClaseElemNivID") as Label).Text;
                hdfClaseID.Value = (gvrow.FindControl("ClaseID") as Label).Text;
                txtClaseEdit.Text = (gvrow.FindControl("ClaseDescripcion") as Label).Text;
                txtElementoEdit.Text = (gvrow.FindControl("ElementoNombre") as Label).Text;
                sSelectSQL2 = "SELECT Calificacion.CalificacionNombre as TXT, " +
                            " Calificacion.CalificacionID as VAL " +
                            " FROM Calificacion INNER JOIN" +
                            " TipCalificacion ON Calificacion.TipoCalificacionID = TipCalificacion.TipoCalificacionID INNER JOIN" +
                            " Clase ON TipCalificacion.TipoCalificacionID = Clase.TipoCalificacionID" +
                            " WHERE (Clase.ClaseID = "+hdfClaseID.Value+")";
                Utilidades.CargarListado(ref dplCalificacion, sSelectSQL2, cn, ref Err, true);
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalEvaluar').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ViewModalScript", sb.ToString(), false);
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

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

        protected void dplClasesUsuario_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Mostrar el Grid de Evaluaciones..
            if (dplClasesUsuario.SelectedValue != "")
            {
                sSelectSQL = "SELECT Nivel.NivelID as NivelID, Alumno_Nivel_Clase.AluNivClaseID as AluNivClaseID, " +
                            " Clase.ClaseDescripcion as ClaseDescripcion, " +
                            " Clase_Nivel_Elemento.ClaseElemNivID as ClaseElemNivID, " +
                            " Alumno_Nivel_Clase.ClaseID as ClaseID, " +
                            " Elemento.ElementoNombre as ElementoNombre, " +
                            " Alumno_Nivel_Clase.UsuarioID as UsuarioID" +
                            " FROM Alumno_Nivel_Clase INNER JOIN" +
                            " Clase ON Alumno_Nivel_Clase.ClaseID = Clase.ClaseID INNER JOIN" +
                            " Clase_Nivel_Elemento ON Clase.ClaseID = Clase_Nivel_Elemento.ClaseID INNER JOIN" +
                            " Nivel ON Alumno_Nivel_Clase.NivelID = Nivel.NivelID AND Clase_Nivel_Elemento.NivelID = Nivel.NivelID INNER JOIN" +
                            " Elemento ON Clase_Nivel_Elemento.ElementoID = Elemento.ElementoID" +
                            " WHERE (Alumno_Nivel_Clase.UsuarioID = " + AlumnoID + " AND Clase.ClaseID = " + dplClasesUsuario.SelectedValue + ")";
                
                BindGridView(sSelectSQL);
            }
        }
        protected void BindGridView(string cmd2)
        {
            try
            {
                cn.Open();
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "AluNivClaseID";
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dplCalificacion.SelectedValue != "")
            {
                int iRes = 0;
                string AluNivClaseID = hdfAluNivClaseID.Value;
                string CalificacionID = dplCalificacion.SelectedValue;
                string ClaseElemNivID = hdfClaseElemNivID.Value;
                sSelectSQL = " INSERT INTO Alumno_Nivel_Clase_Elemento "+
                             " (CalificacionID, AluNivClaseID, ClaseElemNivID, AlumNivClasElemFechaReg, AlumNivClasElemUsuaReg, SalonID)" +
                             " VALUES("+CalificacionID+", "+AluNivClaseID+", "+ClaseElemNivID+", SYSDATETIME(), 1, 0)";
                cn.Open();
                try 
                {
                    SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                    iRes = addCmd.ExecuteNonQuery();
                    cn.Close();
                }
                catch (SqlException sq) 
                {
                    Err = sq.Message;
                    cn.Close();
                }
                if (iRes > 0) 
                {
                    dplCalificacion.SelectedValue = "";
                    MostrarMsjModal("Evaluación Exitosa", "EXI");
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("document.getElementById('closeEdit').click();");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
                }
                else
                {
                    MostrarMsjModal("Error al guardar el registro: " + Err, "ERR");
                }
            }
        }
    }
}