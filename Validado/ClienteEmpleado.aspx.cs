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
    public partial class ClienteEmpleado : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["conexion"]);
        bool bHecho = false;
        string sErr = "";
        DataTable dt;
//
        protected void Page_Load(object sender, EventArgs e)
        {
            this.PreRenderComplete += new EventHandler(Page_PreRenderComplete);
            _autenticado = new UsuarioAutenticado(fIdentity);
            if (!IsPostBack)
            {
                if (_autenticado.RolID == "1")  //Administrador
                {
                    phCliente.Visible = true;
                    CargarListados();
                    ViewState["ClienteID"] = ddlCliente.SelectedValue;
                }
                else
                {
                    phCliente.Visible = false;
                    ViewState["ClienteID"] = _autenticado.ClienteID;
                }
                ShowHideColumns();
            }
            BindGridView();
        }
        //
        private void CargarListados()
        {
            string sSelectSQL = "";
            //Cliente
            sSelectSQL = "SELECT ClienteID AS VAL, ClienteNombre AS TXT FROM [Cliente] WHERE ClienteID > 1 ORDER BY TXT"; // WHERE PlanActivo=1
            Utilidades.CargarListado(ref ddlCliente, sSelectSQL, cn, ref sErr);
        }
        //
        protected void ddlCliente_SelectedIndexChanged(object sender, System.EventArgs e)
        {
                ViewState["ClienteID"] = ddlCliente.SelectedValue;
                BindGridView();
                ShowHideColumns();
        }
        //
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string sBuscar = txtSearch.Text.Trim();
                if (sBuscar != "")
                    { ViewState["sWhere"] = " AND ((Cedula LIKE '%" + sBuscar + "%') OR (Nombre LIKE '%" + sBuscar + "%'))";}
                else
                    { ViewState["sWhere"] = "";}
                BindGridView();
            }
            catch (Exception ex)
            {
                sErr += "Error al buscar el registro. Detalle: " + ex.Message.Replace("'", "") + ". ";
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
                    string cmd = "SELECT TOP 50 Cedula,CodigoEmpleado,Nombre,CONVERT(varchar, FechaIngreso, 103) AS FechaIngreso,CONVERT(varchar, FechaEgreso, 103) AS FechaEgreso,Correo,Telefono,Zona,Region,Empresa,TipoEmpleado,UnidadNegocio,Gerencia,Cargo,CAST(EmpleadoActivo AS VARCHAR(4)) AS EmpleadoActivo,Beneficio1 FROM ClienteEmpleado WHERE ClienteID=" + ViewState["ClienteID"] + ViewState["sWhere"] + " ORDER BY Cedula";
                    SqlDataAdapter dAdapter = new SqlDataAdapter(cmd, conn);
                    DataSet ds = new DataSet();
                    dAdapter.Fill(ds);
                    dt = ds.Tables[0];
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                catch (SqlException ex)
                {
                    sErr += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
                }

        }

        protected void ShowHideColumns()
        {
            string connString = ConfigurationManager.AppSettings["conexion"].ToString();
            SqlConnection connection = new SqlConnection(connString);
            SqlCommand selectCommand = new SqlCommand("SELECT Cedula,CodigoEmpleado,Nombre,FechaIngreso,FechaEgreso,Correo,Telefono,Zona,Region,Empresa,TipoEmpleado,UnidadNegocio,Gerencia,Cargo,EmpleadoActivo,Beneficio1 FROM ClienteEmpleadoConfig WHERE ClienteID=" + ViewState["ClienteID"], connection);
            try
            {
                connection.Open();
                using (SqlDataReader reader = selectCommand.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            bool bCedula = bool.Parse(reader[0].ToString());
                            bool bCodigoEmpleado = bool.Parse(reader[1].ToString());
                            bool bNombre = bool.Parse(reader[2].ToString());
                            bool bFechaIngreso = bool.Parse(reader[3].ToString());
                            bool bFechaEgreso = bool.Parse(reader[4].ToString());
                            bool bCorreo = bool.Parse(reader[5].ToString());
                            bool bTelefono = bool.Parse(reader[6].ToString());
                            bool bZona = bool.Parse(reader[7].ToString());
                            bool bRegion = bool.Parse(reader[8].ToString());
                            bool bEmpresa = bool.Parse(reader[9].ToString());
                            bool bTipoEmpleado = bool.Parse(reader[10].ToString());
                            bool bUnidadNegocio = bool.Parse(reader[11].ToString());
                            bool bGerencia = bool.Parse(reader[12].ToString());
                            bool bCargo = bool.Parse(reader[13].ToString());
                            bool bEmpleadoActivo = bool.Parse(reader[14].ToString());
                            bool bBeneficio1 = bool.Parse(reader[15].ToString());

                            GridView1.Columns[3].Visible = bCedula;
                            GridView1.Columns[4].Visible = bCodigoEmpleado;
                            GridView1.Columns[5].Visible = bNombre;
                            GridView1.Columns[6].Visible = bFechaIngreso;
                            GridView1.Columns[7].Visible = bFechaEgreso;
                            GridView1.Columns[8].Visible = bCorreo;
                            GridView1.Columns[9].Visible = bTelefono;
                            GridView1.Columns[10].Visible = bZona;
                            GridView1.Columns[11].Visible = bRegion;
                            GridView1.Columns[12].Visible = bEmpresa;
                            GridView1.Columns[13].Visible = bTipoEmpleado;
                            GridView1.Columns[14].Visible = bUnidadNegocio;
                            GridView1.Columns[15].Visible = bGerencia;
                            GridView1.Columns[16].Visible = bCargo;
                            GridView1.Columns[17].Visible = bEmpleadoActivo;
                            GridView1.Columns[18].Visible = bBeneficio1;

                            DetailsView1.Fields[0].Visible = bCedula;
                            DetailsView1.Fields[1].Visible = bCodigoEmpleado;
                            DetailsView1.Fields[2].Visible = bNombre;
                            DetailsView1.Fields[3].Visible = bFechaIngreso;
                            DetailsView1.Fields[4].Visible = bFechaEgreso;
                            DetailsView1.Fields[5].Visible = bCorreo;
                            DetailsView1.Fields[6].Visible = bTelefono;
                            DetailsView1.Fields[7].Visible = bZona;
                            DetailsView1.Fields[8].Visible = bRegion;
                            DetailsView1.Fields[9].Visible = bEmpresa;
                            DetailsView1.Fields[10].Visible = bTipoEmpleado;
                            DetailsView1.Fields[11].Visible = bUnidadNegocio;
                            DetailsView1.Fields[12].Visible = bGerencia;
                            DetailsView1.Fields[13].Visible = bCargo;
                            DetailsView1.Fields[14].Visible = bEmpleadoActivo;
                            DetailsView1.Fields[15].Visible = bBeneficio1;

                            phCedulaMod.Visible = bCedula;
                            phCodigoEmpleadoMod.Visible = bCodigoEmpleado;
                            phNombreMod.Visible = bNombre;
                            phFechaIngresoMod.Visible = bFechaIngreso;
                            phFechaEgresoMod.Visible = bFechaEgreso;
                            phCorreoMod.Visible = bCorreo;
                            phTelefonoMod.Visible = bTelefono;
                            phZonaMod.Visible = bZona;
                            phRegionMod.Visible = bRegion;
                            phEmpresaMod.Visible = bEmpresa;
                            phTipoEmpleadoMod.Visible = bTipoEmpleado;
                            phUnidadNegocioMod.Visible = bUnidadNegocio;                            
                            phGerenciaMod.Visible = bGerencia;
                            phCargoMod.Visible = bCargo;
                            phEmpleadoActivoMod.Visible = bEmpleadoActivo;
                            phBeneficio1Mod.Visible = bBeneficio1;

                            phCedulaNue.Visible = bCedula;
                            phCodigoEmpleadoNue.Visible = bCodigoEmpleado;
                            phNombreNue.Visible = bNombre;
                            phFechaIngresoNue.Visible = bFechaIngreso;
                            phFechaEgresoNue.Visible = bFechaEgreso;
                            phCorreoNue.Visible = bCorreo;
                            phTelefonoNue.Visible = bTelefono;
                            phZonaNue.Visible = bZona;
                            phRegionNue.Visible = bRegion;
                            phEmpresaNue.Visible = bEmpresa;
                            phTipoEmpleadoNue.Visible = bTipoEmpleado;
                            phUnidadNegocioNue.Visible = bUnidadNegocio;
                            phGerenciaNue.Visible = bGerencia;
                            phCargoNue.Visible = bCargo;
                            phEmpleadoActivoNue.Visible = bEmpleadoActivo;
                            phBeneficio1Nue.Visible = bBeneficio1;
                        }
                    }
                    reader.Close();
                }
            }
            catch (SqlException Sqlex)
            {
                sErr += "Error al visualizar/esconder los campos. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                sErr += "Error al  visualizar/esconder los campos. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                connection.Close();
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
            if (e.CommandName.Equals("detail"))
            {
                string Cedula = GridView1.DataKeys[index].Value.ToString();
                IEnumerable<DataRow> query = from i in dt.AsEnumerable()
                                             where i.Field<String>("Cedula").Equals(Cedula)
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
                GridViewRow gvrow = GridView1.Rows[index];
                txtCedulaMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
                txtCodigoEmpleadoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text).ToString();
                txtNombreMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[5].Text);
                txtFechaIngresoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[6].Text);
                txtFechaEgresoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[7].Text);
                txtCorreoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[8].Text);
                txtTelefonoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[9].Text);
                txtZonaMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[10].Text);
                txtRegionMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[11].Text);
                txtEmpresaMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[12].Text);
                txtTipoEmpleadoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[13].Text);
                txtUnidadNegocioMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[14].Text);
                txtGerenciaMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[15].Text);
                txtCargoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[16].Text);
                txtEmpleadoActivoMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[17].Text);
                txtBeneficio1Mod.Text = HttpUtility.HtmlDecode(gvrow.Cells[18].Text);
                //txtMod.Text = HttpUtility.HtmlDecode(gvrow.Cells[].Text);
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
                string sCedula = txtCedulaMod.Text;
                string sCodigoEmpleado = txtCodigoEmpleadoMod.Text;
                string sNombre = txtNombreMod.Text;
                string sFechaIngreso = txtFechaIngresoMod.Text;
                string sFechaEgreso = txtFechaEgresoMod.Text;
                string sCorreo = txtCorreoMod.Text;
                string sTelefono = txtTelefonoMod.Text;
                string sZona = txtZonaMod.Text;
                string sRegion = txtRegionMod.Text;
                string sEmpresa = txtEmpresaMod.Text;
                string sTipoEmpleado = txtTipoEmpleadoMod.Text;
                string sUnidadNegocio = txtUnidadNegocioMod.Text;
                string sGerencia = txtGerenciaMod.Text;
                string sCargo = txtCargoMod.Text;
                string sEmpleadoActivo = txtEmpleadoActivoMod.Text;
                string sBeneficio1 = txtBeneficio1Mod.Text;
                //string s = txtMod.Text;
                executeUpdate(sCedula, sCodigoEmpleado, sNombre, sFechaIngreso, sFechaEgreso, sCorreo, sTelefono, sZona, sRegion, sEmpresa, sTipoEmpleado, sUnidadNegocio, sGerencia, sCargo, sEmpleadoActivo, sBeneficio1);
                if (bHecho)
                {
                    BindGridView();
                    MostrarModalExito("Registro modificado exitosamente");
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("document.getElementById('closeEdit').click();");
                    //sb.Append("$('#editModal').modal({ show: false });");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
                }
            }
            catch (Exception ex)
            {
                sErr += "Error al modificar los datos. Detalle: " + ex.Message + ". ";
            }
        }

        private void executeUpdate(string sCedula, string sCodigoEmpleado, string sNombre, string sFechaIngreso, string sFechaEgreso, string sCorreo, string sTelefono, string sZona, string sRegion, string sEmpresa, string sTipoEmpleado, string sUnidadNegocio, string sGerencia, string sCargo, string sEmpleadoActivo, string sBeneficio1)
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                if (ViewState["ClienteID"].ToString() != string.Empty && sCedula != string.Empty)
                {
                    int iRes = -1;
                    sFechaIngreso = Utilidades.FecUni(sFechaIngreso);
                    sFechaEgreso = Utilidades.FecUni(sFechaEgreso);
                    string updatecmd = "UPDATE ClienteEmpleado SET Cedula=" + Utilidades.SiEsNulo(sCedula, "T") + ",CodigoEmpleado=" + Utilidades.SiEsNulo(sCodigoEmpleado, "T") + ",Nombre=" + Utilidades.SiEsNulo(sNombre, "T") + ",FechaIngreso=" + Utilidades.SiEsNulo(sFechaIngreso, "F") + ",FechaEgreso=" + Utilidades.SiEsNulo(sFechaEgreso, "F") + ",Correo=" + Utilidades.SiEsNulo(sCorreo, "T") + ",Telefono=" + Utilidades.SiEsNulo(sTelefono, "T") + ",Zona=" + Utilidades.SiEsNulo(sZona, "T") + ",Region=" + Utilidades.SiEsNulo(sRegion, "T") + ",Empresa=" + Utilidades.SiEsNulo(sEmpresa, "T") + ",TipoEmpleado=" + Utilidades.SiEsNulo(sTipoEmpleado, "T") + ",UnidadNegocio=" + Utilidades.SiEsNulo(sUnidadNegocio, "T") + ",Gerencia=" + Utilidades.SiEsNulo(sGerencia, "T") + ",Cargo=" + Utilidades.SiEsNulo(sCargo, "T") + ",EmpleadoActivo=" + Utilidades.SiEsNulo(sEmpleadoActivo, "L") + ",Beneficio1=" + Utilidades.SiEsNulo(sBeneficio1, "T") + " WHERE Cedula=" + sCedula + " AND ClienteID=" + ViewState["ClienteID"].ToString();
                    SqlCommand updateCmd = new SqlCommand(updatecmd, conn);
                    iRes = updateCmd.ExecuteNonQuery();
                    if (iRes > 0) bHecho = true;
                }
            }
            catch (SqlException Sqlex)
            {
                sErr += "Error al actualizar el registro en la BD. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                sErr += "Error al actualizar el registro en la BD. Detalle: " + ex.Message + ". ";
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
                string sCedula = txtCedulaNue.Text.Trim();
                string sCodigoEmpleado = txtCodigoEmpleadoNue.Text.Trim();
                string sNombre = txtNombreNue.Text.Trim();
                string sFechaIngreso = txtFechaIngresoNue.Text.Trim();
                string sFechaEgreso = txtFechaEgresoNue.Text.Trim();
                string sCorreo = txtCorreoNue.Text.Trim();
                string sTelefono = txtTelefonoNue.Text.Trim();
                string sZona = txtZonaNue.Text.Trim();
                string sRegion = txtRegionNue.Text.Trim();
                string sEmpresa = txtEmpresaNue.Text.Trim();
                string sTipoEmpleado = txtTipoEmpleadoNue.Text.Trim();
                string sUnidadNegocio = txtUnidadNegocioNue.Text.Trim();
                string sGerencia = txtGerenciaNue.Text.Trim();
                string sCargo = txtCargoNue.Text.Trim();
                string sEmpleadoActivo = txtEmpleadoActivoNue.Text.Trim();
                string sBeneficio1 = txtBeneficio1Nue.Text.Trim();
                if (sCedula != "" && sNombre != "")
                {
                    executeAdd(sCedula, sCodigoEmpleado, sNombre, sFechaIngreso, sFechaEgreso, sCorreo, sTelefono, sZona, sRegion, sEmpresa, sTipoEmpleado, sUnidadNegocio, sGerencia, sCargo, sEmpleadoActivo, sBeneficio1);
                    if (bHecho)
                    {
                        BindGridView();
                        MostrarModalExito("Registro agregado correctamente");
                        System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        sb.Append(@"<script type='text/javascript'>");
                        sb.Append("document.getElementById('closeAdd').click();");
                        //sb.Append("$('#addModal').modal({ show: false });");
                        sb.Append(@"</script>");
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);
                    }
                }
                else
                { MostrarModalInformacion("Los campos Cédula y Nombre son obligatorios"); }
            }
            catch (Exception ex)
            {
                sErr += "Error al agregar un nuevo registro. Detalle: " + ex.Message + ". ";
            }
        }

        private void executeAdd(string sCedula, string sCodigoEmpleado, string sNombre, string sFechaIngreso, string sFechaEgreso, string sCorreo, string sTelefono, string sZona, string sRegion, string sEmpresa, string sTipoEmpleado, string sUnidadNegocio, string sGerencia, string sCargo, string sEmpleadoActivo, string sBeneficio1)
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                if (ViewState["ClienteID"].ToString() != string.Empty && sCedula != string.Empty)
                {
                    int iRes = -1;
                    sFechaIngreso = Utilidades.FecUni(sFechaIngreso);
                    sFechaEgreso = Utilidades.FecUni(sFechaEgreso);
                    string updatecmd = "INSERT INTO ClienteEmpleado (ClienteID,Cedula,CodigoEmpleado,Nombre,FechaIngreso,FechaEgreso,Correo,Telefono,Zona,Region,Empresa,TipoEmpleado,UnidadNegocio,Gerencia,Cargo,EmpleadoActivo,Beneficio1) VALUES (" + ViewState["ClienteID"].ToString() + "," + Utilidades.SiEsNulo(sCedula, "T") + "," + Utilidades.SiEsNulo(sCodigoEmpleado, "T") + "," + Utilidades.SiEsNulo(sNombre, "T") + "," + Utilidades.SiEsNulo(sFechaIngreso, "F") + "," + Utilidades.SiEsNulo(sFechaEgreso, "F") + "," + Utilidades.SiEsNulo(sCorreo, "T") + "," + Utilidades.SiEsNulo(sTelefono, "T") + "," + Utilidades.SiEsNulo(sZona, "T") + "," + Utilidades.SiEsNulo(sRegion, "T") + "," + Utilidades.SiEsNulo(sEmpresa, "T") + "," + Utilidades.SiEsNulo(sTipoEmpleado, "T") + "," + Utilidades.SiEsNulo(sUnidadNegocio, "T") + "," + Utilidades.SiEsNulo(sGerencia, "T") + "," + Utilidades.SiEsNulo(sCargo, "T") + "," + Utilidades.SiEsNulo(sEmpleadoActivo, "L") + "," + Utilidades.SiEsNulo(sBeneficio1, "T") + ")";
                    SqlCommand addCmd = new SqlCommand(updatecmd, conn);
                    iRes = addCmd.ExecuteNonQuery();
                    if (iRes > 0) bHecho = true;
                }
            }
            catch (SqlException Sqlex)
            {
                sErr += "Error al agregar el registro. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                sErr += "Error al agregar un nuevo registro. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                conn.Close();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string Cedula = hfCedula.Value;
            executeDelete(Cedula);
            if (bHecho)
            {
                BindGridView();
                MostrarModalExito("Registro eliminado de la base de datos");
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("document.getElementById('closeDelete').click();");
                //sb.Append("$('#deleteModal').modal({ show: false });");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);
            }
        }

        private void executeDelete(string Cedula)
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            try
            {
                int iRes = -1;
                string updatecmd = "DELETE FROM [ClienteEmpleado] WHERE Cedula=@Cedula AND ClienteID=@Cliente";
                SqlCommand addCmd = new SqlCommand(updatecmd, conn);
                addCmd.Parameters.AddWithValue("@Cedula", Cedula);
                addCmd.Parameters.AddWithValue("@Cliente", ViewState["ClienteID"]);
                iRes=addCmd.ExecuteNonQuery();
                if (iRes > 0) { bHecho = true; }
            }
            catch (SqlException Sqlex)
            {
                sErr += "Error al eliminar el registro. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                sErr += "Error al agregar un nuevo registro. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                conn.Close();
            }
        }
        private void Page_PreRenderComplete(object sender, EventArgs e)
        {
            if (sErr != string.Empty)
            {
                MostrarModalError(sErr);
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