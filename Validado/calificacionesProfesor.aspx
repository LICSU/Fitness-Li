<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calificacionesProfesor.aspx.cs" Inherits="LicsuWeb.Validado.calificacionesProfesor" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Calificaciones por Profesor</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
</head>
<body>
    
<form id="form1" runat="server" class="form-horizontal">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
<div id="wrapper">
<!-- Encabezado -->
    <uc2:ucEncabezado runat="server" ID="ucEncabezado" />
<!-- Menu superior y lateral -->
<uc3:ucMenu runat="server" ID="ucMenu" />

    <!--  PAGE WRAPPER  -->
    <div id="page-wrapper" >
    <div id="page-inner">
    <!-- Contenido pagina -->
        <div class="row">
        <div class="col-md-12">
            <div class="col-md-4">
                <h2 class="pull-left">Calificaciones por Profesor</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
    <!-- Contenido -->  
    <div class="col-md-12">

        <div class="row placeholders">
        <div style="width: 90%; margin-right: 5%; margin-left: 2%; text-align: center">
            <asp:UpdatePanel ID="upCrudGrid" runat="server">
                <ContentTemplate>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label class="control-label col-xs-3">Seleccione el Profesor: </label>
                            <div class="col-xs-5">
                                <asp:DropDownList ID="dplProfesor" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlProfesor_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                    </div>  
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label class="control-label col-xs-3">Seleccione el Mes: </label>
                            <div class="col-xs-5">
                                <asp:DropDownList ID="ddlMeses" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMeses_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                    </div>                    
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label class="control-label col-xs-3"></label>
                            <div class="col-xs-5">
                                
                            </div>
                            <div class="col-xs-4" style="float:right;">
                                <asp:ImageButton ID="btnDescargar" runat="server" ImageUrl="~/Images/descargar.png"   OnClick="btnDescargar_Click"/>                                                
                            </div>
                        </div>
                    </div>
                    <asp:GridView ID="GridView1" runat="server" Width="95%" HorizontalAlign="Center"
                        AutoGenerateColumns="false" AllowPaging="true"
                        CssClass="table table-hover table-striped" PageSize="20"
                        onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No existen calificaciones de ese profesor.">
                        <Columns>
                            <asp:BoundField DataField="Clase" HeaderText="Clase" HeaderStyle-CssClass="text-center" />                                                                                        
                            <asp:BoundField DataField="Alumnos" HeaderText="Alumnos que Reservaron" HeaderStyle-CssClass="text-center" />                                                                                        
                            <asp:BoundField DataField="Promedios" HeaderText="Calificación Promedio (1 al 5)" HeaderStyle-CssClass="text-center" />                                                                                        
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnDescargar" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
              <img src="../Images/cargando.gif" class="img-responsive center-block">
            </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
        </div>
    </div>    
    <!-- Fin del Contenido -->  
    </div></
<!-- /. PAGE Inner  -->
    </div>
    <!-- /. WRAPPER  -->
</div>
<uc4:ucFooter runat="server" id="ucFooter" />
    <!---------------------------------- Modals --------------------------------->
    <!-- Modal PleaseWait-->
    <div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="clearfix">
                    <img src="../Images/cargando.gif" class="img-responsive center-block"/>
                </div>
            </div>
        </div> 
      </div>
    </div>
    <!-- Modal PleaseWait -->
    <!-- Msj Modal -->
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
    
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="../Scripts/formValidation/formValidation.min.js"></script>
<script src="../Scripts/formValidation/bootstrap.min.js"></script>
<script src="../Scripts/formValidation/language/es_ES.js"></script>
<script src="js/moment.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript">

    function MostrarMsjModal(message, title, ccsclas) {
        var vIcoModal = document.getElementById("icoModal");
        vIcoModal.className = ccsclas;
        $('#lblMsjTitle').html(title);
        $('#lblMsjModal').html(message);
        $('#Msjmodal').modal('show');
        return true;
    }

    $(document).ready(function () {
        $('#txtFechaRegistroDesde').datepicker({ format: 'dd/mm/yyyy' });

        $('#txtFechaRegistroHasta').datepicker({ format: 'dd/mm/yyyy' });
    });

</script>
    </form>
</body>
</html>


