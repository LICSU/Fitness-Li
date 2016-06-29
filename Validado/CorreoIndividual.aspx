<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CorreoIndividual.aspx.cs" Inherits="LicsuWeb.Validado.CorreoIndividual" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Correo Individual</title>
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
                <h2 class="pull-left">Correo Individual</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
       <!-- Contenido ...INICIO...-->
        <div class="col-md-12">                
                    <div class="modal-body">
                        <div class="row">
                        <asp:UpdatePanel ID="upCrudGrid" runat="server" UpdateMode="Always" >
                        <ContentTemplate>
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Destinatario: </label>                                    
                                <div class="col-xs-4">
                                    <asp:TextBox  ID="txtDestinatario" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                                                  
                                </div>
                                <div class="col-xs-2 text-right"> 
                                    <asp:Button ID="BuscarUsr" runat="server" Text="Buscar Email" CssClass="btn btn-purple"  OnClick="BuscarUsr_Click"/>                                                             
                                </div>
                            </div>                              
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Asunto: </label>
                                <div class="col-xs-6">
                                    <asp:TextBox ID="txtAsunto" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                </div>
                            </div>                                 
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Mensaje: </label>
                                <div class="col-xs-6">
                                    <asp:TextBox ID="txtMensaje" TextMode="MultiLine" Rows="10" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                </div>
                            </div> 
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                          <img src="img/loading.gif" class="img-responsive center-block">
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Adjunto: </label>
                                <div class="col-xs-6">                         
                                    <asp:FileUpload ID="fipAdjuntos" CssClass="btn btn-default btn-file" runat="server"   /> 
                                    <br /><asp:Label runat="server" ID="lblArchivo" CssClass="label"></asp:Label>                                                               
                                </div>
                            </div>
                                                
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Label ID="Label1" Visible="false" runat="server"></asp:Label>
                        <asp:Button ID="Button1" runat="server" Text="Enviar" CssClass="btn btn-purple" OnClick="btnEnviar_Click" />
                        <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                    </div>               
        </div>
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
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Apellido" HeaderStyle-CssClass="text-center">
                                            <ItemTemplate>
                                                <asp:Label ID="UsuarioApellidoB" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Correo" HeaderStyle-CssClass="text-center">
                                            <ItemTemplate>
                                                <asp:Label ID="UsuarioCorreo" runat="server" Enabled="false" Text='<%# Eval("UsuarioCorreo") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Empresa" HeaderStyle-CssClass="text-center">
                                            <ItemTemplate>
                                                <asp:Label ID="ClienteNombreB" runat="server" Enabled="false" Text='<%# Eval("ClienteNombre") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="UsuarioIDB" runat="server" Enabled="false" Text='<%# Eval("UsuarioID") %>' />
                                                <asp:Label ID="SucursalIDB" runat="server" Enabled="false" Text='<%# Eval("SucursalID") %>' />
                                                <asp:Label ID="ClienteIDB" runat="server" Enabled="false" Text='<%# Eval("ClienteID") %>' />
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
            <!-- Contenido ...FIN... --> 
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
</script>
    </form>
</body>
</html>