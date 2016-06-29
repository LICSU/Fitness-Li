using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.Security;
using LicsuWeb.Validado.Clases;

namespace LicsuWeb.Validado
{
    public partial class ClaseAlumno : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["conexion"]);
        public static string fecha;
        public static int columnas;
        public static bool sw = false;
        public static DataRow row;
        string sErr = "";
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity);
            BindgvDisponibles();
            BindgvReservadas();
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            fecha = calendario.SelectedDate.ToShortDateString();
            lblCalendario.Text = calendario.SelectedDate.ToShortDateString();
        }

        protected void calendario_DayRender(object sender, DayRenderEventArgs e)
        {
            Style weekendStyle = new Style();
            weekendStyle.BackColor = System.Drawing.Color.Green;

            for (int i = 0; i < columnas; i++)
            {
                //row = adapter.obtenerFechas().Rows[i];

                if ((e.Day.Date == Convert.ToDateTime(row["Dia"].ToString())) && row["Unidad"].ToString().Equals(lblUnidad.Text))
                {
                    e.Cell.ApplyStyle(weekendStyle);
                    sw = true;
                }
            }
        }
//
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("HistoricoClases.aspx");
        }
//
        protected void BindgvDisponibles()
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            DataSet ds = new DataSet();
            //SELECT Dia, Hora, Nombre FROM dbo.Clases WHERE (Dia = @Dia) AND (Estado = 'Habilitada') AND (Unidad = @Unidad)
            string cmd = "SELECT ClaseProfesorID,ClaseFechaInicio,ClaseHoraInicio,ClaseDescripcion FROM ClaseProfesor CP INNER JOIN Clase C ON CP.ClaseID=C.ClaseID WHERE SucursalID=" + _autenticado.SucursalID + " AND PlanID=" + _autenticado.PlanID + " AND ClaseFechaInicio=CONVERT(date, GETDATE())";
            SqlDataAdapter ad = new SqlDataAdapter(cmd, conn);
            try
            {
                conn.Open();
                ad.Fill(ds);
                dt = ds.Tables[0];
                gvDisponibles.DataSource = dt;
                gvDisponibles.DataBind();
            }
            catch (SqlException ex)
            {
                sErr += "Error SQL al cargar el listado Disponibles. Detalle: " + ex.Message.Replace("'", "") + ". ";
            }
            finally
            {
                ad.Dispose();
                ds.Dispose();
                conn.Close();
                conn.Dispose();
            }
        }
        //
        protected void BindgvReservadas()
        {
            string connString = ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            DataSet ds = new DataSet();
            //SELECT Nombre, Hora, Fecha FROM dbo.Clases_Inscritas WHERE (Cedula = @Cedula) AND (Estado = 0)
            string cmd = "SELECT ClaseAlumnoID,ClaseFechaInicio,ClaseHoraInicio,ClaseDescripcion FROM ClaseProfesor CP INNER JOIN Clase C ON CP.ClaseID=C.ClaseID INNER JOIN ClaseAlumno CA ON CP.ClaseProfesorID=CA.ClaseProfesorID WHERE SucursalID=" + _autenticado.SucursalID + " AND PlanID=" + _autenticado.PlanID + " AND CA.UsuarioID=" + _autenticado.UsuarioID;
            SqlDataAdapter ad = new SqlDataAdapter(cmd, conn);
            try
            {
                conn.Open();
                ad.Fill(ds);
                dt = ds.Tables[0];
                gvReservadas.DataSource = dt;
                gvReservadas.DataBind();
            }
            catch (SqlException ex)
            {
                sErr += "Error SQL al cargar el listado Disponibles. Detalle: " + ex.Message.Replace("'", "") + ". ";
            }
            finally
            {
                ad.Dispose();
                ds.Dispose();
                conn.Close();
                conn.Dispose();
            }
        }










        protected void gvDisponibles_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Reservar")
            {
                try
                {
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Error, trantanto de reservar una clase. " + ex.Message + "');", true);
                }
            }
        }

        protected void gvReservadas_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancelar")
            {
                try
                {
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Error, trantanto de cancelar reserva. " + ex.Message + "');", true);
                }
            }
        }
            
            
            //WebApplication3.DataSet1TableAdapters.Clientes1TableAdapter adapter1 = new WebApplication3.DataSet1TableAdapters.Clientes1TableAdapter();

            ////if (e.CommandName == "Reservar")
            ////{
            ////    int index = Convert.ToInt32(e.CommandArgument);
            ////    GridViewRow row = gvDisponibles.Rows[index];


            ////    //WebApplication3.DataSet1TableAdapters.Clases_InscritasTableAdapter adapter = new WebApplication3.DataSet1TableAdapters.Clases_InscritasTableAdapter();
            ////    //WebApplication3.DataSet1TableAdapters.ClasesTableAdapter adapter4 = new WebApplication3.DataSet1TableAdapters.ClasesTableAdapter();


            ////    //System.Data.DataRow row1 = adapter1.ObtenerClasesActivas(Session["Cedula"].ToString()).Rows[0];
            ////    //string clases = row1["ClasesActivas"].ToString();
            ////    int nClases;
            ////    nClases = Convert.ToInt32(clases);

            ////    if (nClases > 0)
            ////    {
            ////        try
            ////        {
            ////            DateTime fechaEs = Convert.ToDateTime(row.Cells[1].Text);

            ////            if (fechaEs.Year >= DateTime.Now.Year)
            ////            {
            ////                if (fechaEs.Month >= DateTime.Now.Month)
            ////                {
            ////                    if (fechaEs.Day > DateTime.Now.Day)
            ////                    {
            ////                        System.Data.DataRow row2 = adapter4.ObtenerCodigo(row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text).Rows[0];
            ////                        System.Data.DataRow row3 = adapter4.ObtenerDocente(row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text).Rows[0];
            ////                        string docente = row3["Docente"].ToString();
            ////                        int codigo = Convert.ToInt32(row2["Codigo"].ToString());
            ////                        if (Convert.ToInt32(row2["Tomados"]) == 0)
            ////                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Usted es la primera persona en registrarse, tenga en cuenta que esta clase puede ser cancelada si no cumple el minimo de asistentes, si es así se le notificará en 30 min');", true);
            ////                        if (Convert.ToInt32(row2["Tomados"]) < Convert.ToInt32(row2["Cupos"]))
            ////                        {
            ////                            adapter.Insert(Label3.Text, row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text, codigo, 0);
            ////                            adapter4.ActualizarCupo(Convert.ToInt32(row2["Tomados"]) + 1, codigo);
            ////                            string clasesAd = row1["ClasesAdicionales"].ToString();
            ////                            int nClasesAd;
            ////                            nClases = Convert.ToInt32(clases) - 1;
            ////                            nClasesAd = Convert.ToInt32(clasesAd);
            ////                            adapter1.ActualizarClasesActivas(nClases, nClasesAd, Session["Cedula"].ToString());
            ////                            adapter.ActualizarDocentes(docente, row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text);
            ////                            GridView1.DataBind();
            ////                            DetailsView1.DataBind();
            ////                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La Clase fue Reservada correctamente');", true);

            ////                        }
            ////                        else
            ////                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase porque no existen cupos');", true);
            ////                    }
            ////                    else
            ////                    {
            ////                        if (fechaEs.Day == DateTime.Now.Day)
            ////                        {
            ////                            string hoy = DateTime.Now.ToShortTimeString();
            ////                            string[] HoraActual = DateTime.Now.ToShortTimeString().Split(':');
            ////                            string[] HoraEsc = row.Cells[2].Text.Split(':');
            ////                            int horaNumero;

            ////                            char[] MyChar = { ' ', 'p', '.', 'm', 'a' };
            ////                            string horaMinutoActual = HoraActual[1].TrimEnd(MyChar);

            ////                            if ((HoraActual[1].Contains("p.m")) && (Convert.ToInt32(HoraActual[0]) != 12))
            ////                            {
            ////                                horaNumero = Convert.ToInt32(HoraActual[0]) + 12;
            ////                                HoraActual[0] = horaNumero.ToString();
            ////                            }



            ////                            int horasS = Int32.Parse(HoraActual[0]);
            ////                            int horasE = Int32.Parse(HoraEsc[0]);

            ////                            if (horasE >= horasS)
            ////                            {
            ////                                System.Data.DataRow row2 = adapter4.ObtenerCodigo(row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text).Rows[0];
            ////                                System.Data.DataRow row3 = adapter4.ObtenerDocente(row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text).Rows[0];
            ////                                string docente = row3["Docente"].ToString();
            ////                                int codigo = Convert.ToInt32(row2["Codigo"].ToString());
            ////                                if (Convert.ToInt32(row2["Tomados"]) == 0)
            ////                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Usted es la primera persona en registrarse, tenga en cuenta que esta clase puede ser cancelada si no cumple el minimo de asistentes, si es así se le notificará en 30 min');", true);
            ////                                if (Convert.ToInt32(row2["Tomados"]) < Convert.ToInt32(row2["Cupos"]))
            ////                                {
            ////                                    adapter.Insert(Label3.Text, row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text, codigo, 0);
            ////                                    adapter4.ActualizarCupo(Convert.ToInt32(row2["Tomados"]) + 1, codigo);
            ////                                    string clasesAd = row1["ClasesAdicionales"].ToString();
            ////                                    int nClasesAd;
            ////                                    nClases = Convert.ToInt32(clases) - 1;
            ////                                    nClasesAd = Convert.ToInt32(clasesAd);
            ////                                    adapter1.ActualizarClasesActivas(nClases, nClasesAd, Session["Cedula"].ToString());
            ////                                    adapter.ActualizarDocentes(docente, row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text);
            ////                                    GridView1.DataBind();
            ////                                    DetailsView1.DataBind();
            ////                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La Clase fue Reservada correctamente');", true);
            ////                                }
            ////                                else
            ////                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase porque no existen cupos');", true);
            ////                            }
            ////                            else
            ////                            {
            ////                                if ((Convert.ToInt32(horaMinutoActual)) > (Convert.ToInt32(HoraEsc[1]) + 15))
            ////                                {
            ////                                    System.Data.DataRow row2 = adapter4.ObtenerCodigo(row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text).Rows[0];
            ////                                    System.Data.DataRow row3 = adapter4.ObtenerDocente(row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text).Rows[0];
            ////                                    string docente = row3["Docente"].ToString();
            ////                                    int codigo = Convert.ToInt32(row2["Codigo"].ToString());
            ////                                    if (Convert.ToInt32(row2["Tomados"]) == 0)
            ////                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Usted es la primera persona en registrarse, tenga en cuenta que esta clase puede ser cancelada si no cumple el minimo de asistentes, si es así se le notificará en 30 min');", true);
            ////                                    if (Convert.ToInt32(row2["Tomados"]) < Convert.ToInt32(row2["Cupos"]))
            ////                                    {
            ////                                        adapter.Insert(Label3.Text, row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text, codigo, 0);
            ////                                        adapter4.ActualizarCupo(Convert.ToInt32(row2["Tomados"]) + 1, codigo);
            ////                                        string clasesAd = row1["ClasesAdicionales"].ToString();
            ////                                        int nClasesAd;
            ////                                        nClases = Convert.ToInt32(clases) - 1;
            ////                                        nClasesAd = Convert.ToInt32(clasesAd);
            ////                                        adapter1.ActualizarClasesActivas(nClases, nClasesAd, Session["Cedula"].ToString());
            ////                                        adapter.ActualizarDocentes(docente, row.Cells[3].Text, row.Cells[1].Text, row.Cells[2].Text);
            ////                                        GridView1.DataBind();
            ////                                        DetailsView1.DataBind();
            ////                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La Clase fue Reservada correctamente');", true);
            ////                                    }
            ////                                    else
            ////                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase porque no existen cupos');", true);
            ////                                }
            ////                                else
            ////                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase');", true);
            ////                            }

            ////                        }
            ////                        else
            ////                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase');", true);
            ////                    }
            ////                }
            ////                else
            ////                {
            ////                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase');", true);
            ////                }
            ////            }
            ////            else
            ////            {
            ////                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('NO puede reservar esta clase');", true);
            ////            }
            ////        }
            ////        catch (Exception ex)
            ////        {
            ////            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Ya tiene una clase el mismo día a la misma hora');", true);
            ////        }
            ////    }
            ////    else
            ////    {
            ////        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Usted no tiene clases activas en este momento');", true);
            ////    }
            ////}
            ////if (e.CommandName == "Cancelar")
            ////{
            ////    //WebApplication3.DataSet1TableAdapters.Clases_InscritasTableAdapter adapter = new WebApplication3.DataSet1TableAdapters.Clases_InscritasTableAdapter();
            ////    //WebApplication3.DataSet1TableAdapters.HistoricoTableAdapter adapter2 = new WebApplication3.DataSet1TableAdapters.HistoricoTableAdapter();
            ////    //WebApplication3.DataSet1TableAdapters.ClasesTableAdapter adapter4 = new WebApplication3.DataSet1TableAdapters.ClasesTableAdapter();

            ////    try
            ////    {
            ////        int index = Convert.ToInt32(e.CommandArgument);
            ////        GridViewRow row = GridView1.Rows[index];

            ////        //System.Data.DataRow row2 = adapter4.ObtenerCodigo(row.Cells[1].Text, row.Cells[3].Text, row.Cells[2].Text).Rows[0];
            ////        //int codigo = Convert.ToInt32(row2["Codigo"].ToString());

            ////        DateTime fech = DateTime.Now;
            ////        string fechacom = fech.ToShortDateString();
            ////        DateTime fecha = Convert.ToDateTime(fechacom);
            ////        string[] HoraSer = DateTime.Now.ToShortTimeString().Split(':');
            ////        string[] HoraEsc = row.Cells[2].Text.Split(':');
            ////        DateTime fechaEs = Convert.ToDateTime(row.Cells[3].Text);
            ////        int horaNumero = 0;

            ////        if (HoraSer[1].Contains("p.m"))
            ////        {
            ////            horaNumero = Convert.ToInt32(HoraSer[0]) + 12;
            ////            HoraSer[0] = horaNumero.ToString();
            ////        }


            ////        //<JG> convierte a formato 24 horas, por configuracion regional el formato por defecto es (a.m - p.m)
            ////        string[] arrayHoraClaseActual = DateTime.Now.ToString("HH:mm").Split(':');
            ////        int horasActual = Int32.Parse(arrayHoraClaseActual[0]);
            ////        int minutosActual = Int32.Parse(arrayHoraClaseActual[1]);
            ////        //</JG>


            ////        int horasE = Int32.Parse(HoraEsc[0]);
            ////        int minutosE = Int32.Parse(HoraEsc[1]);


            ////        if (fechaEs.Year >= fech.Year)
            ////        {
            ////            if (fechaEs.Month >= fech.Month)
            ////            {
            ////                if (fechaEs.Day == fech.Day)
            ////                {

            ////                    //<JG> verifica que se pueda cancelar con 3 horas (180 minutos) de anticipacion

            ////                    int diferenciaMinutos = ObtenerDiferenciaMinutos(horasE, minutosE, horasActual, minutosActual);

            ////                    //<JG> validacion anterior
            ////                    //if ((horaNumero + 4) <= Convert.ToInt32(HoraEsc[0]))
            ////                    if (diferenciaMinutos > 180)
            ////                    {
            ////                        //adapter2.Insert(row.Cells[1].Text, row.Cells[3].Text, row.Cells[2].Text, Label3.Text);
            ////                        //adapter.EliminarClase(Label3.Text, row.Cells[1].Text, row.Cells[3].Text, row.Cells[2].Text);
            ////                        System.Data.DataRow row1 = adapter1.ObtenerClasesActivas(Label3.Text).Rows[0];
            ////                        //adapter4.ActualizarCupo(Convert.ToInt32(row2["Tomados"]) - 1, codigo);
            ////                        string clases = row1["ClasesActivas"].ToString();
            ////                        string clases2 = row1["ClasesAdicionales"].ToString();
            ////                        int nClases;
            ////                        int mClases;
            ////                        nClases = Convert.ToInt32(clases) + 1;
            ////                        mClases = Convert.ToInt32(clases);
            ////                        adapter1.ActualizarClasesActivas(nClases, mClases, Label3.Text);
            ////                        //Response.Redirect("Reservas.aspx");  
            ////                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La Clase fue cancelada correctamente');", true);
            ////                        GridView1.DataBind();
            ////                        DetailsView1.DataBind();
            ////                    }
            ////                    else
            ////                    {
            ////                        lblMensaje.Visible = false;
            ////                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La clase no se puede cancelar, porque faltan menos de 3 horas para comenzar.  ');", true);
            ////                    }
            ////                }
            ////                else
            ////                {
            ////                    if (fechaEs.Day > fech.Day)
            ////                    {
            ////                        //adapter.EliminarClase(Label3.Text, row.Cells[1].Text, row.Cells[3].Text, row.Cells[2].Text);
            ////                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La Clase fue cancelada correctamente');", true);
            ////                        //Response.Redirect("Reservas.aspx");  
            ////                        System.Data.DataRow row1 = adapter1.ObtenerClasesActivas(Label3.Text).Rows[0];
            ////                        //adapter4.ActualizarCupo(Convert.ToInt32(row2["Tomados"]) - 1, codigo);
            ////                        string clases = row1["ClasesActivas"].ToString();
            ////                        string clases2 = row1["ClasesAdicionales"].ToString();
            ////                        int nClases;
            ////                        int mClases;
            ////                        nClases = Convert.ToInt32(clases) + 1;
            ////                        mClases = Convert.ToInt32(clases);
            ////                        adapter1.ActualizarClasesActivas(nClases, mClases, Label3.Text);
            ////                        //Response.Redirect("Reservas.aspx");  
            ////                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('La Clase fue cancelada correctamente');", true);
            ////                        GridView1.DataBind();
            ////                        DetailsView1.DataBind();
            ////                    }
            ////                    else
            ////                    {
            ////                        lblMensaje.Visible = false;
            ////                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Esta clase ya finalizó, comuniquese con el Administrador');", true);
            ////                    }
            ////                }
            ////            }
            ////            else
            ////            {
            ////                lblMensaje.Visible = false;
            ////                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Esta clase ya finalizó, comuniquese con el Administrador');", true);
            ////            }
            ////        }
            ////        else
            ////        {
            ////            lblMensaje.Visible = false;
            ////            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Esta clase ya finalizó, comuniquese con el Administrador');", true);
            ////        }
            ////    }
            ////    catch (Exception ex)
            ////    {
            ////        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertIns", "alert('Error, trantanto de cancelar reserva. " + ex.Message + "');", true);
            ////    }
            ////}

        private int ObtenerDiferenciaMinutos(int horas, int minutos, int horasRestar, int minutosRestar)
        {

            int difererenciaHoraMinutos = (horas - horasRestar) * 60;
            int diferenciaMinutos = minutos - minutosRestar;
            return difererenciaHoraMinutos + diferenciaMinutos;
        }

    }
}