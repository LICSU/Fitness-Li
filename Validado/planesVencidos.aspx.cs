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
    public partial class planesVencidos : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "";
        DataTable dt;
        DataSet ds;
        GridView grid;
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
                cn.Open();
                string cmd2 = "SELECT  dbo.Usuario.UsuarioCedula as UsuarioCedula, "+
                               " (dbo.Usuario.UsuarioNombre+' '+dbo.Usuario.UsuarioApellido) as UsuarioNombres, "+
                               " dbo.[Plan].PlanNombre as PlanNombre, "+
                               " CONVERT(VARCHAR(11),dbo.PlanAlumno.PlanAlumnoFechaFin,103) as FechaFinal "+
                               " FROM    dbo.PlanAlumno INNER JOIN "+
                               " dbo.Usuario ON dbo.PlanAlumno.UsuarioID = dbo.Usuario.UsuarioID INNER JOIN "+
                               " dbo.UsuarioRol ON dbo.Usuario.UsuarioID = dbo.UsuarioRol.UsuarioID INNER JOIN "+
                               " dbo.[Plan] ON dbo.PlanAlumno.PlanID = dbo.[Plan].PlanID "+
                               " WHERE (dbo.PlanAlumno.ClienteID = 1) "+ ViewState["sWhere"]+""+
                               " ORDER BY dbo.PlanAlumno.PlanAlumnoFechaFin DESC";
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "UsuarioCedula";
                GridView1.DataKeyNames = TablaID;
                GridView1.DataSource = dt;
                GridView1.DataBind();
                cn.Close();
                if (dt.Rows.Count > 0)
                {
                    GridView1.HeaderRow.Cells[0].Attributes["data-class"] = "expand";
                    //Attribute to hide column in Phone. 
                    GridView1.HeaderRow.Cells[1].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[2].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[3].Attributes["data-hide"] = "phone";
                    //Adds THEAD and TBODY to GridView.
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (SqlException ex)
            {
                Err += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
                MostrarMsjModal(Err, "ERR");
            }
        }

        protected void dplDias_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dplDias.SelectedValue != "")
            {
                if(dplDias.SelectedValue == "1")
                    ViewState["sWhere"] = " AND ((DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) >= 1)  AND (DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) < 2))";
                else if(dplDias.SelectedValue == "2")
                    ViewState["sWhere"] = " AND ((DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) >= 3)  AND (DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) < 5))";
                else if (dplDias.SelectedValue == "3")
                    ViewState["sWhere"] = " AND ((DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) >= 5)  AND (DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) < 8))";
                else if (dplDias.SelectedValue == "4")
                    ViewState["sWhere"] = " AND ((DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) >= 8))";
                else if (dplDias.SelectedValue == "5")
                    ViewState["sWhere"] = " AND ((DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) >= 1)  AND (DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) <= 60))";
                BindGridView();
            }
        }

        protected void ImgbtnArchivo_Click(object sender, ImageClickEventArgs e)
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }
    }
}