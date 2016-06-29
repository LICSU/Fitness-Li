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
    public partial class Evaluaciones : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "", AlumnoID = "";
        string sSelectSQL = "", sSelectSQL2 = "";
        DataTable dt;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity); 
            //CARGAR LA LISTA DE LAS CLASES QUE PERTENECEN A ESE PROFESOR.
            if (!IsPostBack)
            {
                sSelectSQL = "SELECT DISTINCT(dbo.ClasePlantilla.ClasePlantillaID) as VAL, " +
                            "(dbo.Clase.ClaseDescripcion+' '+ " +
                            "dbo.ClasePlantilla.ClasePlantillaFecha+' '+ " +
                            "dbo.ClasePlantilla.ClasePlantillaHora) as TXT " +
                            "FROM dbo.ClasePlantilla INNER JOIN " +
                            "dbo.Reserva ON dbo.ClasePlantilla.ClasePlantillaID = dbo.Reserva.ClasePlantillaID INNER JOIN " +
                            "dbo.Clase ON dbo.ClasePlantilla.ClaseID = dbo.Clase.ClaseID " +
                            "WHERE (dbo.ClasePlantilla.ProfesorID = "+_autenticado.UsuarioID+") AND " +
                            "CONVERT(date,ClasePlantilla.ClasePlantillaFecha,103) = CONVERT(date,GETDATE(),103) ";
                //MostrarMsjModal(sSelectSQL, "");
                Utilidades.CargarListado(ref dplClases, sSelectSQL, cn, ref Err, true);
            }
        }

        protected void dplClases_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dplClases.SelectedValue != "")
            {
                sSelectSQL = "SELECT " +
                            " DISTINCT(UsuarioID) as ID, Reserva.UsuarioID as VAL, (SELECT UsuarioNombre+' '+UsuarioApellido+' '+UsuarioCedula " +
                                " FROM Usuario WHERE UsuarioID = Reserva.UsuarioID) as TXT" +
                            " FROM ClasePlantilla INNER JOIN" +
                            " Reserva ON ClasePlantilla.ClasePlantillaID = Reserva.ClasePlantillaID" +
                            " WHERE ClasePlantilla.ClasePlantillaID = " + dplClases.SelectedValue + " AND ClasePlantilla.ProfesorID = " + _autenticado.UsuarioID + "" +
                            " AND CONVERT(date,ClasePlantilla.ClasePlantillaFecha,103) >= CONVERT(date, GETDATE(),103)";
                //MostrarMsjModal(sSelectSQL, "");
                Utilidades.CargarListado(ref dplAlumnos, sSelectSQL, cn, ref Err, true);
                dplAlumnos.Enabled = true;
            }
            
        }

        protected void dplAlumnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dplAlumnos.SelectedValue != "")
            {
                string claseid = Utilidades.EjeSQL("SELECT ClaseID From ClasePlantilla WHERE ClasePlantillaID = "+dplClases.SelectedValue, cn, ref Err, true);
                ViewState["sSelectSQL"] = "SELECT Nivel.NivelID as NivelID, Alumno_Nivel_Clase.AluNivClaseID as AluNivClaseID, " +
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
                            " WHERE (Alumno_Nivel_Clase.UsuarioID = " + dplAlumnos.SelectedValue + " AND Clase.ClaseID = " + claseid + ")";
                BindGridView();
                ViewState["sSelectSQL2"] = "SELECT "+
                               " Alumno_Nivel_Clase_Elemento.AlumNivClasElemID as AlumNivClasElemID, "+
                               " Alumno_Nivel_Clase_Elemento.CalificacionID as CalificacionID, "+
                               " (SELECT CalificacionNombre FROM Calificacion "+
                               " where CalificacionID = Alumno_Nivel_Clase_Elemento.CalificacionID) as CalificacionNombre,"+
                               " Alumno_Nivel_Clase.ClaseID as ClaseID, "+
                               " (SELECT ClaseDescripcion FROM Clase WHERE ClaseID = Alumno_Nivel_Clase.ClaseID) as ClaseDescripcion,"+
                               " Clase_Nivel_Elemento.ElementoID as ElementoID,"+
                               " (SELECT ElementoNombre FROM Elemento WHERE ElementoID = Clase_Nivel_Elemento.ElementoID) as ElementoNombre"+
                               " FROM Alumno_Nivel_Clase_Elemento INNER JOIN"+
                               " Alumno_Nivel_Clase ON Alumno_Nivel_Clase_Elemento.AluNivClaseID = Alumno_Nivel_Clase.AluNivClaseID INNER JOIN"+
                               " Clase_Nivel_Elemento ON Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID AND "+
                               " Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID"+
                               " WHERE (Alumno_Nivel_Clase.ClaseID = " + claseid + " AND " +
                               " Alumno_Nivel_Clase.UsuarioID = "+dplAlumnos.SelectedValue+")";
                BindGridView2();
                /*sSelectSQL2 = "SELECT ClasePlantilla.ClasePlantillaFecha as Fecha, "+
                                " ClasePlantilla.ClasePlantillaHora as Hora "+
                                " FROM Reserva INNER JOIN"+
                                " ClasePlantilla ON Reserva.ClasePlantillaID = ClasePlantilla.ClasePlantillaID"+
                                " WHERE (ClasePlantilla.ClaseID = "+dplClases.SelectedValue+") AND (Reserva.UsuarioID = "+dplAlumnos.SelectedValue+")";
                
                cn.Open();
                SqlCommand cmd = new SqlCommand(sSelectSQL2, cn);
                SqlDataReader dr = cmd.ExecuteReader();
                try
                {
                    if (dr.Read())
                    {
                        //totalClases = dr["totalClases"].ToString();
                        fechaClase.Text = "Fecha de la Clase: "+dr["Fecha"].ToString()+" "+dr["Hora"].ToString();
                    }
                    cn.Close();
                }
                catch (SqlException sq) { Err = sq.Message; cn.Close(); }*/
                fechaClase.Text = "Fecha de la Clase: " + dplClases.SelectedItem.Text;
            }
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
        protected void BindGridView()
        {
            try
            {
                cn.Open();
                string cmd2 = ViewState["sSelectSQL"].ToString();
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
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
                            " WHERE (Clase.ClaseID = " + hdfClaseID.Value + ")";
                Utilidades.CargarListado(ref dplCalificacion, sSelectSQL2, cn, ref Err, true);
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalEvaluar').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ViewModalScript", sb.ToString(), false);
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

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView2.Rows[index];
            if (e.CommandName.Equals("Modificar"))
            {
                hdfAlumNivClasElemID.Value = (gvrow.FindControl("AlumNivClasElemID") as Label).Text;
                txtClaseModificar.Text = (gvrow.FindControl("ClaseDescripcion") as Label).Text;
                txtElementoModificar.Text = (gvrow.FindControl("ElementoNombre") as Label).Text;
                hdfClaseIDMod.Value = (gvrow.FindControl("ClaseID") as Label).Text;
                sSelectSQL2 = "SELECT Calificacion.CalificacionNombre as TXT, " +
                            " Calificacion.CalificacionID as VAL " +
                            " FROM Calificacion INNER JOIN" +
                            " TipCalificacion ON Calificacion.TipoCalificacionID = TipCalificacion.TipoCalificacionID INNER JOIN" +
                            " Clase ON TipCalificacion.TipoCalificacionID = Clase.TipoCalificacionID" +
                            " WHERE (Clase.ClaseID = " + hdfClaseIDMod.Value + ")";
                Utilidades.CargarListado(ref dplCalificacionMod, sSelectSQL2, cn, ref Err, true);
                dplCalificacionMod.SelectedValue = (gvrow.FindControl("CalificacionID") as Label).Text;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalModificar').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ViewModalScript", sb.ToString(), false);
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.EditIndex = -1;
            GridView2.SelectedIndex = -1;
            GridView2.PageIndex = e.NewPageIndex;
            BindGridView2();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int iRes = 0;
            string AluNivClaseID = hdfAluNivClaseID.Value;
            string CalificacionID = dplCalificacion.SelectedValue;
            string ClaseElemNivID = hdfClaseElemNivID.Value;
            sSelectSQL = " INSERT INTO Alumno_Nivel_Clase_Elemento " +
                         " (CalificacionID, AluNivClaseID, ClaseElemNivID, AlumNivClasElemFechaReg, AlumNivClasElemUsuaReg, SalonID)" +
                         " VALUES(" + CalificacionID + ", " + AluNivClaseID + ", " + ClaseElemNivID + ", SYSDATETIME(), 1, 0)";
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
                BindGridView2();
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

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            int iRes = 0;
            string AlumNivClasElemID = hdfAlumNivClasElemID.Value;
            string CalificacionID = dplCalificacionMod.SelectedValue;
            sSelectSQL = " UPDATE Alumno_Nivel_Clase_Elemento SET CalificacionID = "+CalificacionID+
            " WHERE AlumNivClasElemID = "+AlumNivClasElemID;
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
                BindGridView2();
                MostrarMsjModal("Modificación Exitosa", "EXI");
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('closeEdit1').click();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);

            }
            else
            {
                MostrarMsjModal("Error al guardar el registro: " + Err, "ERR");
            }
        }

        protected void txtClasesAuto_TextChanged(object sender, EventArgs e)
        {
            sSelectSQL = "SELECT DISTINCT(ClasePlantilla.ClasePlantillaID) as ID, (Clase.ClaseDescripcion+' '+ClasePlantilla.ClasePlantillaFecha+' '+ClasePlantilla.ClasePlantillaHora) as TXT, " +
                            " Clase.ClaseID as VAL" +
                            " FROM ClasePlantilla INNER JOIN" +
                            " Reserva ON ClasePlantilla.ClasePlantillaID = Reserva.ClasePlantillaID INNER JOIN" +
                            " Clase ON ClasePlantilla.ClaseID = Clase.ClaseID" +
                            " WHERE (ClasePlantilla.ProfesorID = " + _autenticado.UsuarioID + ") AND "+
                            " CONVERT(date,ClasePlantilla.ClasePlantillaFecha,103) >= CONVERT(date,GETDATE(),103) " +
                            " AND (Clase.ClaseDescripcion LIKE '%" + txtClasesAuto.Text + "%' "+
                            " OR ClasePlantilla.ClasePlantillaFecha LIKE '%" + txtClasesAuto.Text + "%' OR ClasePlantilla.ClasePlantillaHora LIKE '%" + txtClasesAuto.Text + "%')";
            //MostrarMsjModal(sSelectSQL, "");
            dplClases.Items.Clear();
            Utilidades.CargarListado(ref dplClases, sSelectSQL, cn, ref Err, true);
        }
    }
}