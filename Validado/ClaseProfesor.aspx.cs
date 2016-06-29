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
    public partial class ClaseProfesor : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["conexion"]);
        bool bHecho = false;
        string sMsj = "";
        string sErr = "";
        DataTable dt;
        string sTablaID = "ClaseProfesorID";
//
        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity);
            if (!IsPostBack)
            {
                CargarListados();
                ViewState["PlanID"] = ddlPlan.SelectedValue;
            }
            //BindGridView();
        }
//
        private void CargarListados()
        {
            string sSelectSQL = "";
            //Plan
            sSelectSQL = "SELECT ClienteID AS VAL, ClienteNombre AS TXT FROM [Cliente] ORDER BY VAL";
            Utilidades.CargarListado(ref ddlPlan, sSelectSQL, cn, ref sErr);
        }
        //
        protected void ddlPlan_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            ViewState["PlanID"] = ddlPlan.SelectedValue;
            BindGridView();
        }
        //
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string sBuscar = txtSearch.Text.Trim();
                if (sBuscar != "")
                { ViewState["sWhere"] = " AND ((ClaseDescripcion LIKE '%" + sBuscar + "%') OR (UsuarioNombre + ' ' + UsuarioApellido LIKE '%" + sBuscar + "%'))"; }
                else
                { ViewState["sWhere"] = ""; }
                BindGridView();
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al buscar el registro. Detalle: " + ex.Message, "ERR");
            }
        }
//
        protected void BindGridView()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
                SqlConnection conn = new SqlConnection(connString);
                conn.Open();
                string cmd = "SELECT TOP 120 ClaseProfesorID,SucursalID,CP.ClaseID,ISNULL(CP.NivelID,'') AS NivelID,CP.UsuarioID,ISNULL(S.SalonID,'') AS SalonID,C.ClaseDescripcion,N.NivelNombre,U.UsuarioNombre+' '+U.UsuarioApellido AS ProfesorNombre,S.SalonNombre,ClaseCupo,SalonTipoReserva,CONVERT(varchar, ClaseFechaInicio, 103) AS ClaseFechaInicio,ClaseHoraInicio FROM ClaseProfesor CP INNER JOIN Clase C ON CP.ClaseID=C.ClaseID LEFT OUTER JOIN Nivel N ON CP.NivelID=N.NivelID LEFT OUTER JOIN Usuario U ON CP.UsuarioID=U.UsuarioID LEFT OUTER JOIN Salon S ON CP.SalonID=S.SalonID WHERE PlanID=" + ViewState["PlanID"] + " AND ClaseFechaInicio >= DATEADD(d,-1,getdate()) " + ViewState["sWhere"] + " ORDER BY ClaseFechaInicio DESC, CAST(REPLACE(ClaseHoraInicio,':','') AS INT) DESC";
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd, conn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                GridView1.DataKeyNames = new string[] { sTablaID, "SucursalID", "ClaseID", "NivelID", "UsuarioID", "SalonID" };
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (SqlException ex)
            {
                MostrarMsjModal("Error al cargar el listado. Detalle: " + ex.Message, "ERR");
            }
        }
//
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }
//
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName.Equals("detail"))
            {
                Int64 sID = Int64.Parse(GridView1.DataKeys[index].Values[sTablaID].ToString());
                IEnumerable<DataRow> query = from i in dt.AsEnumerable()
                                             where i.Field<Int64>(sTablaID) == sID
                                             select i;
                DataTable detailTable = query.CopyToDataTable<DataRow>();
                DetailsView1.DataSource = detailTable;
                DetailsView1.DataBind();
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#detailModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("editRecord"))
            {
                CargarListadosMod();
                GridViewRow gvrow = GridView1.Rows[index];
                //txtMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[].Text);
                ddlClaseMod.SelectedIndex = ddlClaseMod.Items.IndexOf(ddlClaseMod.Items.FindByValue(GridView1.DataKeys[index].Values["ClaseID"].ToString()));
                ddlNivelMod.SelectedIndex = ddlNivelMod.Items.IndexOf(ddlNivelMod.Items.FindByValue(GridView1.DataKeys[index].Values["NivelID"].ToString()));
                ddlProfesorMod.SelectedIndex = ddlProfesorMod.Items.IndexOf(ddlProfesorMod.Items.FindByValue(GridView1.DataKeys[index].Values["UsuarioID"].ToString()));
                ddlSalonMod.SelectedIndex = ddlSalonMod.Items.IndexOf(ddlSalonMod.Items.FindByValue(GridView1.DataKeys[index].Values["SalonID"].ToString()));
                txtClaseCupoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[9].Text);
                txtSalonTipoReservaMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[10].Text);
                txtClaseFechaInicioMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[11].Text);
                ddlHoraMod.SelectedIndex = ddlHoraMod.Items.IndexOf(ddlHoraMod.Items.FindByValue(HttpUtility.HtmlDecode(gvrow.Cells[12].Text)));

                string sID = GridView1.DataKeys[index].Values[sTablaID].ToString();
                hfID.Value = sID;
                lblResult.Visible = false;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#editModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditModalScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("copyRecord"))
            {
                lblResult.Visible = false;
                CargarListadosNue();
                GridViewRow gvrow = GridView1.Rows[index];

                ddlClaseNue.SelectedIndex = ddlClaseNue.Items.IndexOf(ddlClaseNue.Items.FindByValue(GridView1.DataKeys[index].Values["ClaseID"].ToString()));
                ddlNivelNue.SelectedIndex = ddlNivelNue.Items.IndexOf(ddlNivelNue.Items.FindByValue(GridView1.DataKeys[index].Values["NivelID"].ToString()));
                ddlProfesorNue.SelectedIndex = ddlProfesorNue.Items.IndexOf(ddlProfesorNue.Items.FindByValue(GridView1.DataKeys[index].Values["UsuarioID"].ToString()));
                ddlSalonNue.SelectedIndex = ddlSalonNue.Items.IndexOf(ddlSalonNue.Items.FindByValue(GridView1.DataKeys[index].Values["SalonID"].ToString()));
                txtClaseCupoNue.Text = HttpUtility.HtmlDecode(gvrow.Cells[9].Text);
                txtSalonTipoReservaNue.Text = HttpUtility.HtmlDecode(gvrow.Cells[10].Text);
                txtClaseFechaInicioNue.Text = HttpUtility.HtmlDecode(gvrow.Cells[11].Text);
                ddlHoraNue.SelectedIndex = ddlHoraNue.Items.IndexOf(ddlHoraNue.Items.FindByValue(HttpUtility.HtmlDecode(gvrow.Cells[12].Text)));

                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#addModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddShowModalScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("deleteRecord"))
            {
                string sID = GridView1.DataKeys[index].Values[sTablaID].ToString();
                hfID.Value = sID;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#deleteModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DeleteModalScript", sb.ToString(), false);
            }
        }
        //
        private void CargarListadosMod()
        {
            string sSelectSQL = "";
            //Clases
            sSelectSQL = "SELECT ClaseID AS VAL, ClaseDescripcion AS TXT FROM [Clase] WHERE ClaseActiva=1 ORDER BY VAL";
            Utilidades.CargarListado(ref ddlClaseMod, sSelectSQL, cn, ref sErr, true);
            //Niveles
            sSelectSQL = "SELECT NivelID AS VAL, NivelNombre AS TXT FROM [Nivel] WHERE NivelActivo=1 ORDER BY NivelOrden";
            Utilidades.CargarListado(ref ddlNivelMod, sSelectSQL, cn, ref sErr, true);
            //Profesor
            sSelectSQL = "SELECT DISTINCT U.UsuarioID AS VAL, UsuarioNombre + ' ' + UsuarioApellido AS TXT FROM Usuario U INNER JOIN UsuarioRol UR ON U.UsuarioID=UR.UsuarioID WHERE UR.RolID=2 AND SucursalID=1 ORDER BY TXT";
            Utilidades.CargarListado(ref ddlProfesorMod, sSelectSQL, cn, ref sErr, true);
            //Salones
            sSelectSQL = "SELECT SalonID AS VAL, SalonNombre AS TXT FROM [Salon] WHERE SalonActivo=1 ORDER BY TXT";
            Utilidades.CargarListado(ref ddlSalonMod, sSelectSQL, cn, ref sErr, true);
        }
        //
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                executeUpdate();
                if (bHecho)
                {
                    BindGridView();
                    MostrarMsjModal("Registro modificado exitosamente", "EXI");
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("document.getElementById('closeEdit').click();");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
                }
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al modificar los datos. Detalle: " + ex.Message, "ERR");
            }
        }
//
        private void executeUpdate()
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                if (EsValido("Mod"))
                {
                    int iRes = -1;
                    //string s = txtMod.Text.Trim();
                    string sID = hfID.Value;
                    string sClaseID = ddlClaseMod.SelectedValue;
                    string sNivelID = ddlNivelMod.SelectedValue;
                    string sUsuarioID = ddlProfesorMod.SelectedValue;
                    string sSalonID = ddlSalonMod.SelectedValue;
                    string sClaseCupo = txtClaseCupoMod.Text.Trim();
                    string sSalonTipoReserva = txtSalonTipoReservaMod.Text.Trim();
                    string sClaseFechaInicio = Utilidades.FecUni(txtClaseFechaInicioMod.Text.Trim());
                    string sClaseHoraInicio = ddlHoraMod.SelectedValue;

                    if (sID != string.Empty)
                    {
                        string updatecmd = "UPDATE ClaseProfesor SET ClaseID=" + sClaseID + ",NivelID=" + Utilidades.SiEsNulo(sNivelID, "N") + ",UsuarioID=" + sUsuarioID + ",SalonID=" + Utilidades.SiEsNulo(sSalonID, "N") + ",ClaseCupo=" + Utilidades.SiEsNulo(sClaseCupo, "T") + ",SalonTipoReserva=" + Utilidades.SiEsNulo(sSalonTipoReserva, "T") + ",ClaseFechaInicio='" + sClaseFechaInicio + "',ClaseHoraInicio='" + sClaseHoraInicio + "',ClaseProfesorFechaRegistro=dbo.fFec(),ClaseProfesorUsuarioRegistro='" + _autenticado.UsuarioID + "' WHERE " + sTablaID + "=" + sID;
                        SqlCommand updateCmd = new SqlCommand(updatecmd, conn);
                        iRes = updateCmd.ExecuteNonQuery();
                        if (iRes > 0) bHecho = true;
                    }
                }
                else { MostrarMsjModal(sMsj, "ERR"); }
            }
            catch (SqlException Sqlex)
            {
                MostrarMsjModal("Error SQL al actualizar el registro en la BD. Detalle: " + Sqlex.Message, "ERR");
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al actualizar el registro en la BD. Detalle: " + ex.Message, "ERR");
            }
            finally
            {
                conn.Close();
            }
        }
//
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            CargarListadosNue();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#addModal').modal({ show: true });");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddShowModalScript", sb.ToString(), false);
        }
//
        private void CargarListadosNue()
        {
            string sSelectSQL = "";
            //Clases
            sSelectSQL = "SELECT ClaseID AS VAL, ClaseDescripcion AS TXT FROM [Clase] WHERE ClaseActiva=1 ORDER BY VAL";
            Utilidades.CargarListado(ref ddlClaseNue, sSelectSQL, cn, ref sErr, true);
            //Niveles
            sSelectSQL = "SELECT NivelID AS VAL, NivelNombre AS TXT FROM [Nivel] WHERE NivelActivo=1 ORDER BY NivelOrden";
            Utilidades.CargarListado(ref ddlNivelNue, sSelectSQL, cn, ref sErr, true);
            //Profesor
            sSelectSQL = "SELECT DISTINCT U.UsuarioID AS VAL, UsuarioNombre + ' ' + UsuarioApellido AS TXT FROM Usuario U INNER JOIN UsuarioRol UR ON U.UsuarioID=UR.UsuarioID WHERE UR.RolID=2 AND SucursalID=1 ORDER BY TXT";
            Utilidades.CargarListado(ref ddlProfesorNue, sSelectSQL, cn, ref sErr, true);
            //Salones
            sSelectSQL = "SELECT SalonID AS VAL, SalonNombre AS TXT FROM [Salon] WHERE SalonActivo=1 ORDER BY TXT";
            Utilidades.CargarListado(ref ddlSalonNue, sSelectSQL, cn, ref sErr, true);
        }
//
        protected void btnAddRecord_Click(object sender, EventArgs e)
        {
            try
            {
                executeAdd();
                if (bHecho)
                {
                    BindGridView();
                    MostrarMsjModal("Registro agregado correctamente", "EXI");
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("document.getElementById('closeAdd').click();");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);
                }
                else
                {MostrarMsjModal("Los campos Cédula y Nombre son obligatorios", "ADV");}
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al agregar un nuevo registro. Detalle: " + ex.Message, "ERR");
            }
        }
//
        private void executeAdd()
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                int iRes = -1;
                //string s = txtNue.Text.Trim();
                string sPlaID = ViewState["PlanID"].ToString();
                string sClaseID = ddlClaseNue.SelectedValue;
                string sNivelID = ddlNivelNue.SelectedValue;
                string sUsuarioID = ddlProfesorNue.SelectedValue;
                string sSalonID = ddlSalonNue.SelectedValue;
                string sClaseCupo = txtClaseCupoNue.Text.Trim();
                string sSalonTipoReserva = txtSalonTipoReservaNue.Text.Trim();
                string sClaseFechaInicio = Utilidades.FecUni(txtClaseFechaInicioNue.Text.Trim());
                string sClaseHoraInicio = ddlHoraNue.SelectedValue;

                if (EsValido("Nue"))
                {
                    string sqlcmd = "INSERT INTO ClaseProfesor (SucursalID,PlanID,ClaseID,NivelID,UsuarioID,SalonID,ClaseCupo,SalonTipoReserva,ClaseFechaInicio,ClaseHoraInicio,ClaseProfesorFechaRegistro,ClaseProfesorUsuarioRegistro) VALUES (" + _autenticado.SucursalID + "," + sPlaID + "," + sClaseID + "," + Utilidades.SiEsNulo(sNivelID, "N") + "," + sUsuarioID + "," + Utilidades.SiEsNulo(sSalonID, "N") + "," + Utilidades.SiEsNulo(sClaseCupo, "N") + "," + Utilidades.SiEsNulo(sSalonTipoReserva, "T") + ",'" + sClaseFechaInicio + "','" + sClaseHoraInicio + "'," + _autenticado.UsuarioID + ",dbo.fFec())";
                    SqlCommand addCmd = new SqlCommand(sqlcmd, conn);
                    iRes = addCmd.ExecuteNonQuery();
                    if (iRes > 0) bHecho = true;
                }
                else { MostrarMsjModal(sMsj, "ERR"); }
            }
            catch (SqlException Sqlex)
            {
                MostrarMsjModal("Error SQL al agregar un nuevo registro. Detalle: " + Sqlex.Message, "ERR");
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al agregar un nuevo registro. Detalle: " + ex.Message, "ERR");
            }
            finally
            {
                conn.Close();
            }
        }
//
        private bool EsValido(string sAccion)
        {
            bool bRes = true;
            if (sAccion == "Nue")
            {
                string sClaseID = ddlClaseNue.SelectedValue;
                if (sClaseID == "") { sMsj += "El campo Clase es requerido. "; bRes = false; }
                string sUsuarioID = ddlProfesorNue.SelectedValue;
                if (sUsuarioID == "") { sMsj += "El campo Profesor es requerido. "; bRes = false; }
                string sFechaIni = txtClaseFechaInicioNue.Text.Trim();
                if (sFechaIni == "") { sMsj += "No puede dejar el campo Fecha vacío. "; bRes = false; }
                if (sFechaIni != "" && !Utilidades.EsFecha(sFechaIni)) { sMsj += "La Fecha no tiene un formato válido. "; bRes = false; }
            }
            else if (sAccion == "Mod")
            {
                string sClaseID = ddlClaseMod.SelectedValue;
                if (sClaseID == "") { sMsj += "El campo Clase es requerido. "; bRes = false; }
                string sUsuarioID = ddlProfesorMod.SelectedValue;
                if (sUsuarioID == "") { sMsj += "El campo Profesor es requerido. "; bRes = false; }
                string sFechaIni = txtClaseFechaInicioNue.Text.Trim();
                if (sFechaIni == "") { sMsj += "No puede dejar el campo Fecha vacío. "; bRes = false; }
                if (sFechaIni != "" && !Utilidades.EsFecha(sFechaIni)) { sMsj += "La Fecha no tiene un formato válido. "; bRes = false; }
            }
            return bRes;
        }
//
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            executeDelete();
            if (bHecho)
            {
                BindGridView();
                MostrarMsjModal("Registro eliminado de la base de datos", "EXI");
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('closeDelete').click();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);
            }
        }
//
        private void executeDelete()
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                int iRes = -1;
                string sID = hfID.Value;
                string updatecmd = "DELETE FROM [ClaseProfesor] WHERE ClaseProfesorID=@ClaseProfesorID";
                SqlCommand addCmd = new SqlCommand(updatecmd, conn);
                addCmd.Parameters.AddWithValue("@ClaseProfesorID", sID);
                iRes = addCmd.ExecuteNonQuery();
                if (iRes > 0) { bHecho = true; }
            }
            catch (SqlException Sqlex)
            {
                MostrarMsjModal("Error SQL al eliminar el registro. Detalle: " + Sqlex.Message, "ERR");
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al eliminar el registro. Detalle: " + ex.Message, "ERR");
            }
            finally
            {
                conn.Close();
            }
        }
//
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