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
    public partial class reporteCalificaciones : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "", sSelecSQL = "";
        DataTable dt;
        DataSet ds;
        GridView grid;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sSelecSQL = "SELECT DISTINCT(Clase.ClaseDescripcion) as TXT, Clase.ClaseID as VAL"+
                            " FROM   Alumno_Nivel_Clase INNER JOIN "+
                            " Clase ON Alumno_Nivel_Clase.ClaseID = Clase.ClaseID";
                Utilidades.CargarListado(ref dplUnidad, sSelecSQL, cn, ref Err, true);
                BindGridView();
            }
        }

        protected void BindGridView()
        {
            try
            {
                cn.Open();
                string cmd2 = "SELECT "+
                            " (SELECT UsuarioNombre+' '+UsuarioApellido FROM Usuario WHERE UsuarioID = Alumno_Nivel_Clase.UsuarioID) as Alumno, "+
                            " (SELECT ClaseDescripcion FROM Clase WHERE ClaseID = Alumno_Nivel_Clase.ClaseID) as Clase, "+
                            " (SELECT NivelNombre FROM Nivel WHERE NivelID =  Alumno_Nivel_Clase.NivelID) as Nivel, "+
                            " Elemento.ElementoNombre as Elemento, "+
                            " Calificacion.CalificacionNombre as Calificacion, "+
                            " (SELECT UsuarioNombre+' '+UsuarioApellido FROM Usuario WHERE UsuarioID =Alumno_Nivel_Clase.ProfesorID) as Profesor,"+
                            " CONVERT(VARCHAR, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg, 103) as Fecha,"+
                            " CONVERT(VARCHAR, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg, 108) as Hora"+
                            " FROM Alumno_Nivel_Clase INNER JOIN"+
                            " Alumno_Nivel_Clase_Elemento ON Alumno_Nivel_Clase.AluNivClaseID = Alumno_Nivel_Clase_Elemento.AluNivClaseID INNER JOIN"+
                            " Calificacion ON Alumno_Nivel_Clase_Elemento.CalificacionID = Calificacion.CalificacionID INNER JOIN"+
                            " Clase_Nivel_Elemento ON Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID AND "+
                            " Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID INNER JOIN"+
                            " Elemento ON Clase_Nivel_Elemento.ElementoID = Elemento.ElementoID WHERE Alumno_Nivel_Clase.UsuarioID != 1 " +
                              ViewState["FiltroCedula"] + " " + ViewState["FiltroEmpresa"] + " " + ViewState["FiltroRegistro"]+
                            " ORDER BY Fecha DESC, Hora DESC";
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "Alumno";
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

        protected void Buscar_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text != "")
            {
                ViewState["FiltroCedula"] = " AND Alumno_Nivel_Clase.UsuarioID = (SELECT UsuarioID FROM Usuario WHERE UsuarioCedula LIKE '%" + txtSearch.Text + "%') ";
            }
            BindGridView();
        }

        protected void btnFiltroFecha_Click(object sender, EventArgs e)
        {
            if (txtFechaRegistroDesde.Text != "" && txtFechaRegistroHasta.Text == "")
            {
                ViewState["FiltroRegistro"] = " AND (CONVERT(DATE, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg,103) >= CONVERT(DATE, '" + txtFechaRegistroDesde.Text + "', 103))";
            }
            else if (txtFechaRegistroDesde.Text == "" && txtFechaRegistroHasta.Text != "")
            {
                ViewState["FiltroRegistro"] = " AND (CONVERT(DATE, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg,103) <= CONVERT(DATE, '" + txtFechaRegistroHasta.Text + "', 103))";
            }
            else if (txtFechaRegistroDesde.Text != "" && txtFechaRegistroHasta.Text != "")
            {
                ViewState["FiltroRegistro"] = " AND ( (CONVERT(DATE, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg,103) <= CONVERT(DATE, '" + txtFechaRegistroHasta.Text + "', 103)) AND (CONVERT(DATE, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg,103) >= CONVERT(DATE, '" + txtFechaRegistroDesde.Text + "', 103)) )";
            }
            BindGridView();
        }

        protected void btnUnidad_Click(object sender, EventArgs e)
        {
            if (dplUnidad.SelectedValue != "")
            {
                ViewState["FiltroEmpresa"] = " AND (Alumno_Nivel_Clase.ClaseID = " + dplUnidad.SelectedValue + ")";
            }
            else
            {
                MostrarMsjModal("Seleccione un valor de la lista", "ERR");
            }
            BindGridView();
        }

        protected void btnDescargar_Click(object sender, ImageClickEventArgs e)
        {
            string Hora = DateTime.Now.ToString("dd_MM_yyy_HH_mm");
            grid = new GridView();
            cn.Open();
            string cmd2 = "SELECT "+
                            " (SELECT UsuarioNombre+' '+UsuarioApellido FROM Usuario WHERE UsuarioID = Alumno_Nivel_Clase.UsuarioID) as Alumno, "+
                            " (SELECT ClaseDescripcion FROM Clase WHERE ClaseID = Alumno_Nivel_Clase.ClaseID) as Clase, "+
                            " (SELECT NivelNombre FROM Nivel WHERE NivelID =  Alumno_Nivel_Clase.NivelID) as Nivel, "+
                            " Elemento.ElementoNombre as Elemento, "+
                            " Calificacion.CalificacionNombre as Calificacion, "+
                            " (SELECT UsuarioNombre+' '+UsuarioApellido FROM Usuario WHERE UsuarioID =Alumno_Nivel_Clase.ProfesorID) as Profesor,"+
                            " CONVERT(VARCHAR, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg, 103) as Fecha,"+
                            " CONVERT(VARCHAR, Alumno_Nivel_Clase_Elemento.AlumNivClasElemFechaReg, 108) as Hora"+
                            " FROM Alumno_Nivel_Clase INNER JOIN"+
                            " Alumno_Nivel_Clase_Elemento ON Alumno_Nivel_Clase.AluNivClaseID = Alumno_Nivel_Clase_Elemento.AluNivClaseID INNER JOIN"+
                            " Calificacion ON Alumno_Nivel_Clase_Elemento.CalificacionID = Calificacion.CalificacionID INNER JOIN"+
                            " Clase_Nivel_Elemento ON Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID AND "+
                            " Alumno_Nivel_Clase_Elemento.ClaseElemNivID = Clase_Nivel_Elemento.ClaseElemNivID INNER JOIN"+
                            " Elemento ON Clase_Nivel_Elemento.ElementoID = Elemento.ElementoID WHERE Alumno_Nivel_Clase.UsuarioID != 1 " +
                              ViewState["FiltroCedula"] + " " + ViewState["FiltroEmpresa"] + " " + ViewState["FiltroRegistro"]+
                            " ORDER BY Fecha DESC, Hora DESC";
            SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
            DataSet ds = new DataSet();
            dAdapter.Fill(ds);
            dt = ds.Tables[0];
            string[] TablaID = new string[1];
            TablaID[0] = "Alumno";
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
            Response.AddHeader("Content-Disposition", "attachment;filename=Reporte_Calificaciones_" + Hora + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();    
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }
<<<<<<< HEAD
=======

        protected void btnEstados_Click(object sender, EventArgs e)
        {
            if (dplUnidad.SelectedValue != "")
            {
                ViewState["FiltroEmpresa"] = " AND (Alumno_Nivel_Clase.ClaseID = " + dplUnidad.SelectedValue + ")";
            }
            else
            {
                MostrarMsjModal("Seleccione un valor de la lista", "ERR");
            }
            BindGridView();
        }
>>>>>>> origin/master
    }
}