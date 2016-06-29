using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using LicsuWeb.Validado.Clases;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace LicsuWeb.Validado
{
    public partial class ucMenu : System.Web.UI.UserControl
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        DataTable TodosSubMenu = new DataTable();
        string Err = "";
        public string urlImagenUsuario = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.PreRenderComplete += new EventHandler(Page_PreRenderComplete);
            MsjMenuLateral.Text = "";
            _autenticado = new UsuarioAutenticado(fIdentity);

            if (!IsPostBack)
            {
                //CargarMenuSuperior();
                CargarImagenUsuario();
                CargarMenuLateral();
            }
        }
        //private void CargarMenuSuperior()
        //{
        //    TodosSubMenu = CargarTodosSubMenu();
        //    rptMenuSuperior.DataSource = CargarMenu();
        //    rptMenuSuperior.DataBind();
        //}
//
        private void CargarImagenUsuario()
        {
            if (_autenticado.RolID == "1")
            {
                urlImagenUsuario = "img/usu_admin_gen.png";
            }
            else if (_autenticado.RolID == "2")
            {
                urlImagenUsuario = "img/usu_profesor.png";
            }
            else if (_autenticado.RolID == "3")
            {
                urlImagenUsuario = "img/usu_alumno.png";
            }
            else if (_autenticado.RolID == "4")
            {
                urlImagenUsuario = "img/usu_admin.png";
            }
            else if (_autenticado.RolID == "5")
            {
                urlImagenUsuario = "img/usu_admin_suc.png";
            }
        }

//
        private void CargarMenuLateral()
        {
            TodosSubMenu = CargarTodosSubMenu();
            rptMenuLateral.DataSource = CargarMenu();
            rptMenuLateral.DataBind();
        }
//
        private DataTable CargarTodosSubMenu()
        {
            string connString = ConfigurationManager.AppSettings["conexion"].ToString();
            SqlConnection connection = new SqlConnection(connString);
            SqlCommand selectCommand = new SqlCommand("SELECT M.MenuID, MenuDescripcion, MenuIdPadre, MenuURL FROM Menu M INNER JOIN MenuRol MR ON M.MenuID=MR.MenuID INNER JOIN UsuarioRol UR ON UR.RolID=MR.RolID WHERE UR.SucursalID=" + _autenticado.SucursalID + " AND UR.RolID=" + _autenticado.RolID + " AND UR.UsuarioID=" + _autenticado.UsuarioID, connection);            
            DataTable dt = new DataTable();
            try
            {
                connection.Open();
                SqlDataReader reader = selectCommand.ExecuteReader();
                if (reader.HasRows)
                {
                    dt.Load(reader);
                }
                reader.Close();
                return dt;
            }
            catch (SqlException e)
            {
                Err = "Error al cargar SubMenú. Detalle: " + e.Message;
                return null;
            }
            finally
            {
                connection.Close();
            }
        }
//
        private DataTable CargarMenu()
        {
            if (Err == string.Empty)
            {
                string connString = ConfigurationManager.AppSettings["conexion"].ToString();
                SqlConnection connection = new SqlConnection(connString);
                SqlCommand selectCommand = new SqlCommand("SELECT M.MenuID, MenuDescripcion, MenuURL FROM Menu M INNER JOIN MenuRol MR ON M.MenuID=MR.MenuID INNER JOIN UsuarioRol UR ON UR.RolID=MR.RolID WHERE MenuIDPadre=0 AND UR.SucursalID=" + _autenticado.SucursalID + " AND UR.RolID=" + _autenticado.RolID + " AND UR.UsuarioID=" + _autenticado.UsuarioID, connection);
                DataTable dt = new DataTable();
                try
                {
                    connection.Open();
                    SqlDataReader reader = selectCommand.ExecuteReader();
                    if (reader.HasRows)
                    {
                        dt.Load(reader);
                    }
                    reader.Close();
                    return dt;
                }
                catch (SqlException e)
                {
                    Err = "Error al cargar Menú. Detalle: " + e.Message;
                    return null;
                }
                finally
                {
                    connection.Close();
                }
            }
            else { return null; }
        }
        //////
        ////protected void rptMenuSuperior_ItemDataBound(object sender, RepeaterItemEventArgs e)
        ////{
        ////    try
        ////    {
        ////        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        ////        {
        ////            if (TodosSubMenu != null)
        ////            {
        ////                DataRowView drv = e.Item.DataItem as DataRowView;
        ////                string id = drv["IdeMenu"].ToString();
        ////                DataRow[] rows = TodosSubMenu.Select("PreIdeMenu=" + id, "DesMenu");
        ////                if (rows.Length > 0)
        ////                {
        ////                    StringBuilder sb = new StringBuilder();
        ////                    sb.Append("<li class='divider'></li>");
        ////                    foreach (var item in rows)
        ////                    {
        ////                        sb.Append("<li><a href='" + item["urlMenu"] + "'>" + item["DesMenu"] + "</a></li>");
        ////                    }
        ////                    (e.Item.FindControl("ltrlSubMenuSuperior") as Literal).Text = sb.ToString();
        ////                }
        ////            }
        ////        }
        ////    }
        ////    catch (Exception ex)
        ////    {
        ////        Err = "Error al cargar Menú Superior. Detalle: " + ex.Message;
        ////    }
        ////}
//
        protected void rptMenuLateral_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    if (TodosSubMenu != null)
                    {
                        DataRowView drv = e.Item.DataItem as DataRowView;
                        string id = drv["MenuID"].ToString();
                        DataRow[] rows = TodosSubMenu.Select("MenuIDPadre=" + id, "MenuDescripcion");
                        if (rows.Length > 0)
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.Append("<ul class='nav nav-sidebar nav-sidebar2'>");
                            foreach (var item in rows)
                            {
                                sb.Append("<li><a href='" + item["MenuURL"] + "'>" + item["MenuDescripcion"] + "</a></li>");
                            }
                            sb.Append("</ul>");
                            (e.Item.FindControl("ltrlSubMenuLateral") as Literal).Text = sb.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Err = "Error al cargar Menú Lateral. Detalle: " + ex.Message;
            }
        }
//
        private void Page_PreRenderComplete(object sender, EventArgs e)
        {
            if (Err != string.Empty)
            {
                MsjMenuLateral.Text = "<div class='alert alert-warning alert-dismissable'><button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Error: </strong>" + Err + "</div>";
            }
        }

    }
}