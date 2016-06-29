using LicsuWeb.Validado.Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LicsuWeb.Validado.Fachada
{
    public class PerfilFachada
    {


        public static Usuario ObtenerUsuario(long usuarioID)
        {
            try
            {
                LicsuDataContext dc = new LicsuDataContext();
                var usuario = from u in dc.Usuarios where u.UsuarioID == usuarioID select u;
                return usuario.FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public static bool ActualizarUsuario(Usuario usuarioActualizar, bool actualizarClaveEs, ref string error)
        {
            try
            {
                LicsuDataContext dc = new LicsuDataContext();
                
                Usuario usuarioActual = dc.Usuarios.Single(d => d.UsuarioID.Equals(usuarioActualizar.UsuarioID));
                if (usuarioActual != null)
                {
                    //Si el usuario cambio actualizo la cedula verificarsi ya existe en base de datos
                    if (usuarioActualizar.UsuarioCedula != usuarioActual.UsuarioCedula)
                    {
                        if (UsuarioCedulaExisteEs(usuarioActualizar.UsuarioCedula))
                        {
                            error = string.Format("El usuario con la cédula: <b>{0}</b> ya se encuentra registrado.", usuarioActualizar.UsuarioCedula);
                            return false;
                        }
                    }


                    usuarioActual.UsuarioCedula = usuarioActualizar.UsuarioCedula;
                    usuarioActual.UsuarioNombre = usuarioActualizar.UsuarioNombre;
                    usuarioActual.UsuarioApellido = usuarioActualizar.UsuarioApellido;
                    usuarioActual.UsuarioCorreo = usuarioActualizar.UsuarioCorreo;
                    usuarioActual.UsuarioFechaNacimiento = usuarioActualizar.UsuarioFechaNacimiento;
                    usuarioActual.UsuarioEstadoCivil = usuarioActualizar.UsuarioEstadoCivil;
                    usuarioActual.UsuarioSexo = usuarioActualizar.UsuarioSexo;
                    usuarioActual.UsuarioTelefono = usuarioActualizar.UsuarioTelefono;
                    usuarioActual.UsuarioCelular1 = usuarioActualizar.UsuarioCelular1;
                    usuarioActual.UsuarioCelular2 = usuarioActualizar.UsuarioCelular2;
                    usuarioActual.UsuarioObservacion = usuarioActualizar.UsuarioObservacion;

                    if (actualizarClaveEs)
                        usuarioActual.UsuarioClave = usuarioActualizar.UsuarioClave;


                    dc.SubmitChanges();

                    return true;

                }
                else
                    return false;

                
            }
            catch (Exception ex)
            {                
                throw new Exception("Ha ocurrido un error al tratar de actualizar los datos.");
            }
        }



        public static bool UsuarioCedulaExisteEs(string usuarioNombre)
        {

            try
            {
                LicsuDataContext dc = new LicsuDataContext();
                return dc.Usuarios.SingleOrDefault(d => d.UsuarioCedula.Equals(usuarioNombre.Trim())) != null; 
            }
            catch (Exception ex)
            {

                throw new Exception(ex.Message);
            }            

        }



    }
}