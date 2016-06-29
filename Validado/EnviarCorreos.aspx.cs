using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicsuWeb.Validado
{
    public partial class EnviarCorreos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnvioInd_Click(object sender, EventArgs e)
        {
            //Mostrar Ventana Individual
            txtAsunto.Text = "";
            txtDestinatario.Text = "";
            txtMensaje.Text = "";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#addModal').modal({ show: true });");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddModalScript", sb.ToString(), false);  
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            //Enviar Correo  
            string destinatario = txtDestinatario.Text;
            string mensaje = txtMensaje.Text;
            string asunto = txtAsunto.Text;
        }
    }
}