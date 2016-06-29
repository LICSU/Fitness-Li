<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ingreso.aspx.cs" Inherits="LicsuWeb.Validado.Ingreso" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Licsu - Autenticación</title>
    <link rel="stylesheet" href="css/ingreso.css" media="screen" type="text/css" />
</head>
<body>
    <asp:Label ID="lblValidado" runat="server" Text="" Visible="False"></asp:Label>
    <form id="login" class="login" runat="server">
    <h2>Ingresar</h2>
    <label for="user" class="icon-user">Usuario:</label>
    <asp:TextBox ID="Usuario" class="user" runat="server"></asp:TextBox>
    <label for="password" class="icon-lock">Clave:</label>
    <asp:TextBox ID="Clave" type="password" class="password" runat="server"></asp:TextBox>
    <label for="remember"><input type="checkbox" id="remember" /><span class="remember"/> Recordarme</label>

    <asp:Button ID="bAceptar" runat="server" Text="Ok" OnClick="bAceptar_Click" />
    <ul class="extra">
    <li><a href="#" class="forgetPassword">Recordar Clave</a></li>
    <li><a href="https://www.facebook.com/pages/Academia-Licsu-Medell%C3%ADn/195262543834692?fref=ts" class="facebook icon-facebook">Facebook</a></li>
    <li><a href="#" class="googlePlus icon-google-plus-sign">Google+</a></li>
    </ul>
    <div class="blur"></div>
    <asp:Label ID="lblError" runat="server" Text="Label" Visible="False"></asp:Label>
    </form>
    <script src='http://codepen.io/assets/libs/fullpage/jquery.js'></script>
    <script src="js/ingreso.js"></script>
    </body>
</html>
