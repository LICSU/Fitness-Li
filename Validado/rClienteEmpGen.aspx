<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rClienteEmpGen.aspx.cs" Inherits="LicsuWeb.Validado.rClienteEmpGen" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc3" TagName="ucFooter" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" 
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <uc1:ucHeader runat="server" ID="ucHeader" />
</head>
<body>
<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<!--<div id="wrapper">-->
<!-- Encabezado -->
    <uc2:ucEncabezado runat="server" id="ucEncabezado" />
<!-- Menu superior y lateral -->

    <!--  PAGE WRAPPER 
    <div id="page-wrapper" > -->
        <div id="page-inner">
        <!-- Contenido pagina -->
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-4">
                    <h2 class="pull-left">Rep. Empleados</h2>
                    </div>               
                    <div class="col-md-3 col-md-offset-5">
                        <div class="form-group text-right">
                            <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-default" NavigateUrl="Inicio.aspx"> Regresar</asp:HyperLink>
                        </div>
                    </div>
                </div>

            </div>
             <hr />

    <div class="form-horizontal">

        <div class="row col-md-offset-2 col-md-10">
            <asp:PlaceHolder ID="phCliente" runat="server">
                <div class="form-group">
                    <asp:Label ID="lblCliente" runat="server" AssociatedControlID="ddlCliente" CssClass="col-sm-3 control-label">Cliente:</asp:Label>     
                    <div class="col-sm-5 selectContainer">
                        <asp:DropDownList runat="server" ID="ddlCliente" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlCliente_SelectedIndexChanged"></asp:DropDownList>
                     </div>
                </div>
            </asp:PlaceHolder>
        </div>
<!---------------------------------- Reporte --------------------------------->
        <div class="row col-md-12">
            <rsweb:reportviewer id="ReportViewer1" runat="server" height="3052px" width="100%"
                font-names="Verdana" font-size="8pt" interactivedeviceinfos="(Collection)" waitmessagefont-names="Verdana"
                waitmessagefont-size="14pt" pagecountmode="Actual">
            </rsweb:reportviewer>
        </div>

    </div> 
        </div>
        <!-- /. PAGE Inner  -->
<!--     </div> -->
 <!--/. PAGE WRAPPER  -->

<uc3:ucFooter runat="server" id="ucFooter" />
    <script src="Scripts/formValidation/formValidation.min.js"></script>

<!--</div>-->
<!--/. WRAPPER -->

<!---------------------------------- Modals --------------------------------->
    <!-- Modal PleaseWait-->
    <div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="clearfix">
                    <img src="img/loading.gif" class="img-responsive center-block">
                </div>
            </div>
        </div> 
      </div>
    </div>
    <!-- Modal PleaseWait -->
    <!-- MSJ Modal -->
    <div class="modal fade" id="Msjmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title"><label id="lblMsjTitle"></label></h4>
          </div>
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-1">
                        <span id="icoModal" class="fa fa-times fa-2x text-danger"></span>
                    </div>
                    <div class="col-md-11">
                        <label id="lblMsjModal"></label>
                    </div>
                </div>
                <div class="clearfix"></div>      </div><!-- /modal-body -->
          <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
          </div>
        </div> 
      </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#ddlCliente').on('change', function () {
                $('#pleaseWaitDialog').modal('show');
            });
        });

        function MostrarMsjModal(message, title, ccsclas) {
            var vIcoModal = document.getElementById("icoModal");
            vIcoModal.className = ccsclas;
            $('#lblMsjTitle').html(title);
            $('#lblMsjModal').html(message);
            $('#Msjmodal').modal('show');
            return true;
        }
    </script>
</form>
</body>
</html>
