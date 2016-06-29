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
    public partial class ClienteEmpleadoConfig : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        bool bHecho = false;
        string Err = "";
        DataTable dt;
//
        protected void Page_Load(object sender, EventArgs e)
        {
            this.PreRenderComplete += new EventHandler(Page_PreRenderComplete);
            _autenticado = new UsuarioAutenticado(fIdentity);
            BindGridView();
        }
//
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string sBuscar = txtSearch.Text.Trim();
                if (sBuscar != "")
                { ViewState["sWhere"] = " WHERE (ClienteNombre LIKE '%" + sBuscar + "%')"; }
                else
                { ViewState["sWhere"] = ""; }
                BindGridView();
            }
            catch (Exception ex)
            {
                Err += "Error al buscar el registro. Detalle: " + ex.Message.Replace("'", "") + ". ";
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
                //WHERE ClienteID=" + _autenticado.ClienteID
                string cmd = "SELECT TOP 50 CEC.ClienteID,ClienteNombre,Cedula,"
                            +" CodigoEmpleado,Nombre,FechaIngreso,FechaEgreso,Correo,"
                            +" Telefono,Zona,Region,UnidadNegocio,Gerencia,Cargo FROM ClienteEmpleadoConfig "
                            +"CEC INNER JOIN Cliente C ON CEC.ClienteID=C.ClienteID" + ViewState["sWhere"] + " ORDER BY ClienteID";
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd, conn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[2];
                TablaID[0] = "ClienteID";
                TablaID[1] = "ClienteNombre";
                GridView1.DataKeyNames = TablaID;
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (SqlException ex)
            {
                Err += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
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
            if (e.CommandName.Equals("editRecord"))
            {
                GridViewRow gvrow = GridView1.Rows[index];
                hClienteIDMod.Value = GridView1.DataKeys[index].Values["ClienteID"].ToString(); 
                chkCedulaMod.Checked = (gvrow.FindControl("chkCedula") as CheckBox).Checked;
                chkCodigoEmpleadoMod.Checked = (gvrow.FindControl("chkCodigoEmpleado") as CheckBox).Checked;
                chkNombreMod.Checked = (gvrow.FindControl("chkNombre") as CheckBox).Checked;
                chkFechaIngresoMod.Checked = (gvrow.FindControl("chkFechaIngreso") as CheckBox).Checked;
                chkFechaEgresoMod.Checked = (gvrow.FindControl("chkFechaEgreso") as CheckBox).Checked;
                chkCorreoMod.Checked = (gvrow.FindControl("chkCorreo") as CheckBox).Checked;
                chkTelefonoMod.Checked = (gvrow.FindControl("chkTelefono") as CheckBox).Checked;
                chkZonaMod.Checked = (gvrow.FindControl("chkZona") as CheckBox).Checked;
                chkRegionMod.Checked = (gvrow.FindControl("chkRegion") as CheckBox).Checked;
                chkUnidadNegocioMod.Checked = (gvrow.FindControl("chkUnidadNegocio") as CheckBox).Checked;
                chkGerenciaMod.Checked = (gvrow.FindControl("chkGerencia") as CheckBox).Checked;
                chkCargoMod.Checked = (gvrow.FindControl("chkCargo") as CheckBox).Checked;
                lblResult.Visible = false;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#editModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditModalScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("deleteRecord"))
            {
                string Cedula = GridView1.DataKeys[index].Value.ToString();
                hfCedula.Value = Cedula;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#deleteModal').modal({ show: true });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DeleteModalScript", sb.ToString(), false);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string sClienteID = hClienteIDMod.Value;
                bool bCedula = chkCedulaMod.Checked;
                bool bCodigoEmpleado = chkCodigoEmpleadoMod.Checked;
                bool bNombre = chkNombreMod.Checked;
                bool bFechaIngreso = chkFechaIngresoMod.Checked;
                bool bFechaEgreso = chkFechaEgresoMod.Checked;
                bool bCorreo = chkCorreoMod.Checked;
                bool bTelefono = chkTelefonoMod.Checked;
                bool bZona = chkZonaMod.Checked;
                bool bRegion = chkRegionMod.Checked;
                bool bUnidadNegocio = chkUnidadNegocioMod.Checked;
                bool bGerencia = chkGerenciaMod.Checked;
                bool bCargo = chkCargoMod.Checked;
                //bool s = chkMod.Checked;
                executeUpdate(sClienteID, bCedula, bCodigoEmpleado, bNombre, bFechaIngreso, bFechaEgreso, bCorreo, bTelefono, bZona, bRegion, bUnidadNegocio, bGerencia, bCargo);
                if (bHecho)
                {
                    BindGridView();
                    MostrarModalExito("Registro modificado exitosamente");
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("document.getElementById('closeEdit').click();");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
                }
            }
            catch (Exception ex)
            {
                Err += "Error al modificar los datos. Detalle: " + ex.Message + ". ";
            }
        }

        private void executeUpdate(string sClienteID, bool bCedula, bool bCodigoEmpleado, bool bNombre, bool bFechaIngreso, bool bFechaEgreso, bool bCorreo, bool bTelefono, bool bZona, bool bRegion, bool bUnidadNegocio, bool bGerencia, bool bCargo)
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                if (sClienteID != string.Empty)
                {
                    int iRes = -1;
                    string updatecmd = "UPDATE ClienteEmpleadoConfig SET Cedula=@Cedula,CodigoEmpleado=@CodigoEmpleado,Nombre=@Nombre,FechaIngreso=@FechaIngreso,FechaEgreso=@FechaEgreso,Correo=@Correo,Telefono=@Telefono,Zona=@Zona,Region=@Region,UnidadNegocio=@UnidadNegocio,Gerencia=@Gerencia,Cargo=@Cargo WHERE ClienteID=" + sClienteID;
                    SqlCommand updateCmd = new SqlCommand(updatecmd, conn);
                    updateCmd.Parameters.AddWithValue("@Cedula", bCedula);
                    updateCmd.Parameters.AddWithValue("@CodigoEmpleado", bCodigoEmpleado);
                    updateCmd.Parameters.AddWithValue("@Nombre", bNombre);
                    updateCmd.Parameters.AddWithValue("@FechaIngreso", bFechaIngreso);
                    updateCmd.Parameters.AddWithValue("@FechaEgreso", bFechaEgreso);
                    updateCmd.Parameters.AddWithValue("@Correo", bCorreo);
                    updateCmd.Parameters.AddWithValue("@Telefono", bTelefono);
                    updateCmd.Parameters.AddWithValue("@Zona", bZona);
                    updateCmd.Parameters.AddWithValue("@Region", bRegion);
                    updateCmd.Parameters.AddWithValue("@UnidadNegocio", bUnidadNegocio);
                    updateCmd.Parameters.AddWithValue("@Gerencia", bGerencia);
                    updateCmd.Parameters.AddWithValue("@Cargo", bCargo);
                    iRes = updateCmd.ExecuteNonQuery();
                    if (iRes > 0) bHecho = true;
                }
            }
            catch (SqlException Sqlex)
            {
                Err += "Error al actualizar el registro en la BD. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                Err += "Error al actualizar el registro en la BD. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                conn.Close();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#addModal').modal({ show: true });");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddShowModalScript", sb.ToString(), false);
        }

        protected void btnAddRecord_Click(object sender, EventArgs e)
        {
            try
            {
                bool bCedula = chkCedulaNue.Checked;
                bool bCodigoEmpleado = chkCodigoEmpleadoNue.Checked;
                bool bNombre = chkNombreNue.Checked;
                bool bFechaIngreso = chkFechaIngresoNue.Checked;
                bool bFechaEgreso = chkFechaEgresoNue.Checked;
                bool bCorreo = chkCorreoNue.Checked;
                bool bTelefono = chkTelefonoNue.Checked;
                bool bZona = chkZonaNue.Checked;
                bool bRegion = chkRegionNue.Checked;
                bool bUnidadNegocio = chkUnidadNegocioNue.Checked;
                bool bGerencia = chkGerenciaNue.Checked;
                bool bCargo = chkCargoNue.Checked;
                if (bCedula != true && bNombre != true)
                {
                    executeAdd(bCedula, bCodigoEmpleado, bNombre, bFechaIngreso, bFechaEgreso, bCorreo, bTelefono, bZona, bRegion, bUnidadNegocio, bGerencia, bCargo);
                    if (bHecho)
                    {
                        BindGridView();
                        MostrarModalExito("Registro agregado correctamente");
                        System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        sb.Append(@"<script type='text/javascript'>");
                        sb.Append("document.getElementById('closeAdd').click();");
                        sb.Append(@"</script>");
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);
                    }
                }
                else
                { MostrarModalInformacion("Los campos Cédula y Nombre son obligatorios"); }
            }
            catch (Exception ex)
            {
                Err += "Error al agregar un nuevo registro. Detalle: " + ex.Message + ". ";
            }
        }

        private void executeAdd(bool bCedula, bool bCodigoEmpleado, bool bNombre, bool bFechaIngreso, bool bFechaEgreso, bool bCorreo, bool bTelefono, bool bZona, bool bRegion, bool bUnidadNegocio, bool bGerencia, bool bCargo)
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                if (_autenticado.ClienteID != string.Empty && bCedula != true)
                {
                    int iRes = -1;
                    string updatecmd = "INSERT INTO ClienteEmpleadoConfig ([ClienteID],[Cedula],[CodigoEmpleado],[Nombre],[FechaIngreso],[FechaEgreso],[Correo],[Telefono],[Zona],[Region],[UnidadNegocio],[Gerencia],[Cargo]) VALUES (@ClienteID,@Cedula,@CodigoEmpleado,@Nombre,@FechaIngreso,@FechaEgreso,@Correo,@Telefono,@Zona,@Region,@UnidadNegocio,@Gerencia,@Cargo)";
                    SqlCommand addCmd = new SqlCommand(updatecmd, conn);
                    addCmd.Parameters.AddWithValue("@ClienteID", _autenticado.ClienteID);
                    addCmd.Parameters.AddWithValue("@Cedula", bCedula);
                    addCmd.Parameters.AddWithValue("@CodigoEmpleado", bCodigoEmpleado);
                    addCmd.Parameters.AddWithValue("@Nombre", bNombre);
                    addCmd.Parameters.AddWithValue("@FechaIngreso", bFechaIngreso);
                    addCmd.Parameters.AddWithValue("@FechaEgreso", bFechaEgreso);
                    addCmd.Parameters.AddWithValue("@Correo", bCorreo);
                    addCmd.Parameters.AddWithValue("@Telefono", bTelefono);
                    addCmd.Parameters.AddWithValue("@Zona", bZona);
                    addCmd.Parameters.AddWithValue("@Region", bRegion);
                    addCmd.Parameters.AddWithValue("@UnidadNegocio", bUnidadNegocio);
                    addCmd.Parameters.AddWithValue("@Gerencia", bGerencia);
                    addCmd.Parameters.AddWithValue("@Cargo", bCargo);
                    iRes = addCmd.ExecuteNonQuery();
                    if (iRes > 0) bHecho = true;
                }
            }
            catch (SqlException Sqlex)
            {
                Err += "Error al agregar el registro. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                Err += "Error al agregar un nuevo registro. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                conn.Close();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string sClienteID = hClienteIDMod.Value;
            executeDelete(sClienteID);
            if (bHecho)
            {
                BindGridView();
                //MostrarModalExito("Registro eliminado de la base de datos");
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('closeDelete').click();");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);
            }
        }
//
        private void executeDelete(string sClienteID)
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                int iRes = -1;
                string updatecmd = "DELETE FROM [ClienteEmpleadoConfig] WHERE ClienteID=@Cliente";
                SqlCommand addCmd = new SqlCommand(updatecmd, conn);
                addCmd.Parameters.AddWithValue("@Cliente", sClienteID);
                iRes = addCmd.ExecuteNonQuery();
                if (iRes > 0) { bHecho = true; }
            }
            catch (SqlException Sqlex)
            {
                Err += "Error al eliminar el registro. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                Err += "Error al agregar un nuevo registro. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                conn.Close();
            }
        }
//
        private void Page_PreRenderComplete(object sender, EventArgs e)
        {
            if (Err != string.Empty)
            {
                MostrarModalError(Err);
            }
        }
        private void MostrarModalExito(string mensaje)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarModalExito", "MostrarModalExito('" + mensaje + "');", true);
        }
        private void MostrarModalError(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarModalError", "MostrarModalError('" + message.Replace("'", "").Replace("\r\n", " ") + "');", true);
        }
        private void MostrarModalInformacion(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarModalInformacion", "MostrarModalInformacion('" + message + "');", true);
        }
    }
}