<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReservaAlumnoLicsu.aspx.cs" Inherits="LicsuWeb.Validado.ReservaAlumnoLicsu" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Reservar Clases</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-footable/0.1.0/css/footable.min.css" rel="stylesheet" type="text/css" />
    <style>
        .table-responsive{
            margin: 0 auto !important;
        }
    </style>
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
                <h2 class="pull-left">Reservar Clases</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
    <!-- Contenido -->
          
    <!-- Fila Superior Izquierda -->
        <div class="row">
            <div class="col-lg-6">
                <h3 class="text-left">Calendario</h3>
                <div class="form-group" style="margin-left:0px;">
                    <asp:Calendar ID="calendario" runat="server" OnSelectionChanged="calendario_SelectionChanged" 
                        DayNameFormat="Shortest" 
                        Height="200px"  CssClass="centrado"
                        ShowGridLines="True" Width="220px" OnDayRender="calendario_DayRender">
                        
                        <DayHeaderStyle HorizontalAlign="Center" CssClass="text-center" BorderStyle="Solid" BorderWidth="1px" BorderColor="#000" />
                        <NextPrevStyle  />
                        <OtherMonthDayStyle  />
                        <SelectedDayStyle  />
                        <SelectorStyle />
                        <TitleStyle  />
                        <TodayDayStyle  />
                    </asp:Calendar>                       
                </div>
                <br />
                <asp:Label runat="server" ID="lblTituloClasesReservas" Text="" CssClass="text-info text-center"></asp:Label>
                    <asp:UpdatePanel ID="upCrudGrid" runat="server">
                    <ContentTemplate>
                        
                        <asp:GridView ID="GridView1" runat="server" 
                            AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="ClasePlantillaID" CssClass="footable" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No Existen Clases Para Esa Fecha"
                            OnRowCommand="GridView1_RowCommand">
                            <Columns>
                            <asp:ButtonField CommandName="reservar"
                                    ButtonType="Button" Text="Reservar" HeaderText="Reservar">
                                    <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Día" >
                                <ItemTemplate>
                                    <asp:Label runat="server" Visible="false"  ID="ClaseID" Text='<%# Eval("ClaseID") %>'  />
                                    <asp:Label runat="server" Visible="false"  ID="ClasePlantillaCupos" Text='<%# Eval("ClasePlantillaCupo") %>' />
                                    <asp:Label runat="server" Visible="false"  ID="ClasePlantillaID" Text='<%# Eval("ClasePlantillaID") %>' />
                                    <asp:Label ID="ClasePlantillaFecha" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaFecha") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Clase" >
                                <ItemTemplate>
                                    <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tipo" >
                                <ItemTemplate>
                                    <asp:Label ID="ClaseTipo" runat="server" Enabled="false" Text='<%# Eval("ClaseTipo") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
            </div>
            <!-- Fin Fila Superior Izquierda -->
            <div class="col-lg-6">                
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label1q" CssClass="text-primary" Text="Plan Nombre: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblPlan" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label3" CssClass="text-primary"  Text="Fecha de Finalización: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblFechaFin" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label5" CssClass="text-primary"  Text="Deuda: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblDeuda" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label4" CssClass="text-primary"  Text="Clases Regulares: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblTotalClasesRegulares" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label7" CssClass="text-primary"  Text="Regulares Disponibles: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblClasesRegularesDisp" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label12" CssClass="text-primary"  Text="Clases Complementarias: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblTotalClasesComplemen" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label14" CssClass="text-primary"  Text="Complementarias Disponibles: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblClasesComplemenDisp" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-6">
                                <asp:Label runat="server" ID="label15" CssClass="text-primary"  Text="Vence Matricula Anual: "></asp:Label>
                            </div>
                            <div class="col-lg-6 text-left">
                                <asp:Label runat="server" ID="lblMatriculaAnual" ></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <br />
                        </div>
                        <asp:Label runat="server" ID="Label8" Text="Mis Clases" CssClass="text-info center"></asp:Label>
                        <asp:GridView ID="GridView2" runat="server" 
                            AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="ReservasID" CssClass="footable" PageSize="20"
                            onpageindexchanging="GridView2_PageIndexChanging" EmptyDataText="No Tiene Reservas"
                            OnRowCommand="GridView2_RowCommand">
                            <Columns>
                            <asp:ButtonField CommandName="cancelar"
                                    ButtonType="Button" Text="Cancelar" HeaderText="Cancelar">
                            <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Código" Visible="false">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdfPrueba" runat="server" />
                                    <asp:Label runat="server"  ID="ReservasID" Text='<%# Eval("ReservaID") %>'  />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Clase"  Visible="false">
                                <ItemTemplate>
                                    <asp:Label runat="server"  ID="ClasePlantillaID" Text='<%# Eval("ClasePlantillaID") %>' />
                                    <asp:Label runat="server"  ID="ClaseID" Text='<%# Eval("ClaseID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Clase" >
                                <ItemTemplate>
                                    <asp:Label runat="server"  ID="ClaseDescripcion" Text='<%# Eval("ClaseDescripcion") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha" >
                                <ItemTemplate>
                                    <asp:Label runat="server"  ID="ClasePlantillaFecha" Text='<%# Eval("ClasePlantillaFecha") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tipo" >
                                <ItemTemplate>
                                    <asp:Label ID="ClaseTipo" runat="server" Enabled="false" Text='<%# Eval("ClaseTipo") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>                        
                        </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
            </div>
            
            <!-- Fila Inferior Izquierda -->
        </div>
        <div class="row">
            <div class="col-lg-2"></div>
            <div class="col-lg-4">
            </div>
            <!-- Fin Fila Inferior Izquierda -->
            <!-- Fila Inferior Derecha -->
            <!-- Fila Superior Derecha -->
            <div class="col-lg-4">
                <!-- Aqui los datos personales del alumno (Plan, Deuda,...)-->
                    
            </div>
            <div class="col-lg-2"></div>
            <!-- Fin Fila Superior Derecha -->
            <div class="col-lg-2"></div>
            <!-- Fin Fila Inferior Derecha -->
        </div>    
    <!-- Fin del Contenido -->  
    </div></
<!-- /. PAGE Inner  -->
    </div>
    <!-- /. WRAPPER  -->
</div>
<uc4:ucFooter runat="server" id="ucFooter" />
    <!-- ------------------------------- -->
    <!---------------------------------- Modals --------------------------------->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button id="Button2" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title"><label id="Label11"></label></h4>
          </div>
          <div class="modal-body">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <div class="row">
                                <asp:DropDownList runat="server" ID="dplCantidadClases" CssClass="form-control">
                                    <asp:ListItem Text="Seleccione la Cantidad" Value=""></asp:ListItem>
                                    <asp:ListItem Text="8 Clases" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="12 Clases" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Label ID="Label10" Visible="false" runat="server"></asp:Label>
                            <asp:Button ID="Aceptar" runat="server" Text="Aceptar" CssClass="btn btn-purple"  OnClick="Aceptar_Click"/>
                            <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                                                
                    </Triggers>
                </asp:UpdatePanel>
                <div class="clearfix"></div>   
          </div><!-- /modal-body -->
          <div class="modal-footer">
          </div>
        </div> 
      </div>
    </div>
    <!-- Msj Modal -->
    <!---------------------------------- Modals --------------------------------->
    <div class="modal fade" id="selectPuesto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title"><label id="Label6"></label></h4>
          </div>
          <div class="modal-body">
              <asp:UpdatePanel runat="server" ID="panelSelect" >
                  <ContentTemplate>
                      <div class="row">
                    <div class="form-group">
                        <label class="col-xs-4 control-label">Seleccione el Puesto: </label>
                        <div class="col-xs-6">
                            <asp:DropDownList runat="server" ID="dplPuestoClase" ClientIDMode="Static"
                                 AutoPostBack="true" OnSelectedIndexChanged="dplPuestoClase_SelectedIndexChanged" CssClass="form-control">
                                <asp:ListItem  Value="" Text="Seleccione el Puesto"></asp:ListItem>
                            </asp:DropDownList>                                                           
                        </div>
                    </div>
                </div>
                  </ContentTemplate>
              </asp:UpdatePanel>
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <h4 class="text-info">Guardando..</h4><br />
                    <img src="img/loading.gif" class="img-responsive center-block"><br />
                    <h4 class="text-info">Espere Por Favor</h4>
                </ProgressTemplate>
            </asp:UpdateProgress>
                <div class="clearfix"></div>      </div><!-- /modal-body -->
          <div class="modal-footer">
          </div>
        </div> 
      </div>
    </div>
    <!-- Msj Modal -->
    <div class="modal fade" id="Div1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title"><label id="Label1"></label></h4>
          </div>
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-1">
                        <span id="Span1" class="fa fa-times fa-2x text-danger"></span>
                    </div>
                    <div class="col-md-11">
                        <label id="Label2"></label>
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
    <div class="modal fade" id="modalPrueba" tabindex="-1" data-keyboard="false" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <!--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>-->
            <h4 class="modal-title"><label id="Label9"></label></h4>
          </div>
          <div class="modal-body">   
            <div>
                <asp:Panel runat="server" ID="pnDisponibles">
                </asp:Panel> 
            </div>                               
           <div class="clearfix"></div>      </div><!-- /modal-body -->
          <div class="modal-footer">
                <asp:Button CssClass="btn btn-default" runat="server" ID ="btnCerrarPuesto" OnClick="btnCerrarPuesto_Click" Text="Cerrar"></asp:Button>
          </div>
        </div> 
      </div>
    </div>
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

    <!-- Aviso Modal -->
    <div class="modal fade" id="modalLista" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title">Lista de Espera</h4>
          </div>
          <div class="modal-body">
              <div class="row">
                  <asp:Label runat="server" ID="label222" CssClass="col-lg-10 control-label">No hay Cupos disponibles. ¿Desea se le informe cuando haya cupo.?</asp:Label>
              </div>
              <div class="row">
                <asp:DropDownList runat="server" ID="dplListaEspera" CssClass="form-control" OnSelectedIndexChanged="dplListaEspera_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="Seleccione una opción" Value=""></asp:ListItem>
                    <asp:ListItem Text="Si por favor" Value="SI"></asp:ListItem>
                    <asp:ListItem Text="No gracias" Value="NO"></asp:ListItem>
                </asp:DropDownList>
                </div>
          <div class="modal-footer">
               <asp:Button ID="Button1" runat="server" OnClick="btnAviso_Click" CssClass="btn btn-default" Text="Cerrar"></asp:Button>
          </div>
        </div> 
      </div>
    </div>
    </div>

    <!-- Aviso Modal -->
    <div class="modal fade" id="modalAviso" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title">Aviso...</h4>
          </div>
          <div class="modal-body">
              <div class="row">
                  <asp:Label runat="server" ID="label13" CssClass="col-lg-10 control-label">Se ha agregado correctamente a la lista de espera, a penas haya disponibilidad de cupo le avisaremos a través del correo electrónico.</asp:Label>
              </div>
          <div class="modal-footer">
                <asp:Button ID="btnAviso" runat="server" OnClick="btnAviso_Click" CssClass="btn btn-default" Text="Aceptar"></asp:Button>
          </div>
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
        $('[id*=GridView2]').footable();
    });

    function MostrarMsjModal(message, title, ccsclas) {
        var vIcoModal = document.getElementById("icoModal");
        vIcoModal.className = ccsclas;
        $('#lblMsjTitle').html(title);
        $('#lblMsjModal').html(message);
        $('#Msjmodal').modal('show');
        return true;
    }

    function MostrarLista() {
        $('#modalLista').modal('show');
        return true;
    }

    function MostrarCantidad() {
        $('#editModal').modal('show');
        return true;
    }

    function MostrarAviso() {
        $('#modalAviso').modal('show');
        return true;
    }

    function VentanaPrueba() {
        $('#modalPrueba').modal('show');
        return true;
    }
    /*
    function VentanaPruebaClose() {
        $('#modalPrueba').modal('show');
        return false;
    }*/
</script>
    </form>
</body>
</html>