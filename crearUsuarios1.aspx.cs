using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using LicsuWeb.Validado.Clases;
using System.Threading;
using System.IO;

namespace LicsuWeb
{
    public partial class crearUsuarios1 : System.Web.UI.Page
    {
        string sMsj = "";
        bool bandAdicionales = false;
        string sErr = "", Err = "";
        bool bHecho = false;
        string sSelectSQL = "";
        static string cliente = "";
        int contTxt = 0, contChk = 0;
        string sFormularioTipo;
        string[] adicionales;
        TextBox TextBox1;
        CheckBox CheckBox1;
        bool bandPrueba = false;
        Panel p;
        TextBox txtBox;
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            
            p = (Panel)FindControl("panel1");
            cliente = Request.QueryString["cliente"];
            //cargarFormulario(cliente);
            sSelectSQL = "SELECT Parametros.idParametro, "
                         + " Parametros.tipoParametro as tipoParametro, "
                         + " Parametros.labelParametro as labelParametro, "
                         + " Parametros.labelIdParametro as labelIdParametro, "
                         + " Parametros.obserParametro obserParametro, "
                         + " Parametros.activoParametro as activoParametro, "
                         + " Parametros.ClienteID, "
                         + " Cliente.ClienteID AS Expr1"
                         + " FROM Cliente INNER JOIN"
                         + " Parametros ON Cliente.ClienteID = Parametros.ClienteID INNER JOIN"
                         + " TipoParametro ON Parametros.tipoParametro = TipoParametro.idTipoParametro"
                         + " WHERE (Cliente.ClienteID = " + cliente + " AND Parametros.activoParametro = 1) ";
            cn.Open();
            SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            string tipoParametro = "";
            try
            {
                while (dr.Read())
                {
                    bandAdicionales = true;
                    tipoParametro = dr["tipoParametro"].ToString();
                    if (tipoParametro == "1")
                    {
                        //Creamos TEXTBOX
                        contTxt++;
                        agregarTextBox(dr["labelIdParametro"].ToString(), dr["labelParametro"].ToString(), contTxt);
                    }
                    else if (tipoParametro == "2")
                    {
                        contChk++;
                        agregarCheckbox(dr["labelParametro"].ToString(), contChk);
                    }
                }
                cn.Close();
            }
            catch (SqlException sq)
            {
                sErr = sq.Message;
                cn.Close();
            }
            cargarFormulario(cliente);

            if (!IsPostBack)
            {
                CargarListados();
            }
        }

        protected void agregarTextBox(string ID, string label, int cont)
        {
            //Mostramos el Formulario
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='form-group'>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<label for='" + ID + "' id='lblTB_" + ID + "' class='col-sm-3 control-label'>" + label + ":</label>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<div class='col-sm-5'>";
            panel1.Controls.Add(literal);
            TextBox1 = new TextBox();
            TextBox1.ID = ID;
            TextBox1.CssClass = "col-sm-4 form-control";
            panel1.Controls.Add(TextBox1);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
        }

        protected void agregarCheckbox(string ID, int cont)
        {
            //Mostramos el Formulario
            Literal literal;
            literal = new Literal();
            literal.Text = "<div class='form-group'>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<label col-sm-3 control-label'>" + ID + ": </label>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "<div class='col-sm-5'>";
            panel1.Controls.Add(literal);
            CheckBox1 = new CheckBox();
            CheckBox1.ID = "chkBox" + cont;
            CheckBox1.CssClass = "col-sm-4 checkbox";
            panel1.Controls.Add(CheckBox1);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
            literal = new Literal();
            literal.Text = "</div>";
            panel1.Controls.Add(literal);
        }
        //
        private void CargarListados()
        {
            string sSelectSQL = "";
            //Plan
            sSelectSQL = "SELECT ClienteID AS VAL, ClienteNombre AS TXT FROM [Cliente] ORDER BY TXT"; // WHERE PlanActivo=1
            Utilidades.CargarListado(ref ddlPlan, sSelectSQL, cn, ref sErr, true);
            //Sucursal
            sSelectSQL = "SELECT SucursalID AS VAL, SucursalNombre AS TXT FROM Sucursal ORDER BY TXT"; // WHERE SucursalActivo=1
            Utilidades.CargarListado(ref ddlSucursal, sSelectSQL, cn, ref sErr);
            //ROL
            if (sErr != "") { MostrarMsjModal(sErr, "ERR"); }
        }
        //
        protected void cargarFormulario(string clienteID)
        {
            sFormularioTipo = Utilidades.EjeSQL("SELECT FormularioTipo FROM Cliente WHERE ClienteID  = " + clienteID, cn, ref sErr, true);
            if (sFormularioTipo == "1")
            {
                //Formulario LICSU
                MostrarPantalla("L");
            }
            else
            {
                //Formulario Empresa
                MostrarPantalla("E");
            }

        }
        protected void ddlPlan_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            
        }
        //
        private void MostrarPantalla(string sMostrar)
        {
            switch (sMostrar)
            {
                //Empresas
                case "E":
                    phTipoEmpleado.Visible = true;
                    phSucursal.Visible = false;
                    phTipoUsuario.Visible = true;
                    phCedula.Visible = true;
                    phNombre.Visible = false;
                    phClave.Visible = true;
                    phCorreo.Visible = false;
                    phCelular.Visible = true;
                    phCamposLicsu.Visible = false;
                    phObservacion.Visible = true;
                    phRegistrar.Visible = true;
                    phPlan.Visible = true;
                    phPlanActivar.Visible = true;
                    break;
                //Academia Licsu
                case "L":
                    phTipoEmpleado.Visible = false;
                    phSucursal.Visible = true;
                    phTipoUsuario.Visible = true;
                    phCedula.Visible = true;
                    phNombre.Visible = true;
                    phClave.Visible = true;
                    phCorreo.Visible = true;
                    phCelular.Visible = true;
                    phCamposLicsu.Visible = true;
                    phObservacion.Visible = true;
                    phRegistrar.Visible = true;
                    phPlan.Visible = true;
                    phPlanActivar.Visible = false;
                    break;
                //Activar Empresa
                case "A":
                    phTipoEmpleado.Visible = false;
                    phSucursal.Visible = false;
                    phTipoUsuario.Visible = false;
                    phCedula.Visible = false;
                    phNombre.Visible = false;
                    phClave.Visible = false;
                    phCorreo.Visible = false;
                    phCelular.Visible = false;
                    phCamposLicsu.Visible = false;
                    phObservacion.Visible = false;
                    phRegistrar.Visible = false;
                    phPlan.Visible = false;
                    phPlanActivar.Visible = true;
                    break;
                default:
                    phTipoEmpleado.Visible = false;
                    phSucursal.Visible = false;
                    phTipoUsuario.Visible = false;
                    phCedula.Visible = false;
                    phNombre.Visible = false;
                    phClave.Visible = false;
                    phCorreo.Visible = false;
                    phCelular.Visible = false;
                    phCamposLicsu.Visible = false;
                    phObservacion.Visible = false;
                    phRegistrar.Visible = false;
                    phPlan.Visible = true;
                    phPlanActivar.Visible = false;
                    break;
            }
        }
        //
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                int sUsuarioPrueba = 0;
                int BonoID = 0;
                if (txtBono.Text != "")
                {
                    //Validar el codigo del bono
                    sSelectSQL = "SELECT BonoID FROM Bonos WHERE BonoNumero = '" + (txtBono.Text) + "' AND BonoEmpresa = " + cliente;
                    BonoID = int.Parse(Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true));
                    if (BonoID > 0)
                    {
                        sUsuarioPrueba = 1;
                    }
                }
                string sCedula = txtCedula.Text.Trim();
                string sPlanID = this.ddlPlan.SelectedValue;  //Cliente
                string sSucursalID = this.ddlSucursal.SelectedValue;
                string max = "", maxUsuarioRol = "";
                int usuarioID = 0, usuarioRolID = 0;
                sSelectSQL = "SELECT MAX(UsuarioID) AS MAXIMO FROM Usuario";
                Utilidades.maxRegistro(ref max, sSelectSQL, cn, ref sErr);
                usuarioID = int.Parse(max.Trim()) + 1;
                ViewState["UsuarioID"] = usuarioID;
                sSelectSQL = "SELECT MAX(UsuarioRolID) AS MAXIMO FROM UsuarioRol";
                Utilidades.maxRegistro(ref maxUsuarioRol, sSelectSQL, cn, ref sErr);
                usuarioRolID = int.Parse(maxUsuarioRol.Trim()) + 1;
                string RolID = txtRol.SelectedValue;
                //if (bandAdicionales)
                //{ 
                // SI HAY ADICIONALES
                /* Buscar los campos adicionales */
                int contAdic = 0;
                string maxSelect = "Select COUNT(*) FROM parametros WHERE (ClienteID = " + cliente + " AND activoParametro = 1 AND tipoParametro = 1)";
                adicionales = new string[int.Parse(Utilidades.EjeSQL(maxSelect, cn, ref sErr, true))];
                sSelectSQL = "SELECT labelIdParametro From parametros Where (ClienteID = " + cliente + " AND activoParametro = 1 AND tipoParametro = 1)";


                try
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        adicionales[contAdic] = dr["labelIdParametro"].ToString();
                        contAdic++;
                    }
                    cn.Close();
                }
                catch (SqlException sq)
                {
                    sErr = sq.Message;
                    cn.Close();
                }
                string parametros = "", valores = "";
                string texto = "";
                for (int i = 0; i < adicionales.Length; i++)
                {
                    txtBox = (TextBox)p.FindControl(adicionales[i]);
                    texto = txtBox.Text;
                    valores = valores + ",'" + texto + "'";
                    parametros = parametros + "," + adicionales[i];
                }
                /** ************************* **/
                if (sFormularioTipo == "1")
                {
                    //Formulario LICSU
                    //if (EsValido())
                    //{
                    string sTipoEmpleado = ddlTipoEmpleado.SelectedItem.Text;
                    string sOtroTipoEmpleado = txtOtroTipoEmpleado.Text;
                    string sNombre = txtNombre.Text;
                    string sApellido = txtApellido.Text;
                    string sClave = txtClaveNueva.Text;
                    string sCelular = txtCelular.Text;
                    string sTelefono = txtTelefono.Text;
                    string sCelular2 = txtCelular2.Text;
                    string sCorreo = txtCorreo.Text;
                    string sFechaNacimiento = txtFecNac1.Value;
                    string sEstadoCivil = ddlEstadoCivil.SelectedValue;
                    string sSexo = ""; if (rdM.Checked) sSexo = "M"; else sSexo = "F";
                    string sEPS = txtEPS.Text;
                    string sObservacion = txtObservacion.Text;
                    string riesgos = txtRiesgos.Text;
                    string pension = txtPension.Text;
                    string activo = Utilidades.EjeSQL("SELECT bonoEstado FROM Bonos WHERE BonoID =" + BonoID, cn, ref Err, true);
                    if (activo == "1")
                    {
                        MostrarMsjModal("El bono ya fue utilizado, ingresa otro por favor.", "ERR");
                    }
                    else
                    {
                        string cedula = Utilidades.EjeSQL("SELECT UsuarioCedula FROM Usuario WHERE UsuarioCedula = '"+sCedula+"'", cn, ref Err, true);
                        if (cedula == "")
                        {
                            sSelectSQL = "INSERT INTO Usuario (UsuarioID,UsuarioCedula,UsuarioClave,UsuarioNombre,UsuarioApellido,"
                                        + "UsuarioCorreo,UsuarioFechaNacimiento,UsuarioEstadoCivil,UsuarioSexo,UsuarioFoto,UsuarioTelefono,"
                                        + "UsuarioCelular1,UsuarioCelular2,UsuarioEPS,UsuarioObservacion,UsuarioActivo,UsuarioFechaRegistro,UsuarioUsuarioRegistro,UsuarioRiesgos,UsuarioPension,UsuarioTipoEmp,UsuarioPrueba " + parametros + ")"
                                        + "VALUES(" + usuarioID + "," + Utilidades.SiEsNulo(sCedula, "T") + ",'" + sClave + "','" + sNombre + "','" + sApellido + "','" + sCorreo + "','" + sFechaNacimiento + "',"
                                        + "'" + sEstadoCivil + "','" + sSexo + "','','" + sTelefono + "','" + sCelular + "','" + sCelular2 + "','" + sEPS + "','" + sObservacion + "',"
                                        + "1,SYSDATETIME(),1,'" + riesgos + "','" + pension + "','', '" + sUsuarioPrueba + "'" + valores + ")";
                            //MostrarMsjModal(sSelectSQL, "");
                            ejecutarInsert(sSelectSQL);
                            sSelectSQL = "INSERT INTO UsuarioRol(UsuarioRolID,UsuarioID,SucursalID,RolID,ClienteID,UsuarioRolFechaRegistro,UsuarioUsuarioRegistro)"
                                        + " VALUES(" + usuarioRolID + "," + usuarioID + "," + ddlSucursal.SelectedValue + "," + txtRol.SelectedValue + "," + cliente + ",SYSDATETIME(),1)";
                            ejecutarInsert(sSelectSQL);
                            bandPrueba = true;
                            sSelectSQL = " INSERT INTO planAutorizacion(AutorizacionActivo, FechaRegistro, UsuarioID, CorreoEnviado) " +
                                                     " VALUES (0, SYSDATETIME(), " + usuarioID + ", 0)";
                            Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                            if (sCorreo != "" && sUsuarioPrueba == 0)
                            {
                                string asunto = "Bienvenido(a) a Fitnes Li";
                                string urlTemplate = "~/Validado/plantillas/bienvenidaLicsu.htm";
                                string destino = sCorreo;
                                string savePath = Server.MapPath("~/Validado/Documentos/");
                                sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Descripcion' ";
                                string NombreHorario = savePath + Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Normas' ";
                                string NombreNormas = savePath + Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                Utilidades.EnviarCorreoRegLicsu(ref Err, asunto, urlTemplate, destino, NombreHorario, NombreNormas);
                            }
                        }
                        else 
                        {
                            MostrarMsjModal("El número de Cédula "+sCedula+" ya está registrado en el sistema.", "ERR");
                        }
                    }
                }
                else
                {
                    //Formulario Empresa 
                    string sTipoEmp = ddlTipoEmpleado.SelectedValue;
                    if (sTipoEmp == "Empleado")
                    {
                        if (EsClienteEmpleado(sCedula, cliente))
                        {
                            string sClave = txtClaveNueva.Text;
                            string sCelular = txtCelular.Text;
                            string sObservacion = txtObservacion.Text;

                            /**Consultar los datos del Empleado **/
                            sSelectSQL = "SELECT EmpleadoNombre,EmpleadoEmail FROM EmpleadoEmp WHERE EmpleadoCedula = '" + sCedula + "'";
                            string sNombre = "", sCorreo = "";
                            try
                            {
                                cn.Open();
                                SqlCommand cmd3 = new SqlCommand(sSelectSQL, cn);
                                SqlDataReader dr3 = cmd3.ExecuteReader();
                                while (dr3.Read())
                                {
                                    sNombre = dr3["EmpleadoNombre"].ToString();
                                    sCorreo = dr3["EmpleadoEmail"].ToString();
                                }
                                cn.Close();
                            }
                            catch (SqlException sq)
                            {
                                MostrarMsjModal("Error: " + sq.Message, "ERR");
                                cn.Close();
                            }
                            string activo = Utilidades.EjeSQL("SELECT bonoEstado FROM Bonos WHERE BonoID =" + BonoID, cn, ref Err, true);
                            if (activo == "1")
                            {
                                MostrarMsjModal("El bono ya fue utilizado, ingresa otro por favor.", "ERR");
                            }
                            else
                            {
                                string cedula = Utilidades.EjeSQL("SELECT UsuarioCedula FROM Usuario WHERE UsuarioCedula = '" + sCedula + "'", cn, ref Err, true);
                                if (cedula == "")
                                {
                                    sSelectSQL = "INSERT INTO Usuario (UsuarioID,UsuarioCedula,UsuarioClave,UsuarioNombre,UsuarioApellido,"
                                            + "UsuarioCorreo,UsuarioFechaNacimiento,UsuarioEstadoCivil,UsuarioSexo,UsuarioFoto,UsuarioTelefono,"
                                            + "UsuarioCelular1,UsuarioCelular2,UsuarioEPS,UsuarioObservacion,UsuarioActivo,UsuarioFechaRegistro,UsuarioUsuarioRegistro,UsuarioRiesgos,UsuarioPension,UsuarioTipoEmp,UsuarioPrueba " + parametros + ")"
                                            + "VALUES(" + usuarioID + "," + Utilidades.SiEsNulo(sCedula, "T") + ",'" + sClave + "','" + sNombre + "','','" + sCorreo + "','',"
                                            + "'','','','','" + sCelular + "','','','" + sObservacion + "',"
                                            + "1,SYSDATETIME(),1,'','', '" + sTipoEmp + "', '" + sUsuarioPrueba + "'" + valores + ")";
                                    ejecutarInsert(sSelectSQL);
                                    sSelectSQL = "INSERT INTO UsuarioRol(UsuarioRolID,UsuarioID,SucursalID,RolID,ClienteID,UsuarioRolFechaRegistro,UsuarioUsuarioRegistro)"
                                            + " VALUES(" + usuarioRolID + "," + usuarioID + "," + ddlSucursal.SelectedValue + "," + txtRol.SelectedValue + "," + cliente + ",SYSDATETIME(),1)";
                                    ejecutarInsert(sSelectSQL);
                                    //Guardar en PlanEmpresa
                                    bandPrueba = true;
                                    int TotalClases = 0;

                                    if (cliente == "2") TotalClases = 12; else TotalClases = 8;

                                    sSelectSQL = "INSERT INTO PlanEmpresaHistorial (PlanEmpresaUsuarioID, PlanEmpresaPlanEstado, PlanEmpresaFecha, PlanEmpresaTotalClases)" +
                                                     " values(" + usuarioID + ", 0,  CONVERT(DATE, SYSDATETIME(), 103), " + TotalClases + "))";
                                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                    DateTime MesProximo = new DateTime(DateTime.Today.Year, DateTime.Today.Month + 1, 1);
                                    sSelectSQL = "INSERT INTO PLANEMPRESA(UsuarioID, PlanActivo, fechaUltimo, TotalClases, MesProximo, EstadoProximo) VALUES"
                                               + " (" + usuarioID + ",0, CONVERT(DATE, SYSDATETIME(), 109), " + TotalClases + ", CONVERT(DATE, '"+MesProximo.ToString("d")+"',103), 0)";                                                                        
                                    try
                                    {
                                        cn.Open();
                                        SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                                        int iRes = addCmd.ExecuteNonQuery();
                                        cn.Close();
                                    }
                                    catch (SqlException sq)
                                    {
                                        MostrarMsjModal(sq.Message, "ERR");
                                        cn.Close();
                                    }

                                    if (dplActivarPlan.SelectedValue == "Si")
                                    {
                                        sSelectSQL = "UPDATE PlanEmpresa SET PlanActivo = 1, EstadoProximo = 1 WHERE UsuarioID = " + usuarioID;
                                        Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                        sSelectSQL = "UPDATE PlanEmpresaHistorial SET PlanEmpresaPlanEstado = 1  WHERE UsuarioID = " + usuarioID;
                                        Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                        asignarPlan();
                                        sSelectSQL = "INSERT INTO PlanAutorizacion (AutorizacionActivo, FechaRegistro, UsuarioID, CorreoEnviado)" +
                        " VALUES(0, SYSDATETIME(), " + usuarioID + ", 0)";
                                        Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                    }
                                    else
                                    {
                                        //Insertamos el Autorizacion
                                        sSelectSQL = " INSERT INTO planAutorizacion(AutorizacionActivo, FechaRegistro, UsuarioID, CorreoEnviado) " +
                                                     " VALUES (0, SYSDATETIME(), " + usuarioID + ", 0)";
                                        Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                        string mensaje = "";
                                        string urlTemplate = string.Empty;
                                        if (cliente == "2")
                                        {
                                            urlTemplate = "~/Validado/plantillas/bienvenidaProteccion.html";
                                        }
                                        else if (cliente == "3")
                                        {
                                            urlTemplate = "~/Validado/plantillas/bienvenidaSura.html";
                                        }

                                        if (Utilidades.EmailValido(sCorreo) && sUsuarioPrueba == 0)
                                        {
                                            string usuarioNombre = sNombre;
                                            string asunto = "Bienvenido(a) a Fitnes Li";
                                            string destino = sCorreo;
                                            string savePath = Server.MapPath("~/Validado/Documentos/");
                                            //sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Horario' ";
                                            string NombreHorario = "";
                                            sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Tutorial' ";
                                            string NombreNormas = savePath + Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                            sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Autorizacion' ";
                                            string NombreAutorizacion = savePath + Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                            if (cliente == "2")//Proteccion
                                                Utilidades.EnviarCorreoRegLicsu(ref Err, asunto, urlTemplate, destino, "", NombreNormas);
                                            else if (cliente == "3")
                                                Utilidades.EnviarCorreoRegLicsu(ref Err, asunto, urlTemplate, destino, "", NombreNormas, NombreAutorizacion);
                                        }
                                        //Response.Redirect("consultarUsuarios.aspx?registro=exito");
                                        //MostrarMsjModal("Se han registrado los datos exitosamente, para ingresar utilice su Cédula", "EXI");
                                    }
                                }
                                else
                                {
                                    MostrarMsjModal("El número de Cédula " + sCedula + " ya está registrado en el sistema.", "ERR");
                                }
                            }
                        }
                        else
                        {
                            MostrarMsjModal("La Cédula: " + sCedula + " no se encuentra en la base de datos. Contacte con su Empresa", "ADV");
                        }
                    }
                    else 
                    {
                        //CONTRATADO
                        string sClave = txtClaveNueva.Text;
                        string sCelular = txtCelular.Text;
                        string sObservacion = txtObservacion.Text;

                        string sNombre = txtNombre.Text, sApellido = txtApellido.Text, sCorreo = txtCorreo.Text;

                        string activo = Utilidades.EjeSQL("SELECT bonoEstado FROM Bonos WHERE BonoID =" + BonoID, cn, ref Err, true);
                        if (activo == "1")
                        {
                            MostrarMsjModal("El bono ya fue utilizado, ingresa otro por favor.", "ERR");
                        }
                        else
                        {
                            string cedula = Utilidades.EjeSQL("SELECT UsuarioCedula FROM Usuario WHERE UsuarioCedula = '" + sCedula + "'", cn, ref Err, true);
                            if (cedula == "")
                            {
                                sSelectSQL = "INSERT INTO Usuario (UsuarioID,UsuarioCedula,UsuarioClave,UsuarioNombre,UsuarioApellido,"
                                        + "UsuarioCorreo,UsuarioFechaNacimiento,UsuarioEstadoCivil,UsuarioSexo,UsuarioFoto,UsuarioTelefono,"
                                        + "UsuarioCelular1,UsuarioCelular2,UsuarioEPS,UsuarioObservacion,UsuarioActivo,UsuarioFechaRegistro,UsuarioUsuarioRegistro,UsuarioRiesgos,UsuarioPension,UsuarioTipoEmp,UsuarioPrueba " + parametros + ")"
                                        + "VALUES(" + usuarioID + "," + Utilidades.SiEsNulo(sCedula, "T") + ",'" + sClave + "','" + sNombre + "','"+sApellido+"','" + sCorreo + "','',"
                                        + "'','','','','" + sCelular + "','','','" + sObservacion + "',"
                                        + "1,SYSDATETIME(),1,'','', '" + sTipoEmp + "', '" + sUsuarioPrueba + "'" + valores + ")";


                                ejecutarInsert(sSelectSQL);
                                sSelectSQL = "INSERT INTO UsuarioRol(UsuarioRolID,UsuarioID,SucursalID,RolID,ClienteID,UsuarioRolFechaRegistro,UsuarioUsuarioRegistro)"
                                        + " VALUES(" + usuarioRolID + "," + usuarioID + "," + ddlSucursal.SelectedValue + "," + txtRol.SelectedValue + "," + cliente + ",SYSDATETIME(),1)";
                                ejecutarInsert(sSelectSQL);
                                //Guardar en PlanEmpresa
                                bandPrueba = true;
                                int TotalClases = 0;

                                if (cliente == "2") TotalClases = 12; else TotalClases = 8;
                                sSelectSQL = "INSERT INTO PlanEmpresaHistorial (PlanEmpresaUsuarioID, PlanEmpresaPlanEstado, PlanEmpresaFecha, PlanEmpresaTotalClases)" +
                                                    " values(" + usuarioID + ", 0,  CONVERT(DATE, SYSDATETIME(), 109), " + TotalClases + "))";
                                Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                DateTime MesProximo = new DateTime(DateTime.Today.Year, DateTime.Today.Month + 1, 1);
                                sSelectSQL = "INSERT INTO PLANEMPRESA(UsuarioID, PlanActivo, fechaUltimo, TotalClases, MesProximo, EstadoProximo) VALUES"
                                            + " (" + usuarioID + ",0, CONVERT(DATE, SYSDATETIME(), 109), " + TotalClases + ",CONVERT(DATE,'"+MesProximo.ToString("d")+"',103),1)";
                                sSelectSQL = " INSERT INTO planAutorizacion(AutorizacionActivo, FechaRegistro, UsuarioID, CorreoEnviado) " +
                                                     " VALUES (0, SYSDATETIME(), " + usuarioID + ", 0)";
                                        Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                //if (ddlTipoEmpleado.SelectedValue == "Contratado")
                                //{
                                    string destino = "academia@licsu.com";
                                    string asunto = "Registro de Usuario Contratado/Temporal";
                                    string mensaje = "El usuario " + sNombre + ", Cedula:  "+sCedula+" se ha registrado con éxito.\n Su tipo de empleado es: " + ddlTipoEmpleado.SelectedValue + ".\n" +
                                        " Sus datos de contacto son: " + sCorreo + ", " + sCelular;
                                    Utilidades.EnviarCorreo(destino, asunto, mensaje, ref sErr);
                                //}

                                try
                                {
                                    cn.Open();
                                    SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                                    int iRes = addCmd.ExecuteNonQuery();
                                    cn.Close();
                                }
                                catch (SqlException sq)
                                {
                                    MostrarMsjModal(sq.Message, "ERR");
                                    cn.Close();
                                }

                                if (dplActivarPlan.SelectedValue == "Si")
                                {
                                    sSelectSQL = "UPDATE PlanEmpresa SET PlanActivo = 1, EstadoProximo = 1 WHERE UsuarioID = " + usuarioID;
                                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                    sSelectSQL = "UPDATE PlanEmpresaHistorial SET PlanEmpresaPlanEstado = 1  WHERE UsuarioID = " + usuarioID;
                                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                    asignarPlan();
                                    sSelectSQL = " INSERT INTO planAutorizacion(AutorizacionActivo, FechaRegistro, UsuarioID, CorreoEnviado) " +
                                                     " VALUES (0, SYSDATETIME(), " + usuarioID + ", 0)";
                                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                }
                                else
                                {
                                    //Insertamos el Autorizacion
                                    sSelectSQL = " INSERT INTO planAutorizacion(AutorizacionActivo, FechaRegistro, UsuarioID, CorreoEnviado) " +
                                                    " VALUES (0, SYSDATETIME(), " + usuarioID + ", 0)";
                                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                                    string mensaje1 = "";
                                    string urlTemplate1 = string.Empty;
                                    if (cliente == "2")
                                    {
                                        urlTemplate1 = "~/Validado/plantillas/bienvenidaProteccion.html";
                                    }
                                    else if (cliente == "3")
                                    {
                                        urlTemplate1 = "~/Validado/plantillas/bienvenidaSura.html";
                                    }

                                    if (Utilidades.EmailValido(sCorreo) && sUsuarioPrueba == 0)
                                    {
                                        string usuarioNombre = sNombre;
                                        string asunto1 = "Bienvenido(a) a Fitnes Li";

                                        string destino1 = sCorreo;
                                        string savePath = Server.MapPath("~/Validado/Documentos/");
                                        //sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Horario' ";
                                        string NombreHorario = "";
                                        sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Tutorial' ";
                                        string NombreNormas = savePath + Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                        sSelectSQL = "SELECT ArchivoNombre from Archivos WHERE TipoDocumento='Autorizacion' ";
                                        string NombreAutorizacion = savePath + Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
                                        if (cliente == "2")//Proteccion
                                            Utilidades.EnviarCorreoRegLicsu(ref Err, asunto1, urlTemplate1, destino1, "", NombreNormas);
                                        else if (cliente == "3")
                                            Utilidades.EnviarCorreoRegLicsu(ref Err, asunto1, urlTemplate1, destino1, "", NombreNormas, NombreAutorizacion);
                                    }
                                    //Response.Redirect("consultarUsuarios.aspx?registro=exito");
                                    //MostrarMsjModal("Se han registrado los datos exitosamente, para ingresar utilice su Cédula", "EXI");
                                }
                            }
                            else
                            {
                                MostrarMsjModal("El número de Cédula " + sCedula + " ya está registrado en el sistema.", "ERR");
                            }
                        }                        
                    }
                    
                }
                if (sUsuarioPrueba > 0 && bandPrueba == true)
                {
                    //UPDATE en BONO
                    sSelectSQL = "UPDATE Bonos SET BonoEstado = 1, BonoUsuarioID = " + usuarioID + " WHERE BonoID = " + BonoID;
                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                    string FechaInicio = Utilidades.EjeSQL("SELECT FechaInicio FROM Bonos WHERE BonoID=" + BonoID, cn, ref Err, true);
                    string FechaFin = Utilidades.EjeSQL("SELECT FechaFin FROM Bonos WHERE BonoID=" + BonoID, cn, ref Err, true);
                    FechaInicio = Utilidades.FecUni(FechaInicio);
                    FechaFin = Utilidades.FecUni(FechaFin);
                    //AgregarPlan
                    int PlanAlumnoID = int.Parse(Utilidades.EjeSQL("SELECT MAX(PlanAlumnoID) FROM PlanAlumno", cn, ref Err, true)) + 1;
                    sSelectSQL = "INSERT INTO PlanAlumno(PlanAlumnoID, UsuarioID, SucursalID, PlanID, PlanAlumnoFechaInicio, PlanAlumnoFechaFin," +
                                 " PlanAlumnoFechaRegistro, PlanAlumnoUsuarioRegistro, ClienteID, SaldoPositivo, SaldoNegativo, NumeroFactura," +
                                 " ClasesActivas, FacturaNota) VALUES (" + PlanAlumnoID + "," + usuarioID + ", " + ddlSucursal.SelectedValue + "," +
                                 " 8, CONVERT(DATETIME,'" + FechaInicio + "',103), CONVERT(DATETIME,'" + FechaFin + "',103), SYSDATETIME()," +
                                 " 1, " + cliente + ", 0, 0, 'PRUEBA', 0, " + Utilidades.SiEsNulo("", "T") + ")";
                    //MostrarMsjModal(sSelectSQL, "");
                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                    sSelectSQL = "INSERT INTO PlanAlumnoAcumulado (totalClasesRegulares, disponiblesClasesRegulares, UsuarioID, seleccionoClases, totalClasesComplemen, disponiblesClasesComplemen)" +
                                "VALUES (1,1," + usuarioID + ",1,0,0)";
                    Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                    MostrarMsjModal("Se han registrado los datos exitosamente, Para ingresar da <a href='Validado/Ingreso.aspx'>Clic Aquí<a>", "EXI");
                    //Thread.Sleep(5000);
                    //Response.Redirect("Validado/Ingreso.aspx");
                }
                else
                {
                    MostrarMsjModal("Se han registrado los datos exitosamente, Para ingresar da <a href='Validado/Ingreso.aspx'>Clic Aquí<a>", "EXI");
                    //Thread.Sleep(5000);
                    //Response.Redirect("Validado/Ingreso.aspx");
                }

                //}                
            }
            catch (Exception ex)
            {
                MostrarMsjModal(string.Format("Error tratanto de registrar los datos. Detalle: " + ex), "ERR");
            }
        }
        //
        //
        private int ejecutarInsert(string Query)
        {
            cn.Open();
            int iRes = 0;
            try
            {
                SqlCommand addCmd = new SqlCommand(Query, cn);
                iRes = addCmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal("ERROR: " + sq.Message, "ERR");
                cn.Close();
            }

            return iRes;
        }
        //
        private bool NoExiste(string sCedula)
        {
            bool bRes = false;
            cn.Open();
            try
            {
                if (sCedula != "")
                {
                    object oRes = null;
                    string sSQL = "SELECT UsuarioNombre+' '+UsuarioApellido FROM Usuario WHERE UsuarioCedula='" + sCedula + "'";
                    SqlCommand addCmd = new SqlCommand(sSQL, cn);
                    oRes = addCmd.ExecuteScalar();
                    if (oRes == null) { bRes = true; }
                    else { sMsj = "La cédula " + sCedula + " ya está registrada para: " + oRes; }
                }
            }
            catch (SqlException Sqlex)
            {
                sErr += "Error SQL al buscar la cédula. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                sErr += "Error al buscar la cédula. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                cn.Close();
            }
            return bRes;
        }
        //
        private bool EsValido()
        {
            bool bRes = true;
            string sTipoEmpleado = ddlTipoEmpleado.SelectedValue;
            string sOtroTipoEmpleado = txtOtroTipoEmpleado.Text.Trim();
            if (sTipoEmpleado == "Otro" && sOtroTipoEmpleado == "") { sMsj += "El campo Especifique Otro es requerido. "; bRes = false; }
            string sCedula = txtCedula.Text.Trim();
            if (sCedula == "") { sMsj += "No puede dejar el campo Cédula vacío. "; bRes = false; }
            string sClaveNueva = txtClaveNueva.Text.Trim();
            if (sClaveNueva == "") { sMsj += "No puede dejar el campo Contraseña vacío. "; bRes = false; }
            string sClaveRepetir = txtClaveRepetir.Text.Trim();
            if (sClaveRepetir == "") { sMsj += "No puede dejar el campo Confirmar Contraseña vacío. "; bRes = false; }
            string sPlan = ddlPlan.SelectedValue;
            if (sPlan == "1")
            {
                string sNombre = txtNombre.Text.Trim();
                if (sNombre == "") { sMsj += "No puede dejar el campo Nombre vacío. "; bRes = false; }
                string sApellido = txtApellido.Text.Trim();
                if (sApellido == "") { sMsj += "No puede dejar el campo Apellido vacío. "; bRes = false; }
                string sCorreo = txtCorreo.Text.Trim();
                if (sCorreo != "" && !EsCorreo(sCorreo)) { sMsj += "El Correo no tiene un formato válido. "; bRes = false; }
                string sFechaNac = txtFecNac1.Value.Trim();
                if (sFechaNac != "" && !EsFecha(sFechaNac)) { sMsj += "La Fecha de Nacimiento no tiene un formato válido. "; bRes = false; }
            }
            //string s = txt.Text.Trim();
            //if (s == "") { sMsj += "No puede dejar el campo  vacío. "; bRes = false; }
            return bRes;
        }
        //
        private bool EsClienteEmpleado(string sCedula, string sClienteID)
        {
            bool bRes = false;
            cn.Open();
            try
            {
                if (sCedula != "" && sClienteID != "")
                {
                    object oRes = null;
                    if (sClienteID != "")
                    {
                        string sSQL = "SELECT CE.EmpleadoCedula FROM EmpleadoEmp CE WHERE CE.EmpleadoCedula='" + sCedula + "' AND CE.ClienteID=" + sClienteID;
                        //MostrarMsjModal(sSQL, "");
                        SqlCommand addCmd = new SqlCommand(sSQL, cn);
                        oRes = addCmd.ExecuteScalar();
                        if (oRes != null) { sMsj = oRes.ToString() + " se han confirmado tus datos"; bRes = true; }
                    }
                }
            }
            catch (SqlException Sqlex)
            {
                sErr += "Error al buscar la cédula. Detalle: " + Sqlex.Message + ". ";
            }
            catch (Exception ex)
            {
                sErr += "Error al buscar la cédula. Detalle: " + ex.Message + ". ";
            }
            finally
            {
                cn.Close();
            }
            return bRes;
        }
        //
        private void executeAdd(string sAccion, string sPlanID, string sClienteID, string sSucursalID, string sCedula,
            string sClave, string sNombre, string sApellido, string sCorreo, string sFechaNacimiento, string sEstadoCivil,
            string sSexo, string sTelefono, string sCelular1, string sCelular2, string sEPS, string sObservacion,
            string sUsuarioRegistro, string RolID, int usuarioID, int usuarioRolID)
        {
            cn.Close();
            cn.Open();
            try
            {
                //sFechaNacimiento = Utilidades.FecUni(sFechaNacimiento);
                string sSQL = "EXEC [dbo].[pRegistro] " + sAccion + "," + sPlanID + "," + sClienteID + "," + sSucursalID + ",'" + sCedula + "'," + Utilidades.SiEsNulo(sClave, "T") + "," + Utilidades.SiEsNulo(sNombre, "T") + "," + Utilidades.SiEsNulo(sApellido, "T") + "," + Utilidades.SiEsNulo(sCorreo, "T") + "," + Utilidades.SiEsNulo(sFechaNacimiento, "F") + "," + Utilidades.SiEsNulo(sEstadoCivil, "T") + "," + Utilidades.SiEsNulo(sSexo, "T") + "," + Utilidades.SiEsNulo(sTelefono, "T") + "," + Utilidades.SiEsNulo(sCelular1, "T") + "," + Utilidades.SiEsNulo(sCelular2, "T") + "," + Utilidades.SiEsNulo(sEPS, "T") + "," + Utilidades.SiEsNulo(sObservacion, "T") + "," + Utilidades.SiEsNulo(sUsuarioRegistro, "T") + "," + RolID + "," + usuarioID + "," + usuarioRolID;
                SqlCommand addCmd = new SqlCommand(sSQL, cn);
                try
                {
                    int iRes = addCmd.ExecuteNonQuery();
                    if (iRes < 0)
                    {
                        MostrarMsjModal("Registro agregado con Éxito", "EXI");
                        limpiarCampos();
                    }
                    else { MostrarMsjModal("Falló al Agregar el Registro", "ERR"); }
                }
                catch (SqlException ex) { MostrarMsjModal(ex.Message, "ERR"); }

            }
            catch (SqlException Sqlex)
            {
                MostrarMsjModal(Sqlex.Message, "ERR");
            }
            catch (Exception ex)
            {
                MostrarMsjModal(ex.Message, "ERR");
            }
            finally
            {
                cn.Close();
            }
        }
        /* ********************************************************************* */
        protected void asignarPlan()
        {
            string UsuarioID = ViewState["UsuarioID"].ToString();
            string ClienteID = cliente;
            int cant = 0, iRes = 0;
            int ultimo = DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month);
            string ClienteNombre = Utilidades.EjeSQL("SELECT ClienteNombre FROM Cliente WHERE ClienteID =" + ClienteID, cn, ref Err, true);
            //MostrarMsjModal("", "");
            string PlanID ="";
            if (ClienteID == "2") PlanID = "7";
            else PlanID = "6";

            DateTime fechatemp;
            DateTime fechaInicio;
            DateTime fechaFinal;
            fechatemp = DateTime.Today;
            fechaInicio = new DateTime(fechatemp.Year, fechatemp.Month, 1);
            fechaFinal = new DateTime(fechatemp.Year, fechatemp.Month + 1, 1).AddDays(-1);
            string FechaInicio = fechaInicio.ToString();
            string FechaFin = fechaFinal.ToString();
            FechaInicio = Utilidades.FecUni(FechaInicio);
            FechaFin = Utilidades.FecUni(FechaFin);
            FechaInicio = fechaInicio.ToString("yyyy-MM-dd");
            FechaFin = fechaFinal.ToString("yyyy-MM-dd");
            int PlanAlumnoID = 0;
            string maxPlanAlumno = "";

            sSelectSQL = "SELECT MAX(PlanAlumnoID) as MAXIMO FROM PlanAlumno";
            Utilidades.maxRegistro(ref maxPlanAlumno, sSelectSQL, cn, ref Err);
            string CantidadClases = "0", cc2 = "", cc3 ="";
            sSelectSQL = "Select clasesRegulares as MAXIMO from [Plan] Where PlanID = " + PlanID;
            Utilidades.maxRegistro(ref cc2, sSelectSQL, cn, ref Err);
            sSelectSQL = "Select clasesComplemen  from [Plan] Where PlanID = " + PlanID;
            cc3 = Utilidades.EjeSQL(sSelectSQL, cn, ref Err, true);
            cn.Close();
            string saldoNegativo = "";
            sSelectSQL = "SELECT PlanCosto as MAXIMO FROM [Plan] Where PlanID = " + PlanID;
            Utilidades.maxRegistro(ref saldoNegativo, sSelectSQL, cn, ref Err);
            double saldoN = double.Parse(saldoNegativo);
            if (maxPlanAlumno == "") { PlanAlumnoID = 1; }
            else
            {
                PlanAlumnoID = int.Parse(maxPlanAlumno.Trim()) + 1;
            }
            string SucursalID = "1";
            int iRes3 = 0; bool band = false;
            //eliminarAcumulado(UsuarioID);
            //eliminarPlanAlumno(UsuarioID);

            iRes = insertarAlumno(PlanAlumnoID, UsuarioID, SucursalID, PlanID, FechaInicio, FechaFin, ClienteID, saldoN, cant, CantidadClases);
            if (iRes > 0)
            {
                //Insertar en PlanAlumnoAcumulado
                iRes3 = insertarPlanAcumulado(cc2, UsuarioID, cc3);
                if (iRes3 > 0)
                {
                    band = true;
                }
                else
                {
                    MostrarMsjModal("No se pudo realizar la asignación: " + Err, "ERR");
                }
            }
            else
            {
                MostrarMsjModal("Error al Insertar el PlanAlumno: " + Err, "ERR");
            }
            //if (band)
            // Response.Redirect("Inicio.aspx");
        }
        protected int insertarPlanAcumulado(string cc2, string UsuarioID, string cc3)
        {

            int res = 0;
            string selecciono = "0";
            if(cliente == "1")
                selecciono = "1";

            sSelectSQL = "INSERT INTO PlanAlumnoAcumulado (totalClasesRegulares, disponiblesClasesRegulares, UsuarioID, seleccionoClases, totalClasesComplemen, disponiblesClasesComplemen)" +
                         " VALUES (" + Utilidades.SiEsNulo(cc2, "N") + ", " + Utilidades.SiEsNulo(cc2, "T") + ", " + Utilidades.SiEsNulo(UsuarioID, "N") + "," + selecciono + "," + Utilidades.SiEsNulo(cc3, "N") + ", " + Utilidades.SiEsNulo(cc3, "T") + ")";
            try
            {
                cn.Open();
                SqlCommand addCmd2 = new SqlCommand(sSelectSQL, cn);
                res = addCmd2.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal(sq.Message, "ERR");
                cn.Close();
            }
            

            return res;
        }
        protected int insertarAlumno(int PlanAlumnoID, string UsuarioID, string SucursalID, string PlanID, string FechaInicio,
            string FechaFin, string ClienteID, double saldoN, int cant, string CantidadClases)
        {
            cn.Close();
            int iRes = 0;
            cn.Open();
            string sSelectSQL2 = "INSERT INTO PlanAlumno" +
                                "(PlanAlumnoID, UsuarioID, SucursalID, PlanID, PlanAlumnoFechaInicio, PlanAlumnoFechaFin " +
                                ",PlanAlumnoFechaRegistro" +
                                ",PlanAlumnoUsuarioRegistro,ClienteID, SaldoPositivo, SaldoNegativo, NumeroFactura, ClasesActivas, FacturaNota)" +
                                "VALUES(" + PlanAlumnoID + "," + Utilidades.SiEsNulo(UsuarioID, "N") + ", " + Utilidades.SiEsNulo(SucursalID, "N") + ", " + Utilidades.SiEsNulo(PlanID, "N") + ",CONVERT(VARCHAR(24),'" + FechaInicio + "',103)" +
                                ",CONVERT(VARCHAR(24),'" + FechaFin + "',103),SYSDATETIME(), 1, " + Utilidades.SiEsNulo(ClienteID, "N") +
                                "," + saldoN + ", 0, " + Utilidades.SiEsNulo(ClienteID + "_" + cant, "T") +
                                ", " + Utilidades.SiEsNulo(CantidadClases, "T") + "," + Utilidades.SiEsNulo("", "T") + ")";
            //MostrarMsjModal(sSelectSQL2, "");
            SqlCommand addCmd = new SqlCommand(sSelectSQL2, cn);
            try { iRes = addCmd.ExecuteNonQuery(); cn.Close(); }
            catch (SqlException sq) { Err = sq.Message; cn.Close(); }
            return iRes;
        }
        protected int eliminarPlanAlumno(string UsuarioID)
        {
            int res = 0;

            sSelectSQL = "DELETE FROM PlanAlumno WHERE UsuarioID = " + UsuarioID;

            try
            {
                cn.Open();
                SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                res = addCmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException sq)
            {
                cn.Close();
                MostrarMsjModal("Error: " + sq.Message, "ERR");
            }


            return res;
        }
        protected int eliminarAcumulado(string UsuarioID)
        {
            int res = 0;

            sSelectSQL = "DELETE FROM PlanAlumnoAcumulado WHERE UsuarioID = " + UsuarioID;

            try
            {
                cn.Open();
                SqlCommand addCmd = new SqlCommand(sSelectSQL, cn);
                res = addCmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException sq)
            {
                MostrarMsjModal("Error: " + sq.Message, "ERR");
                cn.Close();
            }

            return res;
        }
        /******************************************************************************/
        //
        protected void btnActivate_Click(object sender, EventArgs e)
        {
            try
            {
                asignarPlan();
                limpiarCampos();
                MostrarPantalla("");
                MostrarMsjModal("Se activó el plan exitosamente", "EXI");

            }
            catch (Exception ex)
            {
                MostrarMsjModal(string.Format("Error tratanto de Activar el plan. Detalle: " + ex), "ERR");
            }
        }
        //
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                limpiarCampos();
                MostrarPantalla("");
            }
            catch (Exception ex)
            {
                MostrarMsjModal(string.Format("Error tratanto de Activar el plan. Detalle: " + ex), "ERR");
            }
        }
        //
        private void limpiarCampos()
        {
            ddlPlan.SelectedIndex = 0;
            ddlTipoEmpleado.SelectedIndex = 0;
            txtOtroTipoEmpleado.Text = "";
            txtCedula.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtClaveNueva.Text = "";
            txtClaveRepetir.Text = "";
            txtCelular.Text = "";
            txtTelefono.Text = "";
            txtCelular2.Text = "";
            txtCorreo.Text = "";
            txtFechaNacimiento.Text = "";
            ddlEstadoCivil.SelectedIndex = 0;
            txtEPS.Text = "";
            txtObservacion.Text = "";
        }
        //
        public static Boolean EsFecha(String fecha)
        {
            try
            {
                string sFechaUni = fecha.Substring(6, 4) + fecha.Substring(5, 1) + fecha.Substring(3, 2) + fecha.Substring(2, 1) + fecha.Substring(0, 2);
                DateTime.Parse(sFechaUni);
                return true;
            }
            catch
            {
                return false;
            }
        }
        //
        public static Boolean EsCorreo(String correo)
        {
            bool isEmail = false;
            try
            {
                isEmail = Regex.IsMatch(correo, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", RegexOptions.IgnoreCase);
            }
            catch
            {
                return false;
            }
            return isEmail;
        }
        //bool isEmail = Regex.IsMatch(emailString, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", RegexOptions.IgnoreCase);
        protected void txtRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (txtRol.SelectedValue != "")
            {
                if (txtRol.SelectedValue == "2")
                {
                    //Profesor
                    phSucursal.Visible = true;
                    phTipoUsuario.Visible = true;
                    phCedula.Visible = true;
                    phNombre.Visible = true;
                    phClave.Visible = true;
                    phCorreo.Visible = true;
                    phCelular.Visible = true;
                    phCamposLicsu.Visible = true;
                    phObservacion.Visible = true;
                    phRegistrar.Visible = true;
                    phPlan.Visible = true;
                    phPlanActivar.Visible = false;
                    phProfesor.Visible = true;
                }
                else if (txtRol.SelectedValue == "4")
                {
                    //Administrador Cliente
                    phSucursal.Visible = false;
                    phTipoUsuario.Visible = true;
                    phCedula.Visible = true;
                    phNombre.Visible = false;
                    phClave.Visible = true;
                    phCorreo.Visible = false;
                    phCelular.Visible = true;
                    phCamposLicsu.Visible = false;
                    phObservacion.Visible = true;
                    phRegistrar.Visible = true;
                    phPlan.Visible = true;
                    phPlanActivar.Visible = false;
                    phProfesor.Visible = false;
                }
                else if (txtRol.SelectedValue == "3")
                {
                    phProfesor.Visible = false;
                }
            }
        }
        private void MostrarMsjModal2(string msj, string tipo)
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
            ScriptManager.RegisterStartupScript(this, GetType(), "MostrarMsjModal2", "MostrarMsjModal2('" + msj.Replace("'", "").Replace("\r\n", " ") + "','" + sTitulo + "','" + sCcsClase + "');", true);
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


        protected void btnIr_Click(object sender, EventArgs e)
        {
            Response.Redirect("consultarUsuarios.aspx");
        }

        protected void btnSolicitar_Click(object sender, EventArgs e)
        {

           
        }

        protected string generarCupon()
        {
            string bonoid = "";
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[15];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }

            var finalString = new String(stringChars);

            bonoid = Utilidades.EjeSQL("SELECT BonoNumero FROM Bonos WHERE BonoNumero = " + finalString, cn, ref Err, true);
            if (bonoid == finalString)
                generarCupon();

            return finalString;
        }

        protected void Unnamed_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void chkSolicitar_CheckedChanged(object sender, EventArgs e)
        {
            if (chkSolicitar.Checked)
            {
                txtBono.Enabled = false;
                //Generar un bono e ingresarlo al input
                string BonoNumero = generarCupon();
                //Guardar el Bono en la BD
                string BonoEmpresa = cliente;

                sSelectSQL = "INSERT INTO Bonos (BonoNumero, BonoEmpresa, BonoEstado, BonoUsuarioID, FechaInicio, FechaFin) VALUES" +
                    " ('" + BonoNumero + "'," + BonoEmpresa + ", 0, 0, CONVERT(DATE, SYSDATETIME(), 109), DATEADD(WEEK,1, CONVERT(DATE, SYSDATETIME(), 109)))";
                Utilidades.EjeSQL(sSelectSQL, cn, ref Err, false);
                txtBono.Text = BonoNumero;
            }
            else
            {
                txtBono.Enabled = true;
                txtBono.Text = "";
            }
            
        }

        protected void ddlTipoEmpleado_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipoEmpleado.SelectedValue != "Empleado")
            {
                phNombre.Visible = true;
                phCorreo.Visible = true;
            }
        }
    }
}