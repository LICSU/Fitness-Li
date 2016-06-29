using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicsuWeb
{
    public partial class Contactanos : System.Web.UI.Page
    {
        string mensaje = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            bool CorreoEnviado = false;
            CorreoEnviado = EnviarEmail();
            if (CorreoEnviado)
            {

            }
        }

        private bool EnviarEmail()
        {
            try
            {
                MailMessage NetMail = new MailMessage();
                SmtpClient MailClient = new SmtpClient();
                TimeZone zone =  TimeZone.CurrentTimeZone;
                DateTime universal = zone.ToUniversalTime(DateTime.Now);

                string servidor = "localhost";
                int puerto = 25;
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string email = txtEmail.Text.Trim();
                string telefono = txtTelefono.Text.Trim();
                string asunto = txtAsunto.Text.Trim();
                string mensaje = txtMensaje.Text.Trim();
                string destinatario = "Administracion@licsu.com"; //TODO: CAMBIAR POR admin@licsu.com

                MailClient.Credentials = new System.Net.NetworkCredential("info@licsu.com", "8A7r1DPxY_");
                NetMail.From = new MailAddress(email);
                NetMail.To.Add(new MailAddress(destinatario));
                NetMail.IsBodyHtml = true;
                NetMail.Subject = asunto + " " + universal.AddHours(-5).ToString(); //UTC -5 Colombia
                NetMail.Body = ObtenerPlantilla(nombre, apellido, email, telefono, asunto, mensaje);
  
                MailClient.EnableSsl = false;
                MailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                MailClient.Host = servidor;
                MailClient.Port = puerto;
                MailClient.Send(NetMail);
  
                NetMail.Dispose();
                NetMail = null;
                MailClient = null;
                return true;
            }
            catch (Exception e)
            {
                mensaje = e.Message + " ";
                return false;
            }
        }

        private string ObtenerPlantilla(string nombre, string apellido, string email, string telefono, string asunto, string mensaje)
        {
            string body = string.Empty;
            using (System.IO.StreamReader reader = new System.IO.StreamReader(Server.MapPath("~/Plantillas/formulario-contacto.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Nombre}", nombre);
            body = body.Replace("{Apellido}", apellido);
            body = body.Replace("{Email}", email);
            body = body.Replace("{Telefono}", telefono);
            body = body.Replace("{Asunto}", asunto);
            body = body.Replace("{Mensaje}", mensaje);
            
            return body;
        }
    }
}