using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using LicsuWeb.Validado.Clases;
using System.Web.Security;
namespace LicsuWeb.Validado
{
    public partial class EmpleadosActivos : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        DataTable dt;
        GridView grid;
        string sSelect = "", Err = "", sSelectSQL = "";
        SqlDataAdapter dAdapter;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity);
            BindGridView();
        }

        protected void BindGridView()
        {
            try
            {
                cn.Close();
                cn.Open();
                string cmd2 = "SELECT dbo.Usuario.UsuarioID as UsuarioID,(dbo.Usuario.UsuarioNombre+' '+dbo.Usuario.UsuarioApellido) as UsuarioNombre, " +
                                " dbo.Usuario.UsuarioCedula as UsuarioCedula, "+
                                " dbo.Usuario.UsuarioFechaNacimiento as UsuarioFechaNacimiento, "+
                                " dbo.Usuario.UsuarioCorreo as UsuarioCorreo, "+
                                " dbo.UsuarioRol.ClienteID as ClienteID "+
                                " FROM dbo.PlanEmpresa INNER JOIN "+
                                " dbo.Usuario ON dbo.PlanEmpresa.UsuarioID = dbo.Usuario.UsuarioID "+
                                " AND dbo.PlanEmpresa.UsuarioID = dbo.Usuario.UsuarioID INNER JOIN "+
                                " dbo.UsuarioRol ON dbo.Usuario.UsuarioID = dbo.UsuarioRol.UsuarioID"+
                                 " WHERE (dbo.UsuarioRol.ClienteID = " + _autenticado.ClienteID + " " + ViewState["sWhere"] + ")";
                dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "UsuarioID";
                GridView1.DataKeyNames = TablaID;
                GridView1.DataSource = dt;
                GridView1.DataBind();
                cn.Close();
                //Attribute to show the Plus Minus Button.
                GridView1.HeaderRow.Cells[0].Attributes["data-class"] = "expand";

                //Attribute to hide column in Phone.                
                GridView1.HeaderRow.Cells[1].Attributes["data-hide"] = "phone";
                GridView1.HeaderRow.Cells[2].Attributes["data-hide"] = "phone";
                GridView1.HeaderRow.Cells[3].Attributes["data-hide"] = "phone";

                //Adds THEAD and TBODY to GridView.
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string sBuscar = txtSearch.Text.Trim();
                if (sBuscar != "")
                { ViewState["sWhere"] = " AND (Usuario.UsuarioNombre LIKE '%" + sBuscar + "%' OR Usuario.UsuarioCedula LIKE '%"  + sBuscar + "%')"; }
                else
                { ViewState["sWhere"] = ""; }
                BindGridView();
            }
            catch (Exception ex)
            {
                Err += "Error al buscar el registro. Detalle: " + ex.Message.Replace("'", "") + ". ";
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

        protected void btnArchivo_Click(object sender, EventArgs e)
        {
            string Hora = DateTime.Now.ToString("dd_MM_yyy_HH_mm");
            grid = new GridView();
            cn.Open();
            string cmd2 = "SELECT (dbo.Usuario.UsuarioNombre+' '+dbo.Usuario.UsuarioApellido) as UsuarioNombre, " +
                                " dbo.Usuario.UsuarioCedula as UsuarioCedula, " +
                                " dbo.Usuario.UsuarioFechaNacimiento as UsuarioFechaNacimiento, " +
                                " dbo.Usuario.UsuarioCorreo as UsuarioCorreo " +
                                " FROM dbo.PlanEmpresa INNER JOIN " +
                                " dbo.Usuario ON dbo.PlanEmpresa.UsuarioID = dbo.Usuario.UsuarioID " +
                                " AND dbo.PlanEmpresa.UsuarioID = dbo.Usuario.UsuarioID INNER JOIN " +
                                " dbo.UsuarioRol ON dbo.Usuario.UsuarioID = dbo.UsuarioRol.UsuarioID" +
                                 " WHERE (dbo.UsuarioRol.ClienteID = " + _autenticado.ClienteID + " " + ViewState["sWhere"] + ")";
            dAdapter = new SqlDataAdapter(cmd2, cn);
            DataSet ds = new DataSet();
            dAdapter.Fill(ds);
            dt = ds.Tables[0];
            string[] TablaID = new string[1];
            TablaID[0] = "UsuarioCedula";
            grid.DataKeyNames = TablaID;
            grid.DataSource = dt;
            grid.DataBind();
            cn.Close();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();
            GridView Grid = new GridView();
            grid.AllowPaging = false;
            grid.DataBind();
            grid.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(grid);
            page.RenderControl(htw);
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=empleados_activos" + Hora + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}