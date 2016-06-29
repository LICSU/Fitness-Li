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
using System.Xml;
using System.IO;
using System.Xml.Serialization;

namespace LicsuWeb.Validado
{
    public partial class XmlMedical : System.Web.UI.Page
    {
        FormsIdentity fIdentity = HttpContext.Current.User.Identity as FormsIdentity;
        UsuarioAutenticado _autenticado;
        string Err = "", sSelectSQL ="";
        DataTable dt;
        DataSet ds;
        GridView grid;
        string[] vecCuppos, vecTam1;
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
                string cmd2 = "SELECT DISTINCT(ClasePlantilla.ClasePlantillaID) as ClasePlantillaID," +
                               " Clase.ClaseDescripcion as ClaseDescripcion, " +
                               " ClasePlantilla.ClasePlantillaFecha as ClasePlantillaFecha, " +
                               " ClasePlantilla.ClasePlantillaHora as ClasePlantillaHora, " +
                               " Clase.ClaseIntervalo as ClaseIntervalo," +
                               " Clase.ClaseSensor as ClaseSensor" +
                               " FROM ClasePlantilla INNER JOIN"+
                               " Clase ON ClasePlantilla.ClaseID = Clase.ClaseID INNER JOIN"+
                               " Reserva ON ClasePlantilla.ClasePlantillaID = Reserva.ClasePlantillaID"+
                               " WHERE(NOT (Clase.ClaseSensor IS NULL)) AND (NOT (Clase.ClaseIntervalo IS NULL))"+
                               " ORDER BY ClasePlantilla.ClasePlantillaFecha ASC, ClasePlantilla.ClasePlantillaHora ASC";
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
                /*if (dt.Rows.Count > 0)
                {
                    GridView1.HeaderRow.Cells[3].Attributes["data-class"] = "expand";
                    //Attribute to hide column in Phone. 
                    GridView1.HeaderRow.Cells[0].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[2].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[1].Attributes["data-hide"] = "phone";
                    GridView1.HeaderRow.Cells[3].Attributes["data-hide"] = "phone";
                    //Adds THEAD and TBODY to GridView.
                    GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                }*/
            }
            catch (SqlException ex)
            {
                Err += "Error al cargar el listado. Detalle: " + ex.Message.Replace("'", "") + ". ";
                MostrarMsjModal(Err, "ERR");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
             
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow gvrow = GridView1.Rows[index];
            if (e.CommandName.Equals("descargar"))
            {
                //Armar el XML con la data....
                string ClasePlantillaID = (gvrow.FindControl("ClasePlantillaID") as Label).Text;
                string ClaseN = (gvrow.FindControl("ClaseDescripcion") as Label).Text;
                string Fecha = (gvrow.FindControl("ClasePlantillaFecha") as Label).Text;
                string Hora = (gvrow.FindControl("ClasePlantillaHora") as Label).Text;
                string Intervalo = (gvrow.FindControl("ClaseIntervalo") as Label).Text;
                string Sensor = (gvrow.FindControl("ClaseSensor") as Label).Text;

                sSelectSQL = "Select COUNT(*)" +
                           " from reserva " +
                           " where claseplantillaid = " + ClasePlantillaID + "";
                int CantidadUsuarios = int.Parse(Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true));

                Clase clase = new Clase();
                clase.Nombre = ClaseN;
                clase.Fecha = Fecha;
                clase.Hora = Hora;
                clase.Sensor = Sensor;
                clase.Intervalo = int.Parse(Intervalo);

                List<Usuario> lstUsuario = new List<Usuario>(CantidadUsuarios);

                sSelectSQL = "Select "+
                           " (SELECT UsuarioCedula FROM Usuario WHERE UsuarioID = Reserva.UsuarioID) as Cedula,"+
                           " (SELECT UsuarioNombre+' '+UsuarioApellido FROM Usuario WHERE UsuarioID = Reserva.UsuarioID) as Nombre,"+
                           " (SELECT Turno From ClaseEspacio Where ClasePlantillaID = "+ClasePlantillaID+" AND UsuarioID = Reserva.UsuarioID) as Turno,"+
                           " (SELECT HoraInicial From ClaseEspacio Where ClasePlantillaID = " + ClasePlantillaID + " AND UsuarioID = Reserva.UsuarioID) as HoraInicial," +
                           " (SELECT HoraFinal From ClaseEspacio Where ClasePlantillaID = " + ClasePlantillaID + " AND UsuarioID = Reserva.UsuarioID) as HoraFinal" +
                           " from reserva "+
                           " where claseplantillaid = " + ClasePlantillaID + "";
                try 
                { 
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                    SqlDataReader dr = cmd.ExecuteReader();
                    while(dr.Read())
                    {
                        string cedula = dr["Cedula"].ToString();
                        string nombre = dr["Nombre"].ToString();
                        int turno = int.Parse(dr["Turno"].ToString());
                        string horainicial = dr["HoraInicial"].ToString();
                        string horafinal = dr["HoraFinal"].ToString();
                        lstUsuario.Add(new Usuario() { Cedula = cedula, Nombre = nombre, Turno = turno, HoraInicial = horainicial, HoraFinal = horafinal });    
                    }
                }
                catch (SqlException sq) 
                {
                    MostrarMsjModal(sq.Message, "ERR");
                }

                Medical medical = new Medical();
                medical.Clase = clase;
                medical.Usuario = lstUsuario;

                XmlSerializer serializer = new XmlSerializer(typeof(Medical));
                TextWriter writer = new StreamWriter(Server.MapPath(Path.Combine(@"~/Validado/Documentos", @"medical.xml")));
                serializer.Serialize(writer, medical);
                writer.Close();

                //string nombreArchivo = "reservas_medical_" + Clase + ".xml";
                string savePath1 = Server.MapPath("Documentos/medical.xml");
                //doc.Save(savePath1);
                ViewState["MapPath"] = savePath1;
                ViewState["Nombre"] = "Documentos/medical.xml";
                MostrarDescarga();

                /*Response.ContentType = "APPLICATION/OCTET-STREAM";
                string Header = "Attachment; Filename=Medical.xml";
                Response.AppendHeader("Content-Disposition", Header);
                FileInfo Dfile = new FileInfo(Server.MapPath(Path.Combine(@"~/Validado/Documentos", @"medical.xml")));
                Response.WriteFile(Dfile.FullName);
                Response.End();*/

               /* try
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                    SqlDataReader dr = cmd.ExecuteReader();
                    XmlDocument doc = new XmlDocument();
                    XmlElement raiz = doc.CreateElement("Medical");
                    doc.AppendChild(raiz);
                    XmlElement clase = doc.CreateElement("clase");
                    raiz.AppendChild(clase);
                    XmlElement nombreC = doc.CreateElement("nombre");
                    nombreC.AppendChild(doc.CreateTextNode(Clase));
                    clase.AppendChild(nombreC);
                    XmlElement fechaC = doc.CreateElement("fecha");
                    fechaC.AppendChild(doc.CreateTextNode(Fecha));
                    clase.AppendChild(fechaC);
                    XmlElement horaC = doc.CreateElement("hora");
                    horaC.AppendChild(doc.CreateTextNode(Hora));
                    clase.AppendChild(horaC);
                    XmlElement IntervaloC = doc.CreateElement("intervalo");
                    IntervaloC.AppendChild(doc.CreateTextNode(Intervalo));
                    clase.AppendChild(IntervaloC);
                    XmlElement sensorC = doc.CreateElement("sensor");
                    sensorC.AppendChild(doc.CreateTextNode(Sensor));
                    clase.AppendChild(sensorC);
                    XmlElement usuario;                    
                    while (dr.Read())
                    {
                        usuario = doc.CreateElement("usuario");
                        raiz.AppendChild(usuario);
                        XmlElement cedula = doc.CreateElement("cedula");
                        cedula.AppendChild(doc.CreateTextNode(dr["Cedula"].ToString()));
                        usuario.AppendChild(cedula);
                        XmlElement nombre = doc.CreateElement("nombre");
                        nombre.AppendChild(doc.CreateTextNode(dr["Nombres"].ToString()));
                        usuario.AppendChild(nombre);
                        XmlElement turno = doc.CreateElement("turno");
                        turno.AppendChild(doc.CreateTextNode(dr["Turno"].ToString()));
                        usuario.AppendChild(turno);
                        XmlElement horarinicial = doc.CreateElement("horainicial");
                        horarinicial.AppendChild(doc.CreateTextNode(dr["HoraInicial"].ToString()));
                        usuario.AppendChild(horarinicial);
                        XmlElement horarfinal = doc.CreateElement("horafinal");
                        horarfinal.AppendChild(doc.CreateTextNode(dr["HoraFinal"].ToString()));
                        usuario.AppendChild(horarfinal);
                    }
                    string nombreArchivo = "reservas_medical_"+Clase+".xml";
                    string savePath1 = Server.MapPath("Documentos/"+nombreArchivo);
                    doc.Save(savePath1);
                    ViewState["MapPath"] = savePath1;
                    ViewState["Nombre"] = "Documentos/"+nombreArchivo;
                    MostrarDescarga();
                    //Llamar al Modal
                }
                catch (SqlException sq)
                {
                    Err = sq.Message;
                    MostrarMsjModal("Error: " + sq.Message, "ERR");
                    cn.Close();
                }*/
                
            }
        }

        protected void ImgbtnArchivo_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.SelectedIndex = -1;
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
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

        private void MostrarDescarga()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarDescarga", "MostrarDescarga();", true);
        }
        private void QuitarDescarga()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "QuitarDescarga", "QuitarDescarga();", true);
        }
        protected void Unnamed_Click(object sender, EventArgs e)
        {
            
            System.IO.FileInfo toDownload = new System.IO.FileInfo(ViewState["MapPath"].ToString());
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + toDownload.Name);
            Response.AddHeader("Content-Length", toDownload.Length.ToString());
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(ViewState["Nombre"].ToString());
            Response.End();
            QuitarDescarga();
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("XmlMedical.aspx");
        }
    }
}