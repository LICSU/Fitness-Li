using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LicsuWeb.Validado.Clases;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using Microsoft.Reporting.WebForms;

namespace LicsuWeb.Validado
{
    public partial class rClienteEmpGen : System.Web.UI.Page
    {
        string sErr = "";
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["conexion"]);
        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity);
            if (!IsPostBack)
            {
                if (_autenticado.RolID == "1")
                {
                    phCliente.Visible = true;
                    CargarListados();
                }
                else
                {
                    phCliente.Visible = false;
                    MostrarReporte(_autenticado.ClienteID);
                }
            }
        }
//
        private void CargarListados()
        {
            string sSelectSQL = "";
            //Cliente
            sSelectSQL = "SELECT ClienteID AS VAL, ClienteNombre AS TXT FROM [Cliente] WHERE ClienteID > 1 ORDER BY TXT"; // WHERE PlanActivo=1
            Utilidades.CargarListado(ref ddlCliente, sSelectSQL, cn, ref sErr, true);
        }
        //
        protected void ddlCliente_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            string sClienteID = ddlCliente.SelectedValue;
            if (sClienteID != "")
            {
                MostrarReporte(sClienteID);
            }
        }
//
        private void MostrarReporte(string sClienteID)
        {
            try
            {
                ReportViewer1.LocalReport.DataSources.Clear();
                DataSet ds = new DataSet();
                string sRutaReporte = "Validado\\Reportes\\ClienteEmpGen.rdlc";
                string sNombreFuenteDatos = "dsReportes_dtCliEmpGen";
                string vSql1 = "SELECT ClienteEmpleadoID,Estatus,Cedula,CodigoEmpleado,Nombre,Correo,Telefono,Region,Empresa,TipoEmpleado,Gerencia,Cargo,EmpleadoActivo,Beneficio1 FROM ClienteEmpleado WHERE ClienteID=" + sClienteID + " ORDER BY Correo";

                SqlDataAdapter da1 = new SqlDataAdapter(vSql1, cn);
                da1.Fill(ds, sNombreFuenteDatos);
                ReportDataSource rds1 = new ReportDataSource();
                rds1.Name = sNombreFuenteDatos;
                rds1.Value = ds.Tables[sNombreFuenteDatos];

                ReportViewer1.LocalReport.ReportPath = sRutaReporte;
                ReportViewer1.LocalReport.DataSources.Add(rds1);

                ReportViewer1.LocalReport.SetParameters(Parametros(sClienteID));

                ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al mostrar el reporte, detalle: " + ex.Message, "ERR");
            }
        }
//
        protected ReportParameter[] Parametros(string sClienteID)
        {
            ReportParameter[] Param = new ReportParameter[15];
            SqlConnection cn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["conexion"]);
            SqlCommand selectCommand = new SqlCommand("SELECT TOP 1 CodigoEmpleado,Nombre,FechaIngreso,FechaEgreso,Correo,Telefono,Zona,Region,Empresa,TipoEmpleado,UnidadNegocio,Gerencia,Cargo,EmpleadoActivo,Beneficio1 FROM ClienteEmpleadoConfig WHERE ClienteID=" + sClienteID, cn1);
            try
            {
                cn1.Open();
                using (SqlDataReader reader = selectCommand.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Param[0] = new ReportParameter("parCodigoEmpleado", reader[0].ToString());
                            Param[1] = new ReportParameter("parNombre", reader[1].ToString());
                            Param[2] = new ReportParameter("parFechaIngreso", reader[2].ToString());
                            Param[3] = new ReportParameter("parFechaEgreso", reader[3].ToString());
                            Param[4] = new ReportParameter("parCorreo", reader[4].ToString());
                            Param[5] = new ReportParameter("parTelefono", reader[5].ToString());
                            Param[6] = new ReportParameter("parZona", reader[6].ToString());
                            Param[7] = new ReportParameter("parRegion", reader[7].ToString());
                            Param[8] = new ReportParameter("parEmpresa", reader[8].ToString());
                            Param[9] = new ReportParameter("parTipoEmpleado", reader[9].ToString());
                            Param[10] = new ReportParameter("parUnidadNegocio", reader[10].ToString());
                            Param[11] = new ReportParameter("parGerencia", reader[11].ToString());
                            Param[12] = new ReportParameter("parCargo", reader[12].ToString());
                            Param[13] = new ReportParameter("parEmpleadoActivo", reader[13].ToString());
                            Param[14] = new ReportParameter("parBeneficio1", reader[14].ToString());
                            //Param[15] = new ReportParameter("par", reader[0].ToString());
                        }
                    }
                    reader.Close();
                }
            }
            catch (SqlException Sqlex)
            {
                MostrarMsjModal("Error SQL al visualizar/esconder los campos. Detalle: " + Sqlex.Message, "ERR");
            }
            catch (Exception ex)
            {
                MostrarMsjModal("Error al visualizar/esconder los campos. Detalle: " + ex.Message, "ERR");
            }
            finally
            {
                cn1.Close();
            }
            return Param;
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