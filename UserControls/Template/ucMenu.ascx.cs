using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicsuWeb.UserControls.Template
{
    public partial class ucMenu : System.Web.UI.UserControl
    {

        DataTable TodosSubMenu = new DataTable();
        string Err = "";
        string vIdeUsuario = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.PreRenderComplete += new EventHandler(Page_PreRenderComplete);
            //if (!fIdentity.IsAuthenticated)
            //{
            //    Response.Redirect("default.aspx");
            //}
            //string[] vUsuario = fIdentity.Ticket.Name.Split('|');
            //string vIdeRol = fIdentity.Ticket.UserData;
            vIdeUsuario = "1";//vUsuario[0];
            //Enc.Text = vUsuario[1];

            if (!IsPostBack)
            {
                CargarMenuSuperior();
                CargarMenuLateral();
            }
        }
        private void CargarMenuSuperior()
        {
            TodosSubMenu = CargarTodosSubMenu();
            //rptMenuSuperior.DataSource = CargarMenu();
            //rptMenuSuperior.DataBind();
        }
        private void CargarMenuLateral()
        {
            TodosSubMenu = CargarTodosSubMenu();
            rptMenuLateral.DataSource = CargarMenu();
            rptMenuLateral.DataBind();
        }
        //
        private DataTable CargarTodosSubMenu()
        {
            //string connString = ConfigurationManager.AppSettings["conexion"].ToString();
            //SqlConnection connection = new SqlConnection(connString);
            //SqlCommand selectCommand = new SqlCommand("SELECT M.IdeMenu, DesMenu, PreIdeMenu, urlMenu FROM Menu M INNER JOIN MenuRol MR ON M.IdeMenu=MR.IdeMenu INNER JOIN Usuario U ON U.IdeRol=MR.IdeRol WHERE U.IdeUsuario=" + vIdeUsuario, connection);
            //DataTable dt = new DataTable();
            //try
            //{
            //    connection.Open();
            //    SqlDataReader reader = selectCommand.ExecuteReader();
            //    if (reader.HasRows)
            //    {
            //        dt.Load(reader);
            //    }
            //    reader.Close();
            //    return dt;
            //}
            //catch (SqlException e)
            //{
            //    Err = "Error al cargar SubMenú. Detalle: " + e.Message;
            //    return null;
            //}
            //finally
            //{
            //    connection.Close();
            //}

            return new DataTable();
        }
        //
        private DataTable CargarMenu()
        {
            //string connString = ConfigurationManager.AppSettings["conexion"].ToString();
            //SqlConnection connection = new SqlConnection(connString);
            //SqlCommand selectCommand = new SqlCommand("SELECT M.IdeMenu, DesMenu, urlMenu FROM Menu M INNER JOIN MenuRol MR ON M.IdeMenu=MR.IdeMenu INNER JOIN Usuario U ON U.IdeRol=MR.IdeRol WHERE PreIdeMenu=0 AND U.IdeUsuario=" + vIdeUsuario, connection);
            //DataTable dt = new DataTable();
            //try
            //{
            //    connection.Open();
            //    SqlDataReader reader = selectCommand.ExecuteReader();
            //    if (reader.HasRows)
            //    {
            //        dt.Load(reader);
            //    }
            //    reader.Close();
            //    return dt;
            //}
            //catch (SqlException e)
            //{
            //    Err = "Error al cargar Menú. Detalle: " + e.Message;
            //    return null;
            //}
            //finally
            //{
            //    connection.Close();
            //}


            return new DataTable();
        }
        //
        protected void rptMenuSuperior_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    if (TodosSubMenu != null)
                    {
                        DataRowView drv = e.Item.DataItem as DataRowView;
                        string id = drv["IdeMenu"].ToString();
                        DataRow[] rows = TodosSubMenu.Select("PreIdeMenu=" + id, "DesMenu");
                        if (rows.Length > 0)
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.Append("<li class='divider'></li>");
                            foreach (var item in rows)
                            {
                                sb.Append("<li><a href='" + item["urlMenu"] + "'>" + item["DesMenu"] + "</a></li>");
                            }
                            (e.Item.FindControl("ltrlSubMenuSuperior") as Literal).Text = sb.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Err = "Error al cargar Menú Superior. Detalle: " + ex.Message;
            }
        }
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
                        string id = drv["IdeMenu"].ToString();
                        DataRow[] rows = TodosSubMenu.Select("PreIdeMenu=" + id, "DesMenu");
                        if (rows.Length > 0)
                        {
                            StringBuilder sb = new StringBuilder();
                            sb.Append("<ul class='nav nav-sidebar nav-sidebar2'>");
                            foreach (var item in rows)
                            {
                                sb.Append("<li><a href='" + item["urlMenu"] + "'>" + item["DesMenu"] + "</a></li>");
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

        protected void lnkCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/index.html");
       }

    }
}