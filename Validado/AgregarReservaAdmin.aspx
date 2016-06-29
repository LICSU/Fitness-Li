<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarReservaAdmin.aspx.cs" Inherits="LicsuWeb.Validado.AgregarReservaAdmin" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Agregar Reserva</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server" class="form-horizontal">
<asp:ScriptManager runat="server" ID="sm1" />
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
                <h2 class="pull-left">Agregar Reserva</h2>
            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">                 
                </div>
            </div>
        </div>
        </div>
    <hr />
        <!-- Contenido -->  
        <div class="row">
            <div style="width: 90%; margin-right: 5%; margin-left: 2%; text-align: center">
                <asp:UpdatePanel ID="upCrudGrid" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <div class="col-lg-2"></div>
                                <div class="col-lg-6">
                                    <input runat="server" id="txtBuscar" class="form-control"  placeholder="dd/mm/yyyy" />
                                </div>
                                <div class="col-lg-2">
                                    <asp:Button runat="server" ID="btnBuscar1" Text="Buscar" CssClass="btn btn-purple" OnClick="btnBuscar_Click1" />
                                </div>
                                <div class="col-lg-2"></div>
                            </div>
                        </div> 
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="ClaseID" CssClass="table table-hover table-striped" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging"
                            EmptyDataText="No existen Clases para Reservar.." OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="ClaseID" runat="server" Enabled="false" Text='<%# Eval("ClaseID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Clase" >
                                    <ItemTemplate>
                                        <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fecha" >
                                    <ItemTemplate>
                                        <asp:Label ID="ClasePlantillaFecha" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaFecha") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Hora" >
                                    <ItemTemplate>
                                        <asp:Label ID="ClasePlantillaHora" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaHora") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cupo" >
                                    <ItemTemplate>
                                        <asp:Label ID="ClasePlantillaCupo" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaCupo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Unidad" >
                                    <ItemTemplate>
                                        <asp:Label ID="ClienteNombre" runat="server" Enabled="false" Text='<%# Eval("ClienteNombre") %>' />
                                        <asp:Label ID="ClienteID" runat="server" Enabled="false" Visible="false" Text='<%# Eval("ClienteID") %>' />
                                        <asp:Label ID="ClasePlantillaID" runat="server" Enabled="false" Visible="false" Text='<%# Eval("ClasePlantillaID") %>' />
                                        <asp:Label ID="ClaseTipo" runat="server" Visible="false" Enabled="false" Text='<%# Eval("ClaseTipo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Profesor" >
                                    <ItemTemplate>
                                        <asp:Label ID="ProfesorNombre" runat="server" Enabled="false" Text='<%# Eval("ProfesorNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:ButtonField CommandName="reservar" ButtonType="Button" Text='Reservar' HeaderText="Reservar">
                                    <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                </asp:ButtonField>
                            </Columns>
                        </asp:GridView>   
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!-- Add Modal Starts here -->
                <div id="addModal" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h3 id="H1">Agregar Reserva</h3>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <div class="row">
                                                <asp:HiddenField ID="hdfClaseID" runat="server" />
                                                <asp:HiddenField ID="hdfClienteID" runat="server" />
                                                <asp:HiddenField ID="hdfClaseTipo" runat="server" />
                                                <asp:HiddenField ID="hdfClasePlantillaID" runat="server" />
                                                <div class="form-group">
                                                <label class="col-xs-4 control-label">Clase: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtClaseNombreAdd" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Unidad: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtUnidadAdd" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Fecha: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtFechaAdd" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>    
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Hora: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox runat="server" ID="txtHoraAdd" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Profesor: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox runat="server" ID="txtProfesorAdd" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Alumno: </label>
                                                <div class="col-xs-6">
                                                    <div class="col-xs-8">
                                                        <asp:HiddenField ID="txtUsuarioIDAdd" runat="server" />
                                                        <asp:TextBox ID="txtUsuarioNombreAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                                    </div> 
                                                    <div class="col-xs-4">   
                                                        <asp:Button ID="btnBuscar" CssClass="btn btn-purple" runat="server" OnClick="btnBuscar_Click" Text="Buscar" />
                                                    </div>                                                            
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Label ID="Label3" Visible="false" runat="server"></asp:Label>
                                        <asp:Button ID="btnAdd" runat="server" Text="Agregar" CssClass="btn btn-purple"  OnClick="btnAdd_Click"/>
                                        <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
                <!-- Add Modal Ends here -->
                <!-- Buscar Modal Starts here -->
                <div id="bscModal" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button id="Button2" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h3 id="H3">Buscar Usuario</h3>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>                                    
                                    <asp:GridView ID="GridView2" runat="server" Width="95%" HorizontalAlign="Center"
                                        AutoGenerateColumns="false" AllowPaging="true"
                                        CssClass="table table-hover table-striped" PageSize="20"
                                        OnRowCommand="GridView2_RowCommand" 
                                        EmptyDataText="No existen Usuarios..."
                                        onpageindexchanging="GridView2_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Alumno" HeaderStyle-CssClass="text-center">
                                                <ItemTemplate>
                                                    <asp:Label ID="UsuarioNombreB" runat="server" Enabled="false" Text='<%# Eval("Nombre") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>                                            
                                            <asp:TemplateField HeaderText="Cedula" HeaderStyle-CssClass="text-center">
                                                <ItemTemplate>
                                                    <asp:Label ID="UsuarioCedulaB" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="UsuarioIDB" runat="server" Enabled="false" Text='<%# Eval("UsuarioID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:ButtonField CommandName="selectRecord" ButtonType="Button" Text="Seleccionar" HeaderText="Seleccionar">
                                                <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                            </asp:ButtonField>
                                                                   
                                        </Columns>
                                    </asp:GridView>
                                    <div class="modal-footer">
                                        <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
                <!-- BUscar Modal Ends here -->
            </div>
        </div>
        <!-- Fin del Contenido -->  
    </div><!-- /. PAGE Inner  -->
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
        $('#txtBuscar').datepicker({ format: 'dd/mm/yyyy' });
    });
</script>
    </form>
</body>
</html>
