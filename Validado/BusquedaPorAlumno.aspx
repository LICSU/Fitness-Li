<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BusquedaPorAlumno.aspx.cs" Inherits="LicsuWeb.Validado.BusquedaPorAlumno" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Búsqueda Individual</title>
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
            <h2 class="pull-left">Búsqueda Individual</h2>
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
                    <div class="col-lg-8 col-xs-8">
                        <asp:TextBox runat="server" ID="txtUsuario"  CssClass="form-control"  placeholder="Cédula"></asp:TextBox>
                    </div>
                    <div class="col-lg-4 col-xs-4">
                        <asp:Button runat="server" ID="btnBuscar" CssClass="btn btn-purple" Text="Buscar" OnClick="btnBuscar_Click" />                                                                                         
                    </div>
                </div>
                <div class="col-lg-1"></div>
            </div>  
            <!-- Contenido -->
            <asp:PlaceHolder runat="server" ID="upDatos" Visible="false">  
                <div class="row">
                    <br />
                    <div class="col-lg-12" style="text-align:left !important;">
                        <div class="col-lg-12"><h5 class="text-left"><strong>Datos Personales</strong></h5></div> 
                        <div class="col-lg-6">
                            <asp:Label ID="lblNombres" runat="server" CssClass="text-left control-label"></asp:Label>
                        </div>
                        <div class="col-lg-6">
                            <asp:Label ID="lblCedula" runat="server" CssClass="text-left control-label"></asp:Label>
                        </div>      
                                         
                    </div>
                    <div class="col-lg-12" style="text-align:left !important;">
                        <div class="col-lg-6">
                            <asp:Label ID="lblFechaMatricula" runat="server" CssClass="text-left control-label"></asp:Label>
                        </div> 
                    </div>
                    <asp:PlaceHolder runat="server" ID="phLicsu" Visible="false">
                    <div class="col-lg-12" style="text-align:left !important;">                        
                        <div class="col-lg-6">
                            <asp:Label ID="lblEstado" runat="server" CssClass="text-left control-label" Text="Estado: "></asp:Label>
                        </div>
                    </div>
                        </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" ID="phEmpresa" Visible="false">
                        <div class="col-lg-12" style="text-align:left !important;">
                            <div class="col-lg-6">
                                <asp:Label ID="lblMesActual" runat="server" CssClass="text-left control-label" Text="Mes Actual: "></asp:Label>
                            </div>
                            <div class="col-lg-6">
                                <asp:Label ID="lblMesProximo" runat="server" CssClass="text-left control-label" Text="Mes Próximo: "></asp:Label>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    
                    <br />
                    <div class="col-lg-12"  style="text-align:left !important;">
                        <div class="col-lg-12"><h5 class="text-left"><strong>Último Plan Activo</strong></h5></div> 
                        <div class="col-lg-12">
                            <div class="col-lg-4"><asp:Label ID="lblPlanNombre" runat="server" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-4"><asp:Label ID="lblClasesActivas" runat="server" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-4"><asp:Label ID="lblDeuda" runat="server" CssClass="control-label"></asp:Label></div>
                            
                        </div>
                        <div class="col-lg-6">
                            <div class="col-lg-7"><asp:Label runat="server" ID="Label5" Text="Total Regulares" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-5"><asp:TextBox ID="lblTotalClasesR" runat="server" CssClass="form-control"></asp:TextBox></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="col-lg-7"><asp:Label runat="server" ID="Label4" Text="Disponibles Regulares" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-5"><asp:TextBox ID="lblDispClasesR" runat="server" CssClass="form-control"></asp:TextBox></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="col-lg-7"><asp:Label runat="server" ID="Label3" Text="Total Complementarias" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-5"><asp:TextBox ID="lblTotalClasesC" runat="server" CssClass="form-control"></asp:TextBox></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="col-lg-7"><asp:Label runat="server" ID="Label2" Text="Disponibles Complementarias" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-5"><asp:TextBox ID="lblDispClasesC" runat="server" CssClass="form-control"></asp:TextBox></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="col-lg-7"><asp:Label runat="server" ID="Label1" Text="Fecha de Inicio" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-5"><asp:TextBox ID="lblFechaInicio" runat="server" CssClass="form-control"></asp:TextBox></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="col-lg-7"><asp:Label runat="server" ID="lbl1" Text="Fecha Final" CssClass="control-label"></asp:Label></div>
                            <div class="col-lg-5"><asp:TextBox ID="lblFechaFin" runat="server" CssClass="form-control"></asp:TextBox></div>
                        </div>
                        <asp:HiddenField ID="hdfPlanAlumnoID" runat="server" />
                        <asp:HiddenField ID="hdfCedulaID" runat="server" />
                        <asp:HiddenField ID="hdfUsuarioID" runat="server" />
                        <div class="col-lg-12"><asp:Button runat="server" ID="btnActualizar" CssClass="bt btn-purple" Text="Actualizar" OnClick="btnActualizar_Click" /></div> 
                        
                    </div>
                    <br />
                    <div class="col-lg-12"  style="text-align:left !important;">
                        <div class="col-lg-12"><h5 class="text-left"><strong>Reservas Realizadas</strong></h5></div> 
                        <asp:GridView ID="GridView1" runat="server" Width="100%" HorizontalAlign="Center"
                        AutoGenerateColumns="false" AllowPaging="true"
                        DataKeyNames="BonoID" CssClass="footable" PageSize="20"
                        onpageindexchanging="GridView1_PageIndexChanging"
                        EmptyDataText="No existen Reservas para este Usuario">
                        <Columns>  
                            <asp:TemplateField HeaderText="Clase">
                                <ItemTemplate>
                                    <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha Clase">
                                <ItemTemplate>
                                    <asp:Label ID="FechaClase" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaFecha") %>' />
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Reservada el">
                                <ItemTemplate>
                                    <asp:Label ID="FechaReserva" runat="server" Enabled="false" Text='<%# Eval("FechaReserva") %>' />
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Profesor">
                                <ItemTemplate>
                                    <asp:Label ID="Profesor" runat="server" Enabled="false" Text='<%# Eval("Profesor") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>                                                           
                        </Columns>
                        </asp:GridView>
                    </div>
                    <br />
                    <div class="col-lg-12"  style="text-align:left !important;">
                        <div class="col-lg-12"><h5 class="text-left"><strong>Pagos Realizadas</strong></h5></div> 
                        <asp:GridView ID="GridView2" runat="server" Width="100%" HorizontalAlign="Center"
                        AutoGenerateColumns="false" AllowPaging="true"
                        DataKeyNames="FacturaNumero" CssClass="footable" PageSize="20"
                        onpageindexchanging="GridView2_PageIndexChanging"
                        EmptyDataText="No existen Pagos realizados por este Usuario">
                        <Columns>  
                            <asp:TemplateField HeaderText="Plan">
                                <ItemTemplate>
                                    <asp:Label ID="PlanNombre" runat="server" Enabled="false" Text='<%# Eval("PlanNombre") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Factura #">
                                <ItemTemplate>
                                    <asp:Label ID="FacturaNumero" runat="server" Enabled="false" Text='<%# Eval("FacturaNumero") %>' />
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Factura Fecha">
                                <ItemTemplate>
                                    <asp:Label ID="FacturaFecha" runat="server" Enabled="false" Text='<%# Eval("FacturaFecha") %>' />
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Factura Monto">
                                <ItemTemplate>
                                    <asp:Label ID="FacturaMonto" runat="server" Enabled="false" Text='<%# Eval("FacturaMonto") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>                                                           
                        </Columns>
                        </asp:GridView>
                    </div>
                    <div class="col-lg-12"  style="text-align:left !important;">
                        <div class="col-lg-12"><h5 class="text-left"><strong>Calificaciones</strong></h5></div> 
                        <asp:GridView ID="GridView3" runat="server" Width="100%" HorizontalAlign="Center"
                        AutoGenerateColumns="false" AllowPaging="true"
                        DataKeyNames="ClaseDescripcion" CssClass="footable" PageSize="20"
                        onpageindexchanging="GridView3_PageIndexChanging"
                        EmptyDataText="No existen Calificaciones para este Usuario">
                        <Columns>  
                            <asp:TemplateField HeaderText="Profesor">
                                <ItemTemplate>
                                    <asp:Label ID="PlanNombre" runat="server" Enabled="false" Text='<%# Eval("Profesor") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Clase">
                                <ItemTemplate>
                                    <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseNombre") %>' />
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Elemento">
                                <ItemTemplate>
                                    <asp:Label ID="ElementoNombre" runat="server" Enabled="false" Text='<%# Eval("ElementoNombre") %>' />
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Calificacion">
                                <ItemTemplate>
                                    <asp:Label ID="CalificacionNombre" runat="server" Enabled="false" Text='<%# Eval("CalificacionNombre") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>                                                           
                        </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12"></div>
                </div>
            </asp:PlaceHolder>   
            <!-- Fin Contenido-->   
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
        <ProgressTemplate>
            <img src="../Images/cargando.gif" class="img-responsive center-block"><br />
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
                    <img src="../Images/cargando.gif" class="img-responsive center-block" />
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
</script>
    </form>
</body>
</html>


