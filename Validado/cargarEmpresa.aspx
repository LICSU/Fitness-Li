﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cargarEmpresa.aspx.cs" Inherits="LicsuWeb.Validado.cargarEmpresa" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Cargar Empleados</title>
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
                <h2 class="pull-left">Cargar Empleados</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
    <!-- Contenido -->  
        <div class="form-group">
            <asp:Label ID="lblPlan" runat="server" AssociatedControlID="dplUnidad" CssClass="col-sm-3 control-label">Unidad de Negocio:</asp:Label>     
            <div class="col-sm-5 selectContainer">
                <asp:DropDownList runat="server" ID="dplUnidad" CssClass="form-control"></asp:DropDownList>
                </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label1" runat="server"  CssClass="col-sm-3 control-label">Cargar Plantilla de Empleados:</asp:Label>     
            <div class="col-sm-5 selectContainer">
                <asp:FileUpload ID="plantillaEmpleados" runat="server" CssClass="btn" />   
                    <asp:RegularExpressionValidator id="RegularExpressionValidator1"
                        runat="server" ErrorMessage="Solo Archivos .CSV"
                        ValidationExpression ="^.+(.CSV|.csv)$"
                        ControlToValidate="plantillaEmpleados"> 
                    </asp:RegularExpressionValidator>
             </div>
            <div class="col-sm-3 selectContainer">
                <asp:Button ID="btnCargarPlantilla" CssClass="btn" runat="server" Text="Cargar Empleados"  OnClick="btnCargarPlantilla_Click" />
             </div>
        </div>
       
        <asp:UpdatePanel ID="upCrudGrid" runat="server">
            <ContentTemplate>
                <div class="col-lg-12">
                    <div class="form-group">
                        <label class="control-label col-xs-3">Buscar: </label>
                        <div class="col-xs-5">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Texto"></asp:TextBox>
                        </div>
                        <div class="col-xs-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
                <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                    AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="EmpleadoID" CssClass="footable" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" EmptyDataText="No existen Empleados Cargados">
                    <Columns>
                    <asp:ButtonField CommandName="editRecord"
                        ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Mod">
                        <ControlStyle ></ControlStyle>
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="deleteRecord"
                        ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                        <ControlStyle ></ControlStyle>
                    </asp:ButtonField>
                    <asp:TemplateField HeaderText="Cédula" >
                        <ItemTemplate>
                            <asp:Label Visible="false" runat="server"  ID="EmpleadoNivel1" Text='<%# Eval("EmpleadoNivel1") %>' />
                            <asp:Label Visible="false" runat="server"  ID="EmpleadoNivel2" Text='<%# Eval("EmpleadoNivel2") %>' />
                            <asp:Label Visible="false" runat="server"  ID="EmpleadoNivel3" Text='<%# Eval("EmpleadoNivel3") %>' />
                            <asp:Label Visible="false" runat="server"  ID="EmpleadoEmail" Text='<%# Eval("EmpleadoEmail") %>' />
                            <asp:Label Visible="false" runat="server"  ID="EmpleadoNivel4" Text='<%# Eval("EmpleadoNivel4") %>' />
                            <asp:Label Visible="false" runat="server"  ID="EmpleadoID" Text='<%# Eval("EmpleadoID") %>' />
                            <asp:Label ID="EmpleadoCedula" runat="server" Enabled="false" Text='<%# Eval("EmpleadoCedula") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                            <asp:Label ID="EmpleadoNombre" runat="server" Enabled="false" Text='<%# Eval("EmpleadoNombre") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cargo" >
                        <ItemTemplate>
                            <asp:Label ID="EmpleadoCargo" runat="server" Enabled="false" Text='<%# Eval("EmpleadoCargo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha de Ingreso" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="EmpleadoFechaIng" runat="server" Enabled="false" Text='<%# Eval("EmpleadoFechaIng") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Empresa">
                        <ItemTemplate>
                            <asp:Label ID="ClienteNombre" runat="server" Enabled="false" Text='<%# Eval("ClienteNombre") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>                  
                </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    <!-- Edit Modal Starts here -->
    <div id="editModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="editModalLabel">Modificar Empleado</h3>
                                            
                </div>
                <asp:UpdatePanel ID="upEdit" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <div class="row">
                                <asp:HiddenField ID="hdfEmpleadoIDEdit" runat="server" /> 
                                    <div class="form-group">
                                    <label class="col-xs-4 control-label">Cédula: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtCedulaEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">Nombre(s): </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>     
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">Cargo: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtCargoEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>  
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">Nivel 1: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtNivel1Edit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>  
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">Nivel 2: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtNivel2Edit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>  
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">Nivel 3: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtNivel3Edit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>  
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">NIvel 4: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox ID="txtNivel4Edit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                    </div>
                                    <div class="col-xs-4"></div>
                                </div>    
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">Email: </label>
                                    <div class="col-xs-6">
                                        <asp:TextBox runat="server" ID="txtEmailEdit" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
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
                    <h3 id="delModalLabel">Eliminar Empleado</h3>
                </div>
                <asp:UpdatePanel ID="upDel" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            ¿Seguro desea eliminar este registro?
                            <asp:HiddenField ID="hdfEmpleadoIDDel" runat="server" />
                                                    
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

    $(document).ready(function () {
        $('#btnCargarPlantilla').on('click', function () {
            $('#pleaseWaitDialog').modal('show');
        });
    });
</script>
    </form>
</body>
</html>