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
    public partial class ReservaAlumnoLicsu : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);
        DataTable dt;
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        private string UsuarioID, totalClasesRegulares, totalClasesComplemen, disponiblesClasesRegulares, disponiblesClasesComplemen, NombrePlan, FechaFin, Deuda, FechaFin2;
        private string sSelectSQL = "", Err="", sSelectSQL2 = "";
        static float clasesDispNum, costoUnidadNum;
        static string ClasePlantillaID ="", ClaseID="", ClaseTipo ="";
        Table tablaPuestos;
        TableRow tableRow;
        TableCell tableCell;
        ImageButton imgButton;
        CheckBox chkBox;
        static string fechaFiltro;
        Image imgPrueba;
        bool bandInactivo = true;
        Label lblPrueba;

        protected void Page_Load(object sender, EventArgs e)
        {
            _autenticado = new UsuarioAutenticado(fIdentity);
            UsuarioID = _autenticado.UsuarioID;
            bool PlanActivo = true;
            if (_autenticado.ClienteID != "1")
            { 
                PlanActivo = bool.Parse(Utilidades.EjeSQL("SELECT PlanActivo FROM PlanEmpresa WHERE UsuarioID = "+UsuarioID, cn, ref Err, true));
            }
             
            if (!PlanActivo)
            {
                MostrarMsjModal("Actualmente se encuentra inactivo en el sistema, si lo desea active el plan en la opción inicio, botón Activar / Desactivar Plan", "ADV");
                bandInactivo = false;
            }
            else
            {

                if (Request.QueryString["aviso"] == "true")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "MostrarAviso", "MostrarAviso();", true);
                }
                if (_autenticado.ClienteID != "1")
                {
                    sSelectSQL = "SELECT seleccionoClases FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                    bool band = bool.Parse(Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true));

                    if (!band)
                    {
                        //MostrarMsjModal("BOOL: " + band, "");
                        //Mostrar Modal de Seleccion de Clases..
                        ScriptManager.RegisterStartupScript(this, GetType(), "MostrarCantidad", "MostrarCantidad();", true);
                    }
                }
                /* */

                if (Request.QueryString["mostrar"] == "si")
                {
                    CargarDetalles();
                    fechaFiltro = Request.QueryString["fecha"].ToString();
                    ViewState["fechaActual"] = " AND (ClasePlantillaFecha = CONVERT(VARCHAR, '" + fechaFiltro + "', 103))";
                    ViewState["ClienteID"] = _autenticado.ClienteID;
                    calendario.SelectedDate = DateTime.Parse(fechaFiltro);
                    //Validar si hay puestos
                    sSelectSQL = "SELECT COUNT(*) FROM ClaseEspacio WHERE Ocupado = 0 AND ClasePlantillaID = " + Request.QueryString["claseplantillaid"].ToString();
                    string Ocupados = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                    if (Ocupados != "0")
                    {
                        cargarPuestos(Request.QueryString["claseid"].ToString(), Request.QueryString["claseplantillaid"].ToString());
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "MostrarLista", "MostrarLista();", true);
                    }
                    BindGridView();
                    BindGridViewReservas();
                }
                else
                {
                    if (!IsPostBack)
                    {
                        CargarDetalles();
                        calendario.SelectedDate = DateTime.Today;
                        ViewState["ClienteID"] = _autenticado.ClienteID;
                        ViewState["fechaActual"] = " AND (ClasePlantillaFecha = CONVERT(VARCHAR, SYSDATETIME(), 103))";
                        // " AND CONVERT(VARCHAR, ClasePlantillaHora, 24) > CONVERT(VARCHAR, SYSDATETIME(), 24))";
                        BindGridView();
                        BindGridViewReservas();
                    }
                }
                if (_autenticado.ClienteID != "1")
                {
                    sSelectSQL = "SELECT AutorizacionActivo FROM planAutorizacion WHERE UsuarioID = " + _autenticado.UsuarioID;
                    bool activo = bool.Parse(Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true));
                    if (!activo)
                    {
                        sSelectSQL = "SELECT FechaRegistro FROM planAutorizacion WHERE UsuarioID =" + _autenticado.UsuarioID;
                        string fechaRegistro = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                        DateTime fecha = Convert.ToDateTime(fechaRegistro);
                        TimeSpan diff = (DateTime.Today) - fecha;
                        int diferencia = diff.Days;
                        if (diferencia > 3)
                        {
                            GridView1.Enabled = false;
                            GridView2.Enabled = false;
                            MostrarMsjModal("Sus reservas se encuentran desactivadas.", "ADV");
                        }
                    }
                }
            }
            
        }
        protected void cargarPuestos(string claseID, string claseplantillaID)
        {
            sSelectSQL = "SELECT SalonID FROM ClasePlantilla WHERE ClasePlantillaID=" + claseplantillaID;
            int SalonID = int.Parse(Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true));
            sSelectSQL = "SELECT frenteSalon FROM Salon WHERE SalonID = " + SalonID;
            string imagenFrente = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true) + ".jpg";
            sSelectSQL = "SELECT formaSalon FROM Salon WHERE SalonID = " + SalonID;
            string formaSalon = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
            
            if (imagenFrente == "frenteA.jpg")
            {               
                pintarA(claseID, claseplantillaID, "~/Validado/Imagenes/AlumnoALibre.jpg", "~/Validado/Imagenes/AlumnoAOcupado.jpg", "<p style='margin:0 auto; text-align:center; margin-bottom:30px;'><img src='Imagenes/frenteA.jpg' /></p>");             
            }
            if (imagenFrente == "frenteB.jpg")
            {
                pintarB(claseID, claseplantillaID, "~/Validado/Imagenes/AlumnoBLibre.jpg", "~/Validado/Imagenes/AlumnoBOcupado.jpg", "<p style='margin:0 auto;'><img src='Imagenes/frenteB.jpg' /></p>");
            }
            if (imagenFrente == "frenteC.jpg")
            {
                pintarC(claseID, claseplantillaID, "~/Validado/Imagenes/AlumnoCLibre.jpg", "~/Validado/Imagenes/AlumnoCOcupado.jpg", "<p style='margin:0 auto; text-align:center; margin-top:30px;'><img src='Imagenes/frenteC.jpg' /></p>");
            }
            if (imagenFrente == "frenteD.jpg")
            {
                pintarD(claseID, claseplantillaID, "~/Validado/Imagenes/AlumnoDLibre.jpg", "~/Validado/Imagenes/AlumnoDOcupado.jpg", "<p style='margin:0 auto;'><img src='Imagenes/frenteD.jpg' /></p>");
            }
            
        }
        public void pintarC(string claseID, string claseplantillaID, string alumnoLibre, string alumnoOcupado, string frente)
        {
             //Fila Superior
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='row'>";
            pnDisponibles.Controls.Add(literal);
            tablaPuestos = new Table();
            int[] datosEspacios;
            string[] idClaseEspacio;
            tablaPuestos.CssClass = "table-responsive puestos";
            tablaPuestos.ID = "tblPuestos";
            int filas = int.Parse(Utilidades.EjeSQL("SELECT ClaseFilas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            int columnas = int.Parse(Utilidades.EjeSQL("SELECT ClaseColumnas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            datosEspacios = new int[filas * columnas];
            idClaseEspacio = new string[filas * columnas];
            sSelectSQL = "SELECT * FROM ClaseEspacio WHERE ClasePlantillaID = " + claseplantillaID;
            int cont = 0;
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    datosEspacios[cont] = int.Parse(dr["Ocupado"].ToString());
                    idClaseEspacio[cont] = dr["ClaseEspacioID"].ToString();
                    cont++;
                }
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal("Error: " + sq.Message, "ERR");
                cn.Close();
            }

            cont = 0;
            for (int i = 0; i < filas; i++)
            {
                tableRow = new TableRow();
                tablaPuestos.Controls.Add(tableRow);
                for (int j = 0; j < columnas; j++)
                {
                    tableCell = new TableCell();
                    tableRow.Controls.Add(tableCell);
                    imgButton = new ImageButton();
                    imgButton.Click += new ImageClickEventHandler(img_Click);
                    if (datosEspacios[cont] == 0)
                        imgButton.ImageUrl = alumnoLibre;
                    else
                    {
                        imgButton.ImageUrl = alumnoOcupado;
                        imgButton.Enabled = false;
                    }
                    imgButton.ID = idClaseEspacio[cont];
                    cont++;
                    tableCell.Controls.Add(imgButton);
                }
            }
            pnDisponibles.Controls.Add(tablaPuestos);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);

            //Fila superior            
            literal = new Literal();
            literal.Text = "<div class='row'>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = frente;
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
            ScriptManager.RegisterStartupScript(this, GetType(), "VentanaPrueba", "VentanaPrueba();", true);
        }
        public void pintarA(string claseID, string claseplantillaID, string alumnoLibre, string alumnoOcupado, string frente)
        {
            //Fila superior
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='row'>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = frente;
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);

            //Fila Inferior
            literal = new Literal();
            literal.Text = "<div class='row'>";
            pnDisponibles.Controls.Add(literal);
            tablaPuestos = new Table();
            int[] datosEspacios;
            string[] idClaseEspacio;
            tablaPuestos.CssClass = "table-responsive puestos";
            tablaPuestos.ID = "tblPuestos";
            int filas = int.Parse(Utilidades.EjeSQL("SELECT ClaseFilas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            int columnas = int.Parse(Utilidades.EjeSQL("SELECT ClaseColumnas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            datosEspacios = new int[filas * columnas];
            idClaseEspacio = new string[filas * columnas];
            sSelectSQL = "SELECT * FROM ClaseEspacio WHERE ClasePlantillaID = " + claseplantillaID;
            int cont = 0;
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    datosEspacios[cont] = int.Parse(dr["Ocupado"].ToString());
                    idClaseEspacio[cont] = dr["ClaseEspacioID"].ToString();
                    cont++;
                }
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal("Error: " + sq.Message, "ERR");
                cn.Close();
            }

            cont = 0;
            for (int i = 0; i < filas; i++)
            {
                tableRow = new TableRow();
                tablaPuestos.Controls.Add(tableRow);
                for (int j = 0; j < columnas; j++)
                {
                    tableCell = new TableCell();
                    tableRow.Controls.Add(tableCell);
                    imgButton = new ImageButton();
                    imgButton.Click += new ImageClickEventHandler(img_Click);
                    if (datosEspacios[cont] == 0)
                        imgButton.ImageUrl = alumnoLibre;
                    else
                    {
                        imgButton.ImageUrl = alumnoOcupado;
                        imgButton.Enabled = false;
                    }
                    imgButton.ID = idClaseEspacio[cont];
                    cont++;
                    tableCell.Controls.Add(imgButton);
                }
            }
            pnDisponibles.Controls.Add(tablaPuestos);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
            ScriptManager.RegisterStartupScript(this, GetType(), "VentanaPrueba", "VentanaPrueba();", true);
        }
        public void pintarD(string claseID, string claseplantillaID, string alumnoLibre, string alumnoOcupado, string frente)
        {

            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='row'>";
            pnDisponibles.Controls.Add(literal);
            //Columna Izquierda Profesor
            literal = new Literal();
            literal.Text = "<div class='col-md-1'>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = frente;
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
                        
            literal = new Literal();
            literal.Text = "<div class='col-md-10'>";
            pnDisponibles.Controls.Add(literal);
            tablaPuestos = new Table();
            int[] datosEspacios;
            string[] idClaseEspacio;
            tablaPuestos.CssClass = "table-responsive puestos";
            tablaPuestos.ID = "tblPuestos";
            int filas = int.Parse(Utilidades.EjeSQL("SELECT ClaseFilas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            int columnas = int.Parse(Utilidades.EjeSQL("SELECT ClaseColumnas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            datosEspacios = new int[filas * columnas];
            idClaseEspacio = new string[filas * columnas];
            sSelectSQL = "SELECT * FROM ClaseEspacio WHERE ClasePlantillaID = " + claseplantillaID;
            int cont = 0;
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    datosEspacios[cont] = int.Parse(dr["Ocupado"].ToString());
                    idClaseEspacio[cont] = dr["ClaseEspacioID"].ToString();
                    cont++;
                }
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal("Error: " + sq.Message, "ERR");
                cn.Close();
            }

            cont = 0;
            for (int i = 0; i < filas; i++)
            {
                tableRow = new TableRow();
                tablaPuestos.Controls.Add(tableRow);
                for (int j = 0; j < columnas; j++)
                {
                    tableCell = new TableCell();
                    tableRow.Controls.Add(tableCell);
                    imgButton = new ImageButton();
                    imgButton.Click += new ImageClickEventHandler(img_Click);
                    if (datosEspacios[cont] == 0)
                        imgButton.ImageUrl = alumnoLibre;
                    else
                    {
                        imgButton.ImageUrl = alumnoOcupado;
                        imgButton.Enabled = false;
                    }
                    imgButton.ID = idClaseEspacio[cont];
                    cont++;
                    tableCell.Controls.Add(imgButton);
                }
            }
            pnDisponibles.Controls.Add(tablaPuestos);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
            
            ScriptManager.RegisterStartupScript(this, GetType(), "VentanaPrueba", "VentanaPrueba();", true);
        }
        public void pintarB(string claseID, string claseplantillaID, string alumnoLibre, string alumnoOcupado, string frente)
        {
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='row'>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<div class='col-md-10'>";
            pnDisponibles.Controls.Add(literal);
            tablaPuestos = new Table();
            int[] datosEspacios;
            string[] idClaseEspacio;
            tablaPuestos.CssClass = "table-responsive puestos";
            tablaPuestos.ID = "tblPuestos";
            int filas = int.Parse(Utilidades.EjeSQL("SELECT ClaseFilas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            int columnas = int.Parse(Utilidades.EjeSQL("SELECT ClaseColumnas FROM Clase WHERE ClaseID = " + claseID, cn, ref Err, true));
            datosEspacios = new int[filas * columnas];
            idClaseEspacio = new string[filas * columnas];
            sSelectSQL = "SELECT * FROM ClaseEspacio WHERE ClasePlantillaID = " + claseplantillaID;
            int cont = 0;
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    datosEspacios[cont] = int.Parse(dr["Ocupado"].ToString());
                    idClaseEspacio[cont] = dr["ClaseEspacioID"].ToString();
                    cont++;
                }
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal("Error: " + sq.Message, "ERR");
                cn.Close();
            }

            cont = 0;
            for (int i = 0; i < filas; i++)
            {
                tableRow = new TableRow();
                tablaPuestos.Controls.Add(tableRow);
                for (int j = 0; j < columnas; j++)
                {
                    tableCell = new TableCell();
                    tableRow.Controls.Add(tableCell);
                    imgButton = new ImageButton();
                    imgButton.Click += new ImageClickEventHandler(img_Click);
                    if (datosEspacios[cont] == 0)
                        imgButton.ImageUrl = alumnoLibre;
                    else
                    {
                        imgButton.ImageUrl = alumnoOcupado;
                        imgButton.Enabled = false;
                    }
                    imgButton.ID = idClaseEspacio[cont];
                    cont++;
                    tableCell.Controls.Add(imgButton);
                }
            }
            pnDisponibles.Controls.Add(tablaPuestos);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);

            //Columna Izquierda Profesor
            literal = new Literal();
            literal.Text = "<div class='col-md-1'>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = frente;
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            pnDisponibles.Controls.Add(literal);
            ScriptManager.RegisterStartupScript(this, GetType(), "VentanaPrueba", "VentanaPrueba();", true);
        }
        protected void img_Click(object sender, ImageClickEventArgs e)
        {          
            //OBTENER EL CLICK
            ImageButton imgButton2 = sender as ImageButton;
            //--------------
            /*sSelectSQL = "UPDATE ClaseEspacio SET Ocupado = 1, UsuarioID="+_autenticado.UsuarioID+" WHERE ClaseEspacioID = " + imgButton2.ID;
            try
            {
                cn.Open();
                SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                addCmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, GetType(), "VentanaPruebaClose", "VentanaPruebaClose();", true);
                cn.Close();
                //INSERTAMOS LA RESERVA
                //MostrarMsjModal("ID: " + imgButton2.ID, "");*/
                agregarReserva(imgButton2.ID);
            /*}
            catch (SqlException sq)
            {
                cn.Close();
                MostrarMsjModal("Error: " + sq.Message, "ERR");
            }*/
        }


        protected void CargarDetalles() 
        {
            sSelectSQL = "SELECT * FROM PlanAlumnoAcumulado WHERE UsuarioID=" + _autenticado.UsuarioID;
            sSelectSQL2 = "Select p.PlanNombre as Nombre, CONVERT(Varchar(11),pa.PlanAlumnoFechaFin,103) as FechaFin, "+
                          " pa.PlanAlumnoFechaFin as PlanAlumnoFechaFin, pa.SaldoNegativo as Deuda " +
                          " FROM [Plan] p, PlanAlumno pa " +
                          " WHERE p.PlanID = pa.PlanID and pa.UsuarioID = " + _autenticado.UsuarioID +" ORDER BY pa.PlanAlumnoID DESC";
            cn.Close();
            cn.Open();
            SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                if (dr.Read())
                {
                    totalClasesRegulares = dr["totalClasesRegulares"].ToString();
                    disponiblesClasesRegulares = dr["disponiblesClasesRegulares"].ToString();
                    totalClasesComplemen = dr["totalClasesComplemen"].ToString();
                    disponiblesClasesComplemen = dr["disponiblesClasesComplemen"].ToString();
                }
                else 
                {
                    MostrarMsjModal("No posee ningún plan asignado.", "ADV");
                }
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
            }
            dr.Close();
            cn.Close();
            cn.Open();
            SqlCommand cmd2 = new SqlCommand(sSelectSQL2, cn);
            SqlDataReader dr2 = cmd2.ExecuteReader();
            try
            {
                if (dr2.Read())
                {
                    NombrePlan = dr2["Nombre"].ToString();
                    FechaFin = dr2["FechaFin"].ToString();
                    FechaFin2 = dr2["PlanAlumnoFechaFin"].ToString();
                    ViewState["FechaFin2"] = FechaFin2;
                    Deuda = dr2["Deuda"].ToString();
                }
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
            }
            dr2.Close();
            cn.Close();
            lblPlan.Text = NombrePlan;
            lblFechaFin.Text = FechaFin;
            if (Deuda != "0")
            {
                lblDeuda.Text = Deuda;
            }
            else
            {
                lblDeuda.Text = "No Posee deuda.";
            }
            lblClasesRegularesDisp.Text =  disponiblesClasesRegulares;
            lblTotalClasesRegulares.Text = totalClasesRegulares;
            lblClasesComplemenDisp.Text = disponiblesClasesComplemen;
            lblTotalClasesComplemen.Text = totalClasesComplemen;
            lblMatriculaAnual.Text = Utilidades.EjeSQL("select convert(varchar(11), MembresiaFechaFin, 103)"+
            " as Fecha from membresia where MembresiaUsuarioID = "+_autenticado.UsuarioID, cn, ref Err, true);
        }
        protected void BindGridViewReservas()
        {
            try
            {
                cn.Close();
                cn.Open();
                string cmd2 = " SELECT  Reserva.ReservaID as ReservaID, " +
                              " Clase.ClaseDescripcion as ClaseDescripcion, " +
                              " Clase.ClaseTipo as ClaseTipo, " +
                              " ClasePlantilla.ClasePlantillaID as ClasePlantillaID, " +
                              " (ClasePlantilla.ClasePlantillaFecha+' '+ClasePlantilla.ClasePlantillaHora) as ClasePlantillaFecha, " +
                              " ClasePlantilla.ClasePlantillaHora as ClasePlantillaHora, " +
                              " Reserva.UsuarioID as UsuarioID, " +
                              " ClasePlantilla.ClaseID as ClaseID, " +
                              " Reserva.FechaReserva as FechaReserva, " +
                              " Reserva.HoraReserva as HoraReserva " +
                              " FROM Clase INNER JOIN "+
                              " ClasePlantilla ON Clase.ClaseID = ClasePlantilla.ClaseID INNER JOIN "+
                              " Reserva ON ClasePlantilla.ClasePlantillaID = Reserva.ClasePlantillaID WHERE Reserva.UsuarioID = "+UsuarioID+
                              " AND CONVERT(DATE, ClasePlantilla.ClasePlantillaFecha, 103) >= CONVERT(DATE, SYSDATETIME(), 103)";

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "ReservaID";
                GridView2.DataKeyNames = TablaID;
                GridView2.DataSource = dt;
                GridView2.DataBind();
                cn.Close();
            }
            catch (SqlException ex)
            {
                MostrarMsjModal(ex.Message, "ERR");
            }
        }
        protected void BindGridView()
        {
            try
            {
                cn.Open();
                string cmd2 = "SELECT ClasePlantilla.ClasePlantillaID as ClasePlantillaID, " +
                                " (ClasePlantilla.ClasePlantillaFecha+' '+ClasePlantilla.ClasePlantillaHora) as ClasePlantillaFecha, " +
                                " ClasePlantilla.ClasePlantillaHora as ClasePlantillaHora, " +
                                " ClasePlantilla.ClasePlantillaCupo as ClasePlantillaCupo, " +
                                " ClasePlantilla.ClaseID as ClaseID, " +
                                " Clase.ClaseTipo as ClaseTipo," +
                                " Clase.ClaseDescripcion as ClaseDescripcion" +
                                " FROM Clase INNER JOIN" +
                                " ClasePlantilla ON Clase.ClaseID = ClasePlantilla.ClaseID" +
                                " WHERE ClasePlantilla.ClasePlantillaCupo >=0  " + ViewState["fechaActual"] +
                                " AND ClasePlantilla.ClienteID = " + ViewState["ClienteID"]+
                                " ";
                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd2, cn);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                dt = ds.Tables[0];
                string[] TablaID = new string[1];
                TablaID[0] = "ClasePlantillaID";
                GridView1.DataKeyNames = TablaID;
                GridView1.DataSource = dt;
                GridView1.DataBind();
                cn.Close();
                if (dt.Rows.Count > 0)
                {
                    /*Attribute to show the Plus Minus Button.
                    GridView1.HeaderRow.Cells[1].Attributes["data-class"] = "expand";

                    //Attribute to hide column in Phone.                
                    GridView1.HeaderRow.Cells[0].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[2].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[3].Attributes["data-hide"] = "phone";

                    //Adds THEAD and TBODY to GridView.
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;*/
                }
            }
            catch (SqlException ex)
            {
                MostrarMsjModal(ex.Message, "ERR");
            }
        }

        protected void calendario_SelectionChanged(object sender, EventArgs e)
        {            
            //MostrarMsjModal("DIA: " + (calendario.SelectedDate.Date) + " FINAL: " + ViewState["FechaFin2"], "ADV");
            fechaFiltro = (calendario.SelectedDate.Date).ToString("dd/MM/yyyy");
            if ((calendario.SelectedDate.Date) <= Convert.ToDateTime(ViewState["FechaFin2"]))
            {
                //Cambiar el filtro
                if ((calendario.SelectedDate.Date) == DateTime.Today.Date)
                {
                    //Validar las Clases que tengan horas mayores a la actual
                    ViewState["fechaActual"] = " AND (ClasePlantillaFecha = CONVERT(VARCHAR, SYSDATETIME(), 103))";
                                               //" AND DATEADD(HOUR, 1, CONVERT(VARCHAR, ClasePlantillaHora, 24)) > CONVERT(VARCHAR, SYSDATETIME(), 24))";                    
                }
                else
                {
                    ViewState["fechaActual"] = " AND (ClasePlantillaFecha = CONVERT(VARCHAR, '"+fechaFiltro+"', 103))";
                }
                BindGridView();
                lblTituloClasesReservas.Text = "Clases Disponibles el " + fechaFiltro;
                
            }
            else {
                MostrarMsjModal("La fecha seleccionada es mayor a la fecha de finalización del Plan.", "ERR");
            }
        }

        protected void calendario_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date < DateTime.Now.Date)
            {
                e.Day.IsSelectable = false;
            }
            
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.EditIndex = -1;
            GridView2.SelectedIndex = -1;
            GridView2.PageIndex = e.NewPageIndex;
            BindGridViewReservas();
        }        

        protected string fechaActual() {
            return (DateTime.Today.Date).ToString("dd/MM/yyyy");
        }

        protected string horaActual() {
            return DateTime.Now.ToString("HH:mm");
        }

        private void MostrarMsjModal(string msj, string tipo)
        {
            string sTitulo = "Información";
            string sCcsClase = "fa fa-check fa-2x text-info";
            switch (tipo)
            {
                case "ERR":
                    sTitulo = "ERROR";
                    sCcsClase = "dangerfa fa-times fa-2x label label-danger";
                    break;
                case "ADV":
                    sTitulo = "ADVERTENCIA"; //
                    sCcsClase = "fa fa-exclamation-triangle fa-2x label label-warning";
                    break;
                case "EXI":
                    sTitulo = "ÉXITO";
                    sCcsClase = "fa fa-check fa-2x label label-success";
                    break;
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarMsjModal", "MostrarMsjModal('" + msj.Replace("'", "").Replace("\r\n", " ") + "','" + sTitulo + "','" + sCcsClase + "');", true);
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView2.Rows[index];
            TimeSpan TamanhoComparacion;
            if (e.CommandName == "cancelar")
            {
                //Consultar la hora de registro de la reserva
                string ReservaID = (gvrow.FindControl("ReservasID") as Label).Text;
                TimeSpan HorasDiferencia = diferenciaHoras(ReservaID);
                string DiaClase = esFinSemana(ReservaID);
                if (DiaClase.ToUpper() == "SATURDAY" || DiaClase.ToUpper() == "SUNDAY") //FIN DE SEMANA
                {
                    // 6 HORAS
                    TamanhoComparacion = TimeSpan.Parse("06:00:00");
                }
                else
                {
                    if (_autenticado.ClienteID == "1")
                    {
                        // 3 HORAS
                        TamanhoComparacion = TimeSpan.Parse("03:00:00");
                    }
                    else {
                        // 2 HORAS
                        TamanhoComparacion = TimeSpan.Parse("02:00:00");
                    }
                }
                if (HorasDiferencia > TamanhoComparacion)
                {
                    //Comenzamos con el procesos inverso desde reservas
                    //Obtener el ClaseID
                    string ClaseID = (gvrow.FindControl("ClaseID") as Label).Text;
                    ClasePlantillaID = (gvrow.FindControl("ClasePlantillaID") as Label).Text;
                    string ClaseTipo = (gvrow.FindControl("ClaseTipo") as Label).Text;
                    string costoUnidad = "";
                    sSelectSQL = "SELECT ClaseUnidad as MAXIMO FROM Clase WHERE ClaseID = " + ClaseID;
                    Utilidades.maxRegistro(ref costoUnidad, sSelectSQL, cn, ref Err);
                    float costoUnidadNum = float.Parse(costoUnidad.Trim());
                    string clasesDisp = "";
                    int bandDescuento = 0;
                    if (ClaseTipo == "Regular")
                    {
                        //Descontar Saldo de Regulares
                        sSelectSQL = "SELECT disponiblesClasesRegulares as MAXIMO FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                        Utilidades.maxRegistro(ref clasesDisp, sSelectSQL, cn, ref Err);
                        bandDescuento = 1;
                    }
                    else
                    {
                        //Descontar Saldo de Complementarias
                        sSelectSQL = "SELECT disponiblesClasesComplemen as MAXIMO FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                        Utilidades.maxRegistro(ref clasesDisp, sSelectSQL, cn, ref Err);
                        bandDescuento = 2;
                        if (int.Parse(clasesDisp) == 0)
                        {
                            sSelectSQL = "SELECT disponiblesClasesRegulares as MAXIMO FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                            Utilidades.maxRegistro(ref clasesDisp, sSelectSQL, cn, ref Err);
                            bandDescuento = 1;
                        }
                    }
                    float clasesDispNum = float.Parse(clasesDisp.Trim());                    
                    if (aumentarCupo(ClasePlantillaID) > 0)
                    {
                        float disponiblesUlt = clasesDispNum + costoUnidadNum;
                        if (actualizarPlanAcumulado(disponiblesUlt, bandDescuento) > 0)
                        {
                            if (actualizarPlanAlumno(costoUnidadNum, "delete") > 0)
                            {
                                //Validar el espacio
                                string ClaseEspacio = "";
                                sSelectSQL = "SELECT ClaseEspacio FROM Reserva WHERE ReservaID = "+ReservaID;
                                ClaseEspacio = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                if (ClaseEspacio != "")
                                {
                                    sSelectSQL = "UPDATE ClaseEspacio SET Ocupado = 0 WHERE ClaseEspacioID =" + ClaseEspacio;
                                }
                                cn.Open();
                                SqlCommand Cmd2 = new SqlCommand(sSelectSQL, cn);
                                try
                                {
                                    int iRes = Cmd2.ExecuteNonQuery();
                                    cn.Close();
                                }
                                catch (SqlException sq)
                                {
                                    MostrarMsjModal(sq.Message, "ERR");
                                    cn.Close();
                                }
                                cn.Open();
                                sSelectSQL = " DELETE FROM Reserva WHERE ReservaID = " + ReservaID;
                                SqlCommand Cmd = new SqlCommand(sSelectSQL, cn);
                                try
                                {
                                    int iRes = Cmd.ExecuteNonQuery();
                                    //MostrarMsjModal("iRes: " + iRes, "");
                                    if (iRes > 0)
                                    {
                                        cn.Close();
                                        EnviarAvisoLista(ClasePlantillaID);
                                        MostrarMsjModal("La Clase Fue Cancelada y el Cupo regresado a disponibles", "EXI");                                        
                                        CargarDetalles();
                                        BindGridViewReservas();
                                    }
                                }
                                catch (SqlException sq)
                                {
                                    MostrarMsjModal(sq.Message, "ERR");
                                    cn.Close();
                                }
                            }
                            else
                            {
                                MostrarMsjModal("Error al Actualizar el Plan Alumno", "ERR");
                            }
                        }
                        else
                        {
                            MostrarMsjModal("Error al Actualizar el Acumulado", "ERR");
                        }
                    }
                    else
                    {
                        MostrarMsjModal("Error al Aumentar el Cupo", "ERR");
                    }
                }
                else
                {
                    MostrarMsjModal("No puede cancelar porque ha superado las horas disponibles para cancelar.", "ERR");
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView1.Rows[index];
            if (e.CommandName == "reservar")
            {

                //Obtener el ClaseID
                ClaseID = (gvrow.FindControl("ClaseID") as Label).Text;
                ClasePlantillaID = (gvrow.FindControl("ClasePlantillaID") as Label).Text;
                ClaseTipo = (gvrow.FindControl("ClaseTipo") as Label).Text;
                if (fechaCorrecta())
                {
                    if (!siExiste(ClasePlantillaID))
                    {
                        //Consultar si la Plantilla tienen espacios...
                        int siEspacios = int.Parse(Utilidades.EjeSQL("SELECT COUNT(*) FROM ClaseEspacio WHERE ClasePlantillaID = " + ClasePlantillaID, cn, ref Err, true));
                        if (siEspacios > 0)
                        {
                            DateTime fecha = calendario.SelectedDate;
                            Response.Redirect("ReservaAlumnoLicsu.aspx?mostrar=si&fecha=" + fecha + "&claseid=" + ClaseID + "&claseplantillaid=" + ClasePlantillaID);                        
                        }
                        else
                        {
                            agregarReserva("");
                        }
                    }
                    else
                    {
                        MostrarMsjModal("No puede reservar  ésta clase porque ya la haz reservado", "ADV");
                    }
                }
                else
                {
                    MostrarMsjModal("No puedes reservar porque el Plazo del Plan Expiró", "ADV");
                }
            }
            
        }
        protected bool fechaCorrecta()
        {
            bool correcto = false;

            DateTime fechaFin = DateTime.Parse(lblFechaFin.Text);
            DateTime fechaHoy = DateTime.Today.Date;
            if (fechaHoy <= fechaFin)
                correcto = true;

            return correcto;
        }
        protected void agregarReserva(string ClaseEspacio)
        {
            
            string costoUnidad = "";
            sSelectSQL = "SELECT ClaseUnidad as MAXIMO FROM Clase WHERE ClaseID = " + ClaseID;
            Utilidades.maxRegistro(ref costoUnidad, sSelectSQL, cn, ref Err);
            costoUnidadNum = float.Parse(costoUnidad.Trim());
            string clasesDisp = "";
            int bandDescuento = 0;
            if (ClaseTipo == "Regular")
            {
                //Descontar Saldo de Regulares
                sSelectSQL = "SELECT disponiblesClasesRegulares as MAXIMO FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                Utilidades.maxRegistro(ref clasesDisp, sSelectSQL, cn, ref Err);
                bandDescuento = 1;
            }
            else 
            {
                //Descontar Saldo de Complementarias
                sSelectSQL = "SELECT disponiblesClasesComplemen as MAXIMO FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                Utilidades.maxRegistro(ref clasesDisp, sSelectSQL, cn, ref Err);
                bandDescuento = 2;
                if (int.Parse(clasesDisp) == 0)
                {
                    sSelectSQL = "SELECT disponiblesClasesRegulares as MAXIMO FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;
                    Utilidades.maxRegistro(ref clasesDisp, sSelectSQL, cn, ref Err);
                    bandDescuento = 1;
                }
            }
            clasesDispNum = float.Parse(clasesDisp.Trim());
            sSelectSQL = "select DATEDIFF(DAY, SYSDATETIME(), PlanAlumnoFechaFin) as DIAS from planalumno where UsuarioID = " + UsuarioID + " order by planalumnoid desc";
            int Dias = int.Parse(Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true));
            if (Dias >= 0)
            {
                if (clasesDispNum >= costoUnidadNum)
                {
                    float disponiblesUlt = clasesDispNum - costoUnidadNum;
                    if (descontarCupo(ClasePlantillaID) > 0)
                    {
                        if (actualizarPlanAcumulado(disponiblesUlt, bandDescuento) > 0)
                        {
                            if (actualizarPlanAlumno(costoUnidadNum, "reservar") > 0)
                            {
                                cn.Open();
                                sSelectSQL = " INSERT INTO Reserva (FechaReserva, HoraReserva, ClasePlantillaID, UsuarioID, ClaseEspacio) VALUES ( " +
                                             " SYSDATETIME(), '" + horaActual() + "', " + ClasePlantillaID + "," + UsuarioID + "," + Utilidades.SiEsNulo(ClaseEspacio, "N") + ")";
                                //MostrarMsjModal(sSelectSQL, "");
                                SqlCommand Cmd = new SqlCommand(sSelectSQL, cn);
                                try
                                {
                                    int iRes = Cmd.ExecuteNonQuery();
                                    if (iRes > 0)
                                    {
                                        cn.Close();
                                        sSelectSQL = "UPDATE ClaseEspacio SET Ocupado = 1, UsuarioID=" + _autenticado.UsuarioID + " WHERE ClaseEspacioID = " + ClaseEspacio;
                                        Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                        MostrarMsjModal("Tu Clase ha sido reservada con Éxito", "EXI");
                                        CargarDetalles();
                                        BindGridViewReservas();
                                        Response.Redirect("ReservaAlumnoLicsu.aspx");
                                    }
                                }
                                catch (SqlException sq)
                                {
                                    MostrarMsjModal(sq.Message, "ERR");
                                    cn.Close();
                                }
                            }
                            else
                            {
                                MostrarMsjModal("Error al Actualizar el Plan del Alumno", "ERR");
                            }
                        }
                        else
                        {
                            MostrarMsjModal("Error al descontar el Total", "ERR");
                        }
                    }
                    else
                    {
                       //Preguntamos si quiere que se le avise.
                        ScriptManager.RegisterStartupScript(this, GetType(), "MostrarLista", "MostrarLista();", true);
                    }
                }
                else
                {
                    MostrarMsjModal("No puedes reservar porque no tienes Clases Disponibles", "ADV");
                }
            }
            else
            {
                MostrarMsjModal("No puedes reservar porque Su Plan ya está Vencido.", "ADV");
            }
        }

        protected bool siExiste(string ClasePlantillaID)
        {
            bool band = false;
            sSelectSQL = "SELECT * FROM Reserva WHERE ClasePlantillaID ="+ClasePlantillaID+" AND UsuarioID ="+_autenticado.UsuarioID;
            string res = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
            if(res != "")
               band = true;
            else
                band = false;
            return band;
        }
        protected int aumentarCupo(string ClasePlantillaID)
        {
            int iRes = 0;
            string cuposClase = "";
            sSelectSQL = "SELECT ClasePlantillaCupo as MAXIMO FROM ClasePlantilla WHERE ClasePlantillaID = " + ClasePlantillaID;
            Utilidades.maxRegistro(ref cuposClase, sSelectSQL, cn, ref Err);
            int Cupos = int.Parse(cuposClase.Trim());
            cn.Open();
            sSelectSQL = "UPDATE ClasePlantilla SET ClasePlantillaCupo = " + (Cupos + 1) + " WHERE ClasePlantillaID = " + ClasePlantillaID;
            SqlCommand Cmd = new SqlCommand(sSelectSQL, cn);
            try
            {
                iRes = Cmd.ExecuteNonQuery();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
            }
            cn.Close();
            return iRes;
        }

        protected int descontarCupo(string ClasePlantillaID) 
        {
            int iRes = 0;
            string cuposClase = "";
            sSelectSQL = "SELECT ClasePlantillaCupo as MAXIMO FROM ClasePlantilla WHERE ClasePlantillaID = " + ClasePlantillaID;
            Utilidades.maxRegistro(ref cuposClase, sSelectSQL, cn, ref Err);
            int Cupos = int.Parse(cuposClase.Trim());
            if (Cupos - 1 >= 0)
            {
                cn.Open();
                sSelectSQL = "UPDATE ClasePlantilla SET ClasePlantillaCupo = " + (Cupos - 1) + " WHERE ClasePlantillaID = " + ClasePlantillaID;
                SqlCommand Cmd = new SqlCommand(sSelectSQL, cn);
                try
                {
                    iRes = Cmd.ExecuteNonQuery();
                }
                catch (SqlException sq)
                {
                    MostrarMsjModal(sq.Message, "ERR");
                }
                cn.Close();
            }
            
            return iRes;
        }

        protected int actualizarPlanAcumulado(float disponibles, int bandDescuento)
        {
            int iRes = 0;
            cn.Open();
            if(bandDescuento == 1)
                sSelectSQL = "UPDATE PlanAlumnoAcumulado SET disponiblesClasesRegulares = '"+disponibles+"' WHERE UsuarioID = "+UsuarioID;
            else
                sSelectSQL = "UPDATE PlanAlumnoAcumulado SET disponiblesClasesComplemen = '" + disponibles + "' WHERE UsuarioID = " + UsuarioID;
            //MostrarMsjModal(bandDescuento+" - "+sSelectSQL, "");
            SqlCommand Cmd = new SqlCommand(sSelectSQL, cn);
            try
            {
                iRes = Cmd.ExecuteNonQuery();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
            }
            cn.Close();
            return iRes;
        }

        protected int actualizarPlanAlumno(float costoClase, string accion)
        {
            int iRes = 0;
            string clasesActivas = "";
            float clasesActivasNum ;
            sSelectSQL = "SELECT ClasesActivas as MAXIMO FROM PlanAlumno WHERE UsuarioID = " + UsuarioID;
            Utilidades.maxRegistro(ref clasesActivas, sSelectSQL, cn, ref Err);
            if(accion == "delete")
                clasesActivasNum = float.Parse(clasesActivas.Trim()) - costoClase;
            else
                clasesActivasNum = float.Parse(clasesActivas.Trim()) + costoClase;
            cn.Open();
            sSelectSQL = "UPDATE PlanAlumno SET ClasesActivas = '" + clasesActivasNum + "' WHERE UsuarioID = " + UsuarioID;
            SqlCommand Cmd = new SqlCommand(sSelectSQL, cn);
            try
            {
                iRes = Cmd.ExecuteNonQuery();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
            }
            cn.Close();
            return iRes;
        }

        protected TimeSpan diferenciaHoras(String ReservaID) 
        {
            TimeSpan diferencia;
            //Validamos si es el mismo dia
            sSelectSQL = "SELECT dbo.ClasePlantilla.ClasePlantillaFecha as MAXIMO " +
                           " FROM dbo.ClasePlantilla INNER JOIN " +
                           " dbo.Reserva ON dbo.ClasePlantilla.ClasePlantillaID = dbo.Reserva.ClasePlantillaID " +
                           " WHERE (dbo.Reserva.ReservaID = " + ReservaID + ")";
            string FechaClase = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
            DateTime FechaClaseDate = Convert.ToDateTime(FechaClase).Date;

            if (FechaClaseDate.Date == DateTime.Now.Date)
            {
                //Validamos la hora
                sSelectSQL = "SELECT dbo.ClasePlantilla.ClasePlantillaHora as MAXIMO " +
                           " FROM dbo.ClasePlantilla INNER JOIN " +
                           " dbo.Reserva ON dbo.ClasePlantilla.ClasePlantillaID = dbo.Reserva.ClasePlantillaID " +
                           " WHERE (dbo.Reserva.ReservaID = " + ReservaID + ")";
                string FechaHora = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                TimeSpan HoraClase = TimeSpan.Parse(FechaHora);
                TimeSpan HoraActual = TimeSpan.Parse(Utilidades.EjeSQL("SELECT CONVERT(VARCHAR, getdate(), 108)", cn, ref Err, true));
                diferencia = HoraClase - TimeSpan.Parse(horaActual());
            }
            else 
            {
                //Retornamos un numero bajo
                diferencia = TimeSpan.Parse("12:00");
            }
            
            return diferencia;
        }

        protected string HoraSistema(){
            string HoraSistema = "";
            sSelectSQL = "SELECT SYSDATETIME() as MAXIMO";
            Utilidades.maxRegistro(ref HoraSistema, sSelectSQL, cn, ref Err);
            return HoraSistema;
        }

        protected string esFinSemana(String ReservaID)
        {
            string fecha = "";
            cn.Open();
            sSelectSQL = "SELECT dbo.ClasePlantilla.ClasePlantillaFecha as ClasePlantillaFecha"
                        + " FROM dbo.ClasePlantilla INNER JOIN "
                        + " dbo.Reserva ON dbo.ClasePlantilla.ClasePlantillaID = dbo.Reserva.ClasePlantillaID "
                        + " WHERE(dbo.Reserva.ReservaID = " + ReservaID + ")";
            //MostrarMsjModal(sSelectSQL, "");
            SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                if (dr.Read())
                {
                    fecha = dr["ClasePlantillaFecha"].ToString();
                }
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
            }
            dr.Close(); 
            cn.Close();
            
            return (Convert.ToDateTime(fecha).DayOfWeek).ToString();
            //return "";
        }

        protected void dplPuestoClase_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dplPuestoClase.SelectedValue != "")
            {
                sSelectSQL = "UPDATE ClaseEspacio SET Ocupado = 1 WHERE ClaseEspacioID = "+dplPuestoClase.SelectedValue;
                try {
                    cn.Open();
                    SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                    addCmd.ExecuteNonQuery();
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("document.getElementById('closeEdit').click();");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
                    cn.Close();
                    //INSERTAMOS LA RESERVA
                    agregarReserva(dplPuestoClase.SelectedValue);
                }
                catch (SqlException sq) 
                {
                    cn.Close();
                    MostrarMsjModal("Error: " + sq.Message, "ERR");
                }
            }
        }

        protected void Aceptar_Click(object sender, EventArgs e)
        {
            //Actualizar en PlanAlumnoAcumulado
            sSelectSQL = "UPDATE PlanAlumnoAcumulado SET totalClasesRegulares = "+dplCantidadClases.SelectedValue+", disponiblesClasesRegulares = '"+dplCantidadClases.SelectedValue+"'"+ 
            ", seleccionoClases = 1 WHERE UsuarioID = "+UsuarioID;
            //MostrarMsjModal(sSelectSQL, "");
            Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
            sSelectSQL = "INSERT INTO PLANEMPRESAHISTORIAL(PLANEMPRESAUSUARIOID, PLANEMPRESAPLANESTADO, " +
                               " PLANEMPRESAFECHA, PLANEMPRESATOTALCLASES) VALUES (" + UsuarioID + ", " +
                               " 1, CONVERT(DATE, SYSDATETIME(),103), " + dplCantidadClases.SelectedValue + ")";
            Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
            DateTime MesProximo = new DateTime(DateTime.Today.Year, DateTime.Today.Month + 1, 1);
            sSelectSQL = "UPDATE PlanEmpresa SET PlanActivo =1, EstadoProximo = 1, MesProximo = CONVERT(DATE, '"+MesProximo.ToString("d")+"',103)"+
                         " FechaUltimo = CONVERT(DATE, SYSDATETIME(), 103) ,TotalClases = "+dplCantidadClases.SelectedValue+" WHERE UsuarioID = "+UsuarioID;
            Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
            Response.Redirect("ReservaAlumnoLicsu.aspx");
        }

        protected void dplListaEspera_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dplListaEspera.SelectedValue != "")
            {
                if (dplListaEspera.SelectedValue == "NO")
                {
                    Response.Redirect("ReservaAlumnoLicsu.aspx");
                }
                else
                { 
                    //Agregamos el usuario en la tabla de Lista de espera.
                    Err = "";
                    sSelectSQL = "INSERT INTO ListaEspera (ListaEsperaUsuarioID, ListaEsperaClaseID, ListaEsperaEstado) "+
                                " VALUES("+UsuarioID+", "+ClasePlantillaID+", 0)";
                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                    if (Err == "")
                    {
                        Response.Redirect("ReservaAlumnoLicsu.aspx?aviso=true");
                    }

                }
            }
        }

        protected void btnAviso_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReservaAlumnoLicsu.aspx");
        }

        protected void EnviarAvisoLista(string clase)
        {
            sSelectSQL = " SELECT TOP 1 ListaEsperaUsuarioID FROM ListaEspera " +
                         " WHERE ListaEsperaClaseID = " + clase +
                         " AND ListaEsperaEstado = 0 ORDER BY ListaEsperaID ASC";
            string UsuarioAviso = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);           
            sSelectSQL = " SELECT UsuarioCorreo FROM Usuario WHERE UsuarioID = " + UsuarioAviso;
            string destino = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
            if (Utilidades.EmailValido(destino))
            {                
                sSelectSQL = " SELECT (UsuarioNombre+' '+UsuarioApellido) as Usuario FROM Usuario WHERE UsuarioID = " + UsuarioAviso;
                string UsuarioDatos = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                sSelectSQL = " SELECT  (dbo.Clase.ClaseDescripcion+' '+dbo.ClasePlantilla.ClasePlantillaFecha+' '+dbo.ClasePlantilla.ClasePlantillaHora) as Clase " +
                             " FROM dbo.Clase INNER JOIN " +
                             " dbo.ClasePlantilla ON dbo.Clase.ClaseID = dbo.ClasePlantilla.ClaseID " +
                             " WHERE dbo.ClasePlantilla.ClasePlantillaID = " + clase;
                string Clase = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                string asunto = "¡Cupo Disponible!";
                string mensaje = " Señor(a) " + UsuarioDatos + "<br>" +
                                 " Se ha habilitado un cupo en la clase " + Clase + ". " +
                                 " Ingrese pronto a inscribirse.";
                Utilidades.EnviarCorreo(destino, asunto, mensaje, ref Err);
                sSelectSQL = " SELECT TOP 1 ListaEsperaID FROM ListaEspera " +
                        " WHERE ListaEsperaClaseID = " + clase +
                        " AND ListaEsperaEstado = 0 ORDER BY ListaEsperaID ASC";
                string ListaEsperaID = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                sSelectSQL = "DELETE FROM ListaEspera WHERE ListaEsperaID = "+ListaEsperaID;
                Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);                
            }
        }

        protected void btnCerrarPuesto_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReservaAlumnoLicsu.aspx");
        }
        
    }
}