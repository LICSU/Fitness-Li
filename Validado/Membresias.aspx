<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Membresias.aspx.cs" Inherits="LicsuWeb.Validado.Membresias" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Matricula</title>
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
            <h2 class="pull-left">Matricula</h2>
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
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Cédula"></asp:TextBox>
                        </div>
                        <div class="col-lg-2 col-xs-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                        
                        </div>
                        <div class="col-lg-2 col-xs-8">&nbsp;</div>
                        <div class="col-lg-1 col-xs-2">
                            <asp:ImageButton ID="Add" runat="server" ImageUrl="~/Images/agregar.png" OnClick="Add_Click" />
                        </div>
                        <div class="col-lg-1 col-xs-2 text-right">                                                
                            <asp:ImageButton ID="ImgbtnArchivo" runat="server" ImageUrl="~/Images/descargar.png" OnClick="ImgbtnArchivo_Click" />
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
                <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                    OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="BonoID" CssClass="footable" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging"
                    EmptyDataText="No existen Matricula Agregadas">
                    <Columns>     
                        <asp:ButtonField CommandName="editRecord"
                            ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Mod">
                            <ControlStyle ></ControlStyle>
                        </asp:ButtonField>              
                        <asp:ButtonField CommandName="deleteRecord"
                            ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                            <ControlStyle ></ControlStyle>
                        </asp:ButtonField>
                        <asp:TemplateField HeaderText="Número">
                            <ItemTemplate>
                                <asp:Label ID="MembresiaID" Visible="false" runat="server" Enabled="false" Text='<%# Eval("MembresiaID") %>' />                                
                                <asp:Label ID="MembresiaDocumento" runat="server" Enabled="false" Text='<%# Eval("MembresiaDocumento") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cédula">
                            <ItemTemplate>
                                <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Usuario">
                            <ItemTemplate>
                                <asp:Label ID="UsuarioNombres" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombres") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Fecha Inicio">
                            <ItemTemplate>
                                <asp:Label ID="MembresiaFechaInicio" runat="server" Enabled="false" Text='<%# Eval("FechaInicio") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fecha Fin">
                            <ItemTemplate>
                                <asp:Label ID="MembresiaFechaFin" runat="server" Enabled="false" Text='<%# Eval("FechaFin") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pago">
                            <ItemTemplate>
                                <asp:Label ID="MembresiaPago" runat="server" Enabled="false" Text='<%# Eval("MembresiaPago") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>                                                            
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="ImgbtnArchivo" />
            </Triggers>
        </asp:UpdatePanel>
        <!-- Add Modal Starts here -->
        <div id="addModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="H1">Agregar Matricula</h3>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <asp:HiddenField runat="server" ID="hdfUsuarioID" />
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Usuario: </label>
                                        <div class="col-xs-6">
                                            <div class="col-xs-8" style="padding:0;">
                                                <asp:TextBox ID="txtUsuario" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Cedula"></asp:TextBox>
                                            </div>
                                            <div class="col-xs-4" style="padding:0; text-align:right;">
                                                <asp:Button ID="BuscarUsr" runat="server" Text="Buscar" CssClass="btn btn-purple"  OnClick="BuscarUsr_Click"/> 
                                            </div>
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div> 
                                   <div class="form-group">
                                        <label class="col-xs-4 control-label">Número de Documento: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtMembresiaDoc" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Pago:</label>
                                        <div class="col-xs-6">
                                            <asp:TextBox runat="server" ID="txtMembresiaPago" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                            
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>                                    
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Fecha de Inicio: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtFechaInicio" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Fecha Final: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtFechaFin" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
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
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img src="../Images/cargando2.gif" class="img-responsive center-block"><br />
                                <h5 class="text-center">Espere por Favor..</h5>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
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
                                <asp:TemplateField HeaderText="Nombre" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioNombreB" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                        <asp:HiddenField ID="UsuarioIDB" runat="server" Value='<%# Eval("UsuarioID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Apellido" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioApellidoB" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cedula" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioCedulaB" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Empresa" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="ClienteNombreB" runat="server" Enabled="false" Text='<%# Eval("ClienteNombre") %>' />
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
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <img src="../Images/cargando2.gif" class="img-responsive center-block"><br />
                            <h5 class="text-center">Espere por Favor..</h5>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
        </div>
    </div>
    <!-- BUscar Modal Ends here -->
    <!-- Edit Modal Starts here -->
    <div id="editModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="editModalLabel">Editar Matricula</h3>                                            
                </div>
                <asp:UpdatePanel ID="upEdit" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-xs-2"></div>
                                    <asp:HiddenField runat="server" ID="hdfMembresiaID" />
                                    <label class="col-xs-2 control-label">Cédula: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox Enabled="false" ID="txtCedulaEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-2"></div>
                                </div>
                                <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Nombres: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombresEdit" Enabled="false" CssClass="form-control" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                      
                                        </div>
                                        <div class="col-xs-2"></div>
                                    </div> 
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Número de Documento: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtDocumentoEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Pago:</label>
                                        <div class="col-xs-6">
                                            <asp:TextBox runat="server" ID="txtPagoEdit" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                            
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>   
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Fecha Inicio: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtFechaInicioEdit" CssClass="form-control" placeholder="dd/mm/yyyy" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                      
                                        </div>
                                        <div class="col-xs-2"></div>
                                    </div> 
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Fecha Final: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtFechaFinEdit" CssClass="form-control" placeholder="dd/mm/yyyy" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                      
                                        </div>
                                        <div class="col-xs-2"></div>
                                    </div>          
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Label ID="lblResult" Visible="false" runat="server"></asp:Label>
                            <asp:Button ID="btnSave" runat="server" Text="Modificar" CssClass="btn btn-purple" OnClick="btnSave_Click" />
                            <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                    <ProgressTemplate>
                        <h4 class="text-info">Guardando..</h4><br />
                        <img src="img/loading.gif" class="img-responsive center-block"><br />
                        <h4 class="text-info">Espere Por Favor</h4>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
        </div>
    </div>
    <!-- Edit Modal Ends here --> 
        <!-- Delete Record Modal Starts here-->
        <div id="deleteModal"  class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeDelete" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="delModalLabel">Eliminar Matricula</h3>
                    </div>
                    <asp:UpdatePanel ID="upDel" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                ¿Seguro desea eliminar este registro?
                                <asp:HiddenField runat="server" ID="hdfMembresiaIDEli" />
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnDelete" runat="server" Text="Eliminar" CssClass="btn btn-purple" OnClick="btnDelete_Click" />
                                <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cancelar</button>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <!--Delete Record Modal Ends here -->
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
