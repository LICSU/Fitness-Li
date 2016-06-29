<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Asistencias.aspx.cs" Inherits="LicsuWeb.Validado.Asistencias" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Asistencias</title>
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
                <h2 class="pull-left">Asistencias</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
        <div class="col-md-12">

            <div class="row placeholders">
            <div style="width: 90%; margin-right: 5%; margin-left: 2%; text-align: center">
                <asp:UpdatePanel ID="upCrudGrid" runat="server">
                    <ContentTemplate> 
                        <div class="row">
                            <div class="col-lg-1"></div>
                                <div class="col-lg-6 col-xs-8">
                                    <asp:DropDownList ID="dplEstado" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="" Text="Seleccione un Valor"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Asistió"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="No Asistió"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-4 col-xs-4">
                                    <asp:Button ID="btnBuscarEstado" runat="server" Text="Buscar por Estado"  CssClass="btn btn-purple" OnClick="btnBuscarEstado_Click" />                                                                                        
                                </div>
                            <div class="col-lg-1"></div>
                        </div>  
                        <br />
                        <div class="row">
                            <div class="col-lg-1"></div>
                                <div class="col-lg-6 col-xs-8">
                                    <asp:TextBox ID="txtBuscarUsuario" runat="server" CssClass="form-control" placeholder="Cédula"></asp:TextBox>
                                </div>
                                <div class="col-lg-4 col-xs-4">
                                    <asp:Button ID="btnBuscarUsuario" runat="server" Text="Buscar por Usuario"  CssClass="btn btn-purple" OnClick="btnBuscarUsuario_Click" />                                                                                        
                                </div>
                            <div class="col-lg-1"></div>
                        </div>         
                        <br />       
                        <div class="row">
                            <div class="col-lg-1"></div>
                            <div class="col-lg-10">
                                <div class="col-lg-6 col-xs-8">
                                    <asp:TextBox ID="txtBuscarClase" runat="server" CssClass="form-control" placeholder="Clase"></asp:TextBox>
                                </div>
                                <div class="col-lg-2 col-xs-4">
                                    <asp:Button ID="Button1" runat="server" Text="Buscar por Clase"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                        
                                </div>
                                <div class="col-lg-2 col-xs-8">&nbsp;</div>
                                <div class="col-lg-1 col-xs-2">
                                    <asp:ImageButton ID="Add" runat="server" ImageUrl="~/Images/agregar.png" OnClick="Agregar_Click" />
                                </div>
                                <div class="col-lg-1 col-xs-2 text-right">                                                
                                    <asp:ImageButton ID="ImgbtnArchivo" runat="server" ImageUrl="~/Images/descargar.png" OnClick="btnArchivo_Click" />
                                </div>
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                        
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="ClaseAsistenciaID" CssClass="table table-hover table-striped" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No existen Asistencias Registradas">
                            <Columns>
                                            
                                <asp:ButtonField CommandName="editRecord" ButtonType="Button" Text="M" HeaderText="Mod">
                                    <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                </asp:ButtonField>
                                <asp:ButtonField CommandName="deleteRecord" ButtonType="Button" Text="E" HeaderText="Eli">
                                    <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="AsitenciaID" runat="server" Enabled="false" Text='<%# Eval("ClaseAsistenciaID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Apellido">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioApellido" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cédula">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Clase">
                                    <ItemTemplate>
                                        <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Fecha">
                                    <ItemTemplate>
                                        <asp:Label ID="FechaClase" runat="server" Enabled="false" Text='<%# Eval("FechaClase") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:TemplateField HeaderText="Hora">
                                    <ItemTemplate>
                                        <asp:Label ID="HoraClase" runat="server" Enabled="false" Text='<%# Eval("HoraClase") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Asistió">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="ClaseAsist" runat="server" Enabled="false" Checked='<%# Eval("ClaseAsist") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>                                  
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="ImgbtnArchivo" />
                    </Triggers>
                </asp:UpdatePanel>                            
            </div>
            </div>
        </div>
        <!-- Contenido ...FIN... --> 
        <!-- Add Modal Starts here -->
        <div id="addModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="H1">Agregar Asistencia</h3>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                   <div class="form-group">
                                        <label class="col-xs-4 control-label">Clase: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList OnSelectedIndexChanged="dplClases_SelectedIndexChanged" CssClass="form-control" runat="server" ID="dplClases" AutoPostBack="true"></asp:DropDownList>                                                              
                                        </div>
                                    </div>              
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Label ID="Label3" Visible="false" runat="server"></asp:Label>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <!-- Add Modal Ends here -->
        <!-- Edit Modal Starts here -->
        <div id="editModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="editModalLabel">Modificar Asistencia</h3>                                            
                    </div>
                    <asp:UpdatePanel ID="upEdit" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <asp:HiddenField ID="hAsistenciaMod" runat="server" /> 
                                        <div class="form-group">
                                        <label class="col-xs-4 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreEdit" runat="server"  Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Apellido: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtApellidoEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div> 
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Cédula: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCedulaEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>     
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Clase: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtClaseEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Fecha: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox runat="server" ID="txtFechaEdit" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>     
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Hora: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtHoraEdit" runat="server" ClientIDMode="Static" Enabled ="false" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Asistió: </label>
                                        <div class="col-xs-6">
                                            <asp:CheckBox ID="chkAsistioEdit" runat="server" ClientIDMode="Static"  CssClass="checkbox"></asp:CheckBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
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
                            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
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
                        <h3 id="delModalLabel">Eliminar Cliente</h3>
                    </div>
                    <asp:UpdatePanel ID="upDel" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                ¿Seguro desea eliminar este registro?
                                <asp:HiddenField ID="hAsitenciaDel" runat="server" />
                                                    
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