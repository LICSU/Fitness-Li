<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucMenu.ascx.cs" Inherits="LicsuWeb.Validado.ucMenu" %>
<asp:Literal ID="MsjMenuLateral" runat="server"></asp:Literal>
<!--  NAV SIDE  -->
<nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse">
         <asp:Repeater ID="rptMenuLateral" runat="server" OnItemDataBound="rptMenuLateral_ItemDataBound">
            <HeaderTemplate>
                <ul class="nav" id="main-menu">		            
            </HeaderTemplate>
            <ItemTemplate>
                <li><a href='<%# Eval("MenuURL") %>'><%# Eval("MenuDescripcion") %></a><asp:Literal ID="ltrlSubMenuLateral" runat="server"></asp:Literal></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>           
    </div>
</nav>  
<!-- /. NAV SIDE  -->