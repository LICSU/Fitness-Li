<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminBase.aspx.cs" Inherits="LicsuWeb.AdminBase" %>
<%@ Register Src="~/UserControls/Template/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/UserControls/Template/ucFooter.ascx" TagPrefix="uc1" TagName="ucFooter" %>
<%@ Register Src="~/UserControls/Template/ucMenu.ascx" TagPrefix="uc1" TagName="ucMenu" %>

<uc1:ucHeader runat="server" id="ucHeader" />

<form id="form2" runat="server">

<div id="wrapper">

    <!-- Menu superior y lateral -->
    <uc1:ucMenu runat="server" id="ucMenu" />

    <div id="page-inner">
    <!-- Contenido pagina -->
    

    <div class="row">
        <div class="col-md-12">
            <div class="col-md-4">
                <h2 class="pull-left">Resumen de Actividades</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    <asp:HyperLink ID="HyperLink4" runat="server" CssClass="btn btn-purple" NavigateUrl="#">Actualizar Perfil</asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
     <hr />

    <div class="row">
        <div class="col-md-12">

        </div>
    </div>


      </div>
    <!-- /. PAGE Inner  -->

</div>
<!-- /. WRAPPER  -->

<uc1:ucFooter runat="server" id="ucFooter" />

</form>    


<!-- Scripts  -->

<!-- /Scripts  -->

</body>
</html>













