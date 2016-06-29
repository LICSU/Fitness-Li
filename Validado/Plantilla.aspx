<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Plantilla.aspx.cs" Inherits="LicsuWeb.Validado.Plantilla" EnableEventValidation="false" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Cargar Plantilla</title>
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
                <h2 class="pull-left">Cargar Plantilla</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
    <!-- Contenido -->  
   
<div class="form-horizontal">

<!-- Contenido ...INICIO...-->
<div class="col-md-12">
    <div class="row placeholders">
        <div class="row">
            <div class="col-lg-2"></div>
            <div class="col-lg-4 col-xs-5">
                <asp:FileUpload ID="plantillaExcel" runat="server" CssClass="btn" />   
                <asp:RegularExpressionValidator id="RegularExpressionValidator1"
                    runat="server" ErrorMessage="Solo Archivos TXT"
                    ValidationExpression ="^.+(.CSV|.csv)$"
                    ControlToValidate="plantillaExcel"> </asp:RegularExpressionValidator>
            </div>
            <div class="col-lg-4 col-xs-4">
                <asp:Button ID="btnCargarPlantilla" CssClass="btn" runat="server" Text="Cargar Plantilla"  OnClick="btnCargarPlantilla_Click" />
            </div>    
            <div class="col-lg-2"></div>
        </div>
        <asp:UpdatePanel ID="upCrudGrid" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-9">
                        <div class="col-lg-6 col-xs-8">
                            <input id="txtBuscar" runat="server" class="form-control" placeholder="dd/mm/yyyy" />
                        </div>
                        <div class="col-lg-2 col-xs-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                        
                        </div>
                        <div class="col-lg-2 col-xs-8">&nbsp;</div>
                        <div class="col-lg-2 col-xs-2 text-right"> 
                            <asp:ImageButton ID="ImgbtnArchivo" runat="server" ImageUrl="~/Images/descargar.png"  OnClick="btnArchivo_Click" />
                        </div>
                      </div>
                    <div class="col-lg-1"></div>
                </div>
                <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                    AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="ClasePlantillaID" CssClass="footable" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                    EmptyDataText="No Existen Clases Cargadas">
                    <Columns>
                        <asp:ButtonField CommandName="editRecord"
                            ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Mod">
                            <ControlStyle ></ControlStyle>
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="deleteRecord"
                            ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                            <ControlStyle ></ControlStyle>
                        </asp:ButtonField>
                        <asp:TemplateField HeaderText="Clase" >
                            <ItemTemplate>
                                <asp:Label runat="server" Visible="false"  ID="ProfesorID" Text='<%# Eval("ProfesorID") %>' />
                                <asp:Label runat="server" Visible="false"  ID="ClasePlantillaID" Text='<%# Eval("ClasePlantillaID") %>' />
                                <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Día">
                            <ItemTemplate>
                                <asp:Label ID="ClasePlantillaFecha" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaFecha") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hora" >
                            <ItemTemplate>
                                <asp:Label ID="ClasePlantillaHora" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaHora") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cupos" >
                            <ItemTemplate>
                                <asp:Label ID="ClasePlantillaCupo" runat="server" Enabled="false" Text='<%# Eval("ClasePlantillaCupo") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Profesor" >
                            <ItemTemplate>
                                <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Empresa">
                            <ItemTemplate>
                                <asp:Label ID="ClienteDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClienteDescripcion") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Salon">
                            <ItemTemplate>
                                <asp:Label ID="SalonNombre" runat="server" Enabled="false" Text='<%# Eval("SalonNombre") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Activa" Visible="false">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkActiva" runat="server" Enabled="false" Checked='<%# Eval("ClasePlantillaActiva") %>' />
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
<!-- Fin del Contenido -->  
<!-- Edit Modal Starts here -->
        <div id="editModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="editModalLabel">Modificar Plantilla</h3>                                            
                    </div>
                    <asp:UpdatePanel ID="upEdit" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <asp:HiddenField ID="hClaseMod" runat="server" /> 
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Fecha: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtFechaEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div> 
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Hora: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtHoraEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Cupo: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCupoEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Nombre Profesor: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplProfesor" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                            <!--<asp:TextBox ID="txtNombrePEdit"  runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>   -->                                                             
                                        </div>
                                    </div>   
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Empresa: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtEmpresaEdit" Enabled="false" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                    </div>  
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Activa: </label>
                                        <div class="col-xs-6">
                                            <asp:CheckBox ID="chkActivaEdit" runat="server" ClientIDMode="Static" CssClass="checkbox"></asp:CheckBox>                                                                
                                        </div>
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
                    <h3 id="delModalLabel">Eliminar Clase</h3>
                </div>
                <asp:UpdatePanel ID="upDel" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            ¿Seguro desea eliminar este registro?
                            <asp:HiddenField ID="hClaseDel" runat="server" />
                                                    
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

    $(document).ready(function () {
        $('#btnCargarPlantilla').on('click', function () {
            $('#pleaseWaitDialog').modal('show');
        });
    });

    $(document).ready(function () {
        $('#txtBuscar').datepicker({ format: 'dd/mm/yyyy' });
    });
</script>
    </form>
</body>
</html>