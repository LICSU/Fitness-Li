﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="configurarParametro.aspx.cs" Inherits="LicsuWeb.Validado.configurarParametro" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Configurar Parámetros</title>
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
                <h2 class="pull-left">Configurar Parámetros</h2>

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
        <asp:UpdatePanel ID="upCrudGrid" runat="server">
            <ContentTemplate>
                <div class="col-lg-12">
                    <div class="form-group">
                        <label class="control-label col-xs-3">Buscar: </label>
                        <div class="col-xs-5">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Empresa"></asp:TextBox>
                        </div>
                        <div class="col-xs-4">
                            <asp:Button ID="Agregar" runat="server" Text="Agregar"  CssClass="btn btn-purple"  OnClick="Agregar_Click"/>
                        </div>
                    </div>
                </div>
                <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                    OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="idParametro" CssClass="table table-hover table-striped" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No existen Parámetros Configurados.">
                    <Columns>
                        <asp:ButtonField CommandName="viewRecord"
                            ButtonType="Button" Text="V" HeaderText="Ver">
                            <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="editRecord"
                            ButtonType="Button" Text="M" HeaderText="Mod">
                            <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="deleteRecord"
                            ButtonType="Button" Text="E" HeaderText="Eli">
                            <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                        </asp:ButtonField>
                        <asp:TemplateField HeaderText="" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="idParametro" runat="server" Enabled="false" Text='<%# Eval("idParametro") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="labelParametro" runat="server" Enabled="false" Text='<%# Eval("labelParametro") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tipo" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="tipoParametro" runat="server" Enabled="false" Text='<%# Eval("tipoParametro") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="labelIdParametro" runat="server" Enabled="false" Text='<%# Eval("labelIdParametro") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tipo">
                            <ItemTemplate>
                                <asp:Label ID="nombreTipoParametro" runat="server" Enabled="false" Text='<%# Eval("nombreTipoParametro") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>                                            
                        <asp:TemplateField HeaderText="Activo">
                            <ItemTemplate>
                                <asp:CheckBox ID="activoParametro" runat="server" Enabled="false" Checked='<%# Eval("activoParametro") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField HeaderText="Cliente" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="ClienteID" runat="server" Enabled="false" Text='<%# Eval("ClienteID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Unidad">
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
        <!-- Add Modal Starts here -->
        <div id="addModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="H1">Agregar Parámetro</h3>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                        <div class="form-group">
                                        <label class="col-xs-4 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombrePar" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Tipo: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplTipoPar" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>   
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">ID: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="labelIdPar" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>  
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Observación: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtObservacionPar" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Activo: </label>
                                        <div class="col-xs-6">
                                            <asp:CheckBox runat="server" ID="chkActivoPar" ClientIDMode="Static" CssClass="checkbox"></asp:CheckBox> 
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>     
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Unidad de Negocio: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplUnidad" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
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
            <!-- Edit Modal Starts here -->
        <div id="editModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="editModalLabel">Modificar Parámetro</h3>
                                            
                    </div>
                    <asp:UpdatePanel ID="upEdit" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                        <div class="form-group">
                                        <label class="col-xs-4 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Tipo: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplTipoParEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>     
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Observación: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtObserEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Activo: </label>
                                        <div class="col-xs-6">
                                            <asp:CheckBox runat="server" ID="chkActivoEdit" ClientIDMode="Static" CssClass="checkbox"></asp:CheckBox> 
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>     
                                    <div class="form-group">
                                        <label class="col-xs-4 control-label">Unidad de Negocio: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplUnidadEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
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
                        <h3 id="delModalLabel">Eliminar Parámetro</h3>
                    </div>
                    <asp:UpdatePanel ID="upDel" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                ¿Seguro desea eliminar este parámetro?
                                <asp:HiddenField ID="hClienteDel" runat="server" />
                                                    
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnDelete" runat="server" Text="Eliminar" CssClass="btn btn-purple" OnClick="btnDelete_Click" />
                                <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cancelar</button>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <!--Delete Record Modal Ends here -->
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