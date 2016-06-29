<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="XmlMedical.aspx.cs" Inherits="LicsuWeb.Validado.XmlMedical" EnableEventValidation="false" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Reservas Medical</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-footable/0.1.0/css/footable.min.css" rel="stylesheet" type="text/css" />
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
            <h2 class="pull-left">Reservas Medical</h2>
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
                <div class="row">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-10">
                        <div class="col-lg-6 col-xs-8">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Clase"></asp:TextBox>
                        </div>
                        <div class="col-lg-4 col-xs-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                        
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
                <br />
                <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                    AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="ClasePlantillaID" CssClass="footable" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging"
                    OnRowCommand="GridView1_RowCommand"
                    EmptyDataText="No existen Clases medical reservadas">
                    <Columns>     
                        <asp:TemplateField HeaderText="Número" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="ClaseplantillaID" Visible="false" runat="server" Enabled="false" Text='<%# Eval("ClaseplantillaID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Clase">
                            <ItemTemplate>
                                <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Fecha">
                            <ItemTemplate>
                                <asp:Label ID="ClasePlantillaFecha" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaFecha") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Hora">
                            <ItemTemplate>
                                <asp:Label ID="ClasePlantillaHora" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaHora") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="# Sensores">
                            <ItemTemplate>
                                <asp:Label ID="ClaseSensor" runat="server" Enabled="false" Text='<%# Eval("ClaseSensor") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Intervalo">
                            <ItemTemplate>
                                <asp:Label ID="ClaseIntervalo" runat="server" Enabled="false" Text='<%# Eval("ClaseIntervalo") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>    
                        <asp:ButtonField CommandName="descargar" 
                            ButtonType="Button" Text="Descargar" HeaderText="Descargar">
                            <ControlStyle ></ControlStyle>
                        </asp:ButtonField>                                                 
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                
            </Triggers>
        </asp:UpdatePanel>
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
                    <img src="img/loading.gif" class="img-responsive center-block" />
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
    <!-- Msj Modal -->
    <div class="modal fade" id="modalDescarga" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title"><label id="Label1">Descargar archivo XML</label></h4>
          </div>
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-1">
                        <span id="Span1" class="fa fa-check fa-2x text-info"></span>
                    </div>
                    <div class="col-md-11">
                        <label id="Label2">Para descargar el archivo por favor da clic en Descargar.</label>
                    </div>
                </div>
                <div class="clearfix"></div>      </div><!-- /modal-body -->
          <div class="modal-footer">
                <asp:Button runat="server" Text="Descargar" OnClick="Unnamed_Click" ID ="btnDescargar2" CssClass="btn btn-purple" />
          </div>
        </div> 
      </div>
    </div>
    <!-- Msj Modal -->
    <div class="modal fade" id="modalDescargaExito" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title"><label id="Label3">Descargar archivo XML</label></h4>
          </div>
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-1">
                        <span id="Span2" class="fa fa-check fa-2x text-info"></span>
                    </div>
                    <div class="col-md-11">
                        <label id="Label4">La descargar fue exitosa.</label>
                    </div>
                </div>
                <div class="clearfix"></div>      </div><!-- /modal-body -->
          <div class="modal-footer">
                <asp:Button runat="server" Text="Aceptar" OnClick="Button1_Click" ID ="Button1" CssClass="btn btn-purple" />
          </div>
        </div> 
      </div>
    </div>

<script src="js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-footable/0.1.0/js/footable.min.js"></script> 
<script src="js/bootstrap.min.js"></script>
<script src="../Scripts/formValidation/formValidation.min.js"></script>
<script src="../Scripts/formValidation/bootstrap.min.js"></script>
<script src="../Scripts/formValidation/language/es_ES.js"></script>
<script src="js/moment.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript">

    $(function () {
        $('[id*=GridView1]').footable();
    });

    function MostrarMsjModal(message, title, ccsclas) {
        var vIcoModal = document.getElementById("icoModal");
        vIcoModal.className = ccsclas;
        $('#lblMsjTitle').html(title);
        $('#lblMsjModal').html(message);
        $('#Msjmodal').modal('show');
        return true;
    }

    function MostrarDescarga() {
        $('#modalDescarga').modal('show');
        return true;
    }

    function QuitarDescarga() {
        $('#modalDescargaExito').modal('show');
        return true;
    }
</script>
    </form>
</body>
</html>

