﻿using System;
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
    public partial class DetallesUsuario : System.Web.UI.Page
    {
        string cedulaUser = "";
        string Err = "", sSelectSQL = "";
        DataTable dt;
        string totalClases= "";
        string activasClases = "";
        string disponiblesClases = "";
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlConnString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                cedulaUser = Request.QueryString["user"];
                string dato1 = "", dato2 = "", usuarioID = "";
                sSelectSQL = "SELECT UsuarioNombre as MAXIMO FROM Usuario WHERE UsuarioCedula=" + cedulaUser;
                Utilidades.maxRegistro(ref dato1, sSelectSQL, cn, ref Err);
                sSelectSQL = "SELECT UsuarioApellido as MAXIMO FROM Usuario WHERE UsuarioCedula=" + cedulaUser;
                Utilidades.maxRegistro(ref dato2, sSelectSQL, cn, ref Err);
                sSelectSQL = "SELECT UsuarioID as MAXIMO FROM Usuario WHERE UsuarioCedula=" + cedulaUser;
                Utilidades.maxRegistro(ref usuarioID, sSelectSQL, cn, ref Err);
                sSelectSQL = "SELECT * FROM PlanAlumnoAcumulado WHERE UsuarioID=" + usuarioID;
                cn.Open();
                SqlCommand cmd = new SqlCommand(sSelectSQL, cn);
                SqlDataReader dr = cmd.ExecuteReader();
                try {
                    if (dr.Read())
                    {
                       totalClases = dr["totalClases"].ToString();
                       disponiblesClases = dr["disponiblesClases"].ToString();
                    }
                }
                catch (SqlException sq) 
                {
                    MostrarMsjModal(sq.Message, "ERR");
                }
                dr.Close();
                cn.Close();
                lblUsuario.Text = "<strong>Usuario:</strong> " + dato1 + " " + dato2;
                lblClasesDisponibles.Text = "<strong>Clases Disponibles: </strong>" + disponiblesClases;
                lblClasesTotal.Text = "<strong>Total de Clases: </strong>" + totalClases;
                BindGridView();
            }                        
        }
        protected void BindGridView()
        {
            try
            {
                cn.Open();
                string cmd2 = "SELECT Usuario.UsuarioNombre as UsuarioNombre, " +
                               " Usuario.UsuarioApellido as UsuarioApellido, " +
                               " Usuario.UsuarioCedula as UsuarioCedula, " +
                               " PlanAlumno.ClasesActivas as ClasesActivas," +
                               " PlanAlumno.SaldoNegativo as SaldoNegativo, " +
                               " PlanAlumno.SaldoPositivo as SaldoPositivo, " +
                               " [Plan].PlanNombre as PlanNombre, " +
                               " [Plan].PlanCosto as PlanCosto," +
                               " [Plan].PlanCantidadClases as PlanCantidadClases" +
                               " FROM  PlanAlumno INNER JOIN"+
                               " Usuario ON PlanAlumno.UsuarioID = Usuario.UsuarioID INNER JOIN"+
                               " [Plan] ON PlanAlumno.PlanID = [Plan].PlanID AND Usuario.UsuarioCedula="+cedulaUser;
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }
    }
}