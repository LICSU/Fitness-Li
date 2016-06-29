<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucMenu.ascx.cs" Inherits="LicsuWeb.UserControls.Template.ucMenu" %>
 <!-- NAV TOP  -->
<nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">LICSU</a> 
    </div>
    <div style="color: white; padding: 15px 50px 5px 50px; float: right; font-size: 16px;">
        <asp:LinkButton runat="server" ID="lnkCerrarSesion" OnClick="lnkCerrarSesion_Click" CssClass="btn btn-danger square-btn-adjust">Cerrar Sesión</asp:LinkButton> 
    </div>
</nav>   
 <!-- /. NAV TOP  -->

<!--  NAV SIDE  -->
<nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse">

         <asp:Repeater ID="rptMenuLateral" runat="server" OnItemDataBound="rptMenuLateral_ItemDataBound">
            <HeaderTemplate>
                <ul class="nav" id="main-menu">
		            <li class="text-center">
                        <%--<img src="assets/img/find_user.png" class="user-image img-responsive"/>--%>
                        <asp:Image ID="imgPerfil" runat="server" CssClass="user-image img-responsive" />
		            </li>
            </HeaderTemplate>
            <ItemTemplate>
                <li><a href='<%# Eval("urlMenu") %>'><%# Eval("DesMenu") %></a><asp:Literal ID="ltrlSubMenuSuperior" runat="server"></asp:Literal></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>           
        
               
    </div>
</nav>  
<!-- /. NAV SIDE  -->

    <!--  PAGE WRAPPER  -->
    <div id="page-wrapper" >