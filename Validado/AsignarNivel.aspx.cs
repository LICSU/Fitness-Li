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
    public partial class AsignarNivel : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "";
        string sSelectSQL;
        DataTable dt;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

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
                string cmd2 = "SELECT Alumno_Nivel_Clase.AluNivClaseID as AluNivClaseID, " +
                        " Alumno_Nivel_Clase.UsuarioID as UsuarioID, "+
                        " Alumno_Nivel_Clase.ClaseID as ClaseID, "+
                        " Alumno_Nivel_Clase.NivelID as NivelID, "+
                        " (SELECT UsuarioNombre FROM Usuario WHERE UsuarioID = Alumno_Nivel_Clase.UsuarioID) as UsuarioNombre, "+
                        " (SELECT UsuarioApellido FROM Usuario WHERE UsuarioID = Alumno_Nivel_Clase.UsuarioID) as UsuarioApellido, "+
                        " (SELECT UsuarioCedula FROM Usuario WHERE UsuarioID = Alumno_Nivel_Clase.UsuarioID) as UsuarioCedula,"+
                        " Clase.ClaseDescripcion as ClaseDescripcion,"+
                        " Nivel.NivelNombre as NivelNombre"+
                        " FROM Alumno_Nivel_Clase INNER JOIN"+
                        " Clase ON Alumno_Nivel_Clase.ClaseID = Clase.ClaseID INNER JOIN"+
                        " Nivel ON Alumno_Nivel_Clase.NivelID = Nivel.NivelID WHERE Alumno_Nivel_Clase.ProfesorID = " + _autenticado.UsuarioID + " " + ViewState["sWhere"];
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
            }
        }

        protected void BindGridView2()
        {
            try
            {
                cn.Open();
                string cmd2 = "SELECT Reserva.ReservaID, " +
                            " Reserva.UsuarioID as AlumnoID, " +
                            " ClasePlantilla.ClaseID as ClaseID," +
                            " ClasePlantilla.ProfesorID," +
                            " (SELECT ClaseDescripcion FROM Clase WHERE ClaseID = ClasePlantilla.ClaseID) as ClaseDescripcion," +
                            " (SELECT UsuarioNombre FROM Usuario WHERE UsuarioID = Reserva.UsuarioID) as UsuarioNombre," +
                            " (SELECT UsuarioApellido FROM Usuario WHERE UsuarioID = Reserva.UsuarioID) as UsuarioApellido," +
                            " (SELECT UsuarioCedula FROM Usuario WHERE UsuarioID = Reserva.UsuarioID) as UsuarioCedula" +
                            " FROM Reserva INNER JOIN" +
                            " ClasePlantilla ON Reserva.ClasePlantillaID = ClasePlantilla.ClasePlantillaID INNER JOIN" +
                            " Clase ON ClasePlantilla.ClaseID = Clase.ClaseID AND ClasePlantilla.ProfesorID = " + _autenticado.UsuarioID+
                            " WHERE (SELECT UsuarioCedula FROM Usuario WHERE UsuarioID =  Reserva.UsuarioID) LIKE '%" + txtAlumnoAdd.Text + "%'";

                //MostrarMsjModal(cmd2, "");
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "AlumnoID";
                GridView2.DataKeyNames = TablaID;
                GridView2.DataSource = dt;
                GridView2.DataBind();
                cn.Close();
            }
            catch (SqlException ex)
            {
                Err += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
                MostrarMsjModal(Err, "");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView1.Rows[index];
            if (e.CommandName.Equals("ModificarNivel"))
            {
                sSelectSQL = "SELECT NivelID AS VAL, NivelNombre AS TXT FROM Nivel ORDER BY TXT";
                Utilidades.CargarListado(ref dplNivelMod, sSelectSQL, cn, ref Err, true);
                hdfAluNivClaseID.Value = (gvrow.FindControl("AluNivClaseID") as Label).Text;
                txtClaseMod.Text = (gvrow.FindControl("ClaseDescripcion") as Label).Text;
                txtAlumnoMod.Text = (gvrow.FindControl("UsuarioNombre") as Label).Text;
                dplNivelMod.SelectedValue = (gvrow.FindControl("NivelID") as Label).Text;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#editModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ViewModalScript", sb.ToString(), false);
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
           //BUSCAR
            try
            {
                string sBuscar = txtSearch.Text.Trim();
                if (sBuscar != "")
                { ViewState["sWhere"] = "AND ((SELECT UsuarioCedula FROM Usuario WHERE UsuarioID =Alumno_Nivel_Clase.UsuarioID) LIKE '%"+sBuscar+"%'"+
                    " OR (SELECT UsuarioNombre FROM Usuario WHERE UsuarioID =Alumno_Nivel_Clase.UsuarioID) LIKE '%" + sBuscar + "%'"+
                    " OR (SELECT UsuarioApellido FROM Usuario WHERE UsuarioID =Alumno_Nivel_Clase.UsuarioID) LIKE '%" + sBuscar + "%' )";
                }
                else
                { ViewState["sWhere"] = ""; }
                BindGridView();
            }
            catch (Exception ex)
            {
                Err += "Error al buscar el registro. Detalle: " + ex.Message.Replace("'", "") + ". ";
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string ClaseID = hdfClaseID.Value;
            string UsuarioID = hdfAlumnoID.Value;
            string NivelID = dplNivel.SelectedValue;
            sSelectSQL = "INSERT INTO Alumno_Nivel_Clase "+
                        " (UsuarioID, "+
                        " ClaseID, NivelID, "+
                        " AluNivClaseFechaRegistro, AluNivClaseUsuarioRegistro, ProfesorID)"+
                        " VALUES ("+UsuarioID+", "+ClaseID+", "+NivelID+", SYSDATETIME(), 1, "+_autenticado.UsuarioID+")";
            //
            Err = "";
            Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
            if (Err == "")
            {
                //enviarEmail(UsuarioID, ClaseID, NivelID,"INS");
                dplNivel.SelectedValue = "";
                txtAlumnoAdd.Text = "";
                txtClaseAdd.Text = "";
                BindGridView();
                MostrarMsjModal("Nivel Asignado Exitosamente", "EXI");
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('closeAdd').click();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);                
            }
            else 
            {
                MostrarMsjModal("Error al Asignar el Nivel: "+Err, "ERR");
            }

        }

        protected void enviarEmail(string UsuarioID, string ClaseID, string NivelID, string Accion)
        {
            string UsuarioCorreo = Utilidades.EjeSQL("SELECT UsuarioCorreo FROM Usuario WHERE UsuarioID = "+UsuarioID, cn, ref Err, true);
            //Validar Correo
            if (Utilidades.EmailValido(UsuarioCorreo))
            {
                string ClaseDescripcion = Utilidades.EjeSQL("SELECT ClaseDescripcion FROM Clase WHERE ClaseID = " + ClaseID, cn, ref Err, true);
                string NivelNombre = Utilidades.EjeSQL("SELECT NivelNombre FROM Nivel WHERE NivelID = " + NivelID, cn, ref Err, true);
                string UsuarioNombre = Utilidades.EjeSQL("SELECT UsuarioNombre FROM Usuario WHERE UsuarioID = " + UsuarioID, cn, ref Err, true);
                string ProfesorNombre = Utilidades.EjeSQL("SELECT UsuarioNombre FROM Usuario WHERE UsuarioID = " + _autenticado.UsuarioID, cn, ref Err, true);
                string asunto = "Nuevo Nivel Asignado!";
                string cuerpo ="";
                if(Accion == "INS")
                    cuerpo = "Sr(a) "+UsuarioNombre+"\n\n Felicitaciones el(la) Profesor(a): "+ProfesorNombre+" te ha asignado el nivel :"+NivelNombre+" para la"+
                    " clase: "+ClaseDescripcion+".\n\n Saludos.";
                else
                    cuerpo = "Sr(a) "+UsuarioNombre+"\n\n Felicitaciones el(la) Profesor(a): "+ProfesorNombre+" te ha actualizado el nivel a :"+NivelNombre+" para la"+
                    " clase: "+ClaseDescripcion+".\n\n Saludos.";
                Utilidades.EnviarCorreo(UsuarioCorreo, asunto, cuerpo, ref Err);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string NivelID = dplNivelMod.SelectedValue;
            string AluNivClaseID = hdfAluNivClaseID.Value;
            string UsuarioID = Utilidades.EjeSQL("SELECT UsuarioID From Alumno_Nivel_Clase WHERE AluNivClaseID = " + AluNivClaseID, cn, ref Err, true);
            string ClaseID = Utilidades.EjeSQL("SELECT ClaseID From Alumno_Nivel_Clase WHERE AluNivClaseID = " + AluNivClaseID, cn, ref Err, true);

            int iRes = 0;
            sSelectSQL = "UPDATE Alumno_Nivel_Clase SET NivelID = " + NivelID + " WHERE AluNivClaseID = " + AluNivClaseID;
            cn.Open();
            SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
            try { iRes = addCmd.ExecuteNonQuery(); }
            catch (SqlException sq) { Err = sq.Message; }
            cn.Close();
            if (iRes > 0)
            {
                BindGridView();
                //enviarEmail(UsuarioID, ClaseID, NivelID,"MOD");
                MostrarMsjModal("Registro Editado exitosamente", "EXI");
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('closeEdit').click();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);
            }
            else
            {
                MostrarMsjModal("Error al Modificar el Registro", "ERR");
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

        protected void Agregar_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#addModal').modal({ show: true });");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ViewModalScript", sb.ToString(), false);
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView2.Rows[index];
            if (e.CommandName.Equals("selectRecord"))
            {
                sSelectSQL = "SELECT NivelID AS VAL, NivelNombre AS TXT FROM Nivel ORDER BY TXT";
                Utilidades.CargarListado(ref dplNivel, sSelectSQL, cn, ref Err, true);
                txtAlumnoAdd.Text = (gvrow.FindControl("UsuarioCedulaB") as Label).Text;
                txtClaseAdd.Text = (gvrow.FindControl("ClaseDescripcionB") as Label).Text;
                hdfAlumnoID.Value = (gvrow.FindControl("UsuarioIDB") as Label).Text;
                hdfClaseID.Value = (gvrow.FindControl("ClaseIDB") as Label).Text;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('bscModal').click();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.EditIndex = -1;
            GridView2.SelectedIndex = -1;
            GridView2.PageIndex = e.NewPageIndex;
            BindGridView2();
        }

        protected void BuscarUsr_Click(object sender, EventArgs e)
        {
            BindGridView2();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#bscModal').modal({ show: true });");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ViewModalScript", sb.ToString(), false);
        }

    }
}