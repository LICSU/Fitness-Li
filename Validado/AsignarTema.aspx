<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AsignarTema.aspx.cs" Inherits="LicsuWeb.Validado.AsignarTema" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Asignar Tema</title>
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
        <div class="col-md-12">
            <div class="row placeholders">
                <div style="width: 90%; margin-right: 5%; margin-left: 2%; text-align: center">
                    <asp:UpdatePanel ID="upCrudGrid" runat="server">
                        <ContentTemplate>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label class="control-label col-xs-3">Clase(s) Asignada(s): </label>
                                    <div class="col-xs-5">
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="dplClaseProfesor" AutoPostBack="true" OnSelectedIndexChanged="dplClaseProfesor_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                    <div class="col-xs-4">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-xs-3">Buscar: </label>
                                    <div class="col-xs-5">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                                        <asp:Button ID="Agregar" runat="server" Text="Agregar"  CssClass="btn btn-purple"  OnClick="Agregar_Click"/>
                                    </div>
                                </div>
                            </div>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
                            <asp:GridView ID="GridView1" runat="server" Width="80%" HorizontalAlign="Center"
                                OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                                DataKeyNames="NivelID" CssClass="table table-hover table-striped" PageSize="20"
                                onpageindexchanging="GridView1_PageIndexChanging" AllowSorting="true"
                                EmptyDataText="No existen Elementos Agregados">
                                <Columns>                                            
                                    <asp:ButtonField CommandName="editRecord"
                                        ButtonType="Button" Text="M" HeaderText="Mod">
                                        <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                    </asp:ButtonField>
                                    <asp:ButtonField CommandName="deleteRecord"
                                        ButtonType="Button" Text="E" HeaderText="Eli">
                                        <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                    </asp:ButtonField>
                                    <asp:TemplateField HeaderText="ID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="ClaseElemNivID" runat="server" Enabled="false" Text='<%# Eval("ClaseElemNivID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="IDElemento_1" runat="server" Enabled="false" Text='<%# Eval("ElementoID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Clase">
                                        <ItemTemplate>
                                            <asp:Label ID="Clase" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField> 
                                    <asp:TemplateField HeaderText="Nivel">
                                        <ItemTemplate>
                                            <asp:Label ID="Nivel" runat="server" Enabled="false" Text='<%# Eval("NivelNombre") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField> 
                                    <asp:TemplateField HeaderText="Elemento">
                                        <ItemTemplate>
                                            <asp:Label ID="Nombre" runat="server" Enabled="false" Text='<%# Eval("ElementoNombre") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>   
                                    <asp:TemplateField HeaderText="Activo">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Activo" runat="server" Enabled="false" Checked='<%# Eval("ElementoActivo") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>                                                        
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <!-- Add Modal Starts here -->
        <div id="addModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="H1">Agregar Elemento(s)</h3>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Clase: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplClaseAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>  
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Nivel: </label>
                                        <div class="col-xs-6">
                                            <asp:DropDownList ID="dplNivelAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div> 
                                        <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Elementos: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreAdd" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Elemento1,Elemento2"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>  
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Activo: </label>
                                        <div class="col-xs-6">
                                            <asp:CheckBox ID="ActivoAdd" runat="server" CssClass="checkbox" />                                                             
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
                            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"  />
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
                        <h3 id="editModalLabel">Modificar Elemento</h3>
                                            
                    </div>
                    <asp:UpdatePanel ID="upEdit" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <asp:HiddenField ID="hElementoMod" runat="server" /> 
                                        <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div> 
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Activo: </label>
                                        <div class="col-xs-6">
                                            <asp:CheckBox ID="chkActivoEdit" runat="server" CssClass="checkbox" />                                                             
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
                        <h3 id="delModalLabel">Eliminar Elemento</h3>
                    </div>
                    <asp:UpdatePanel ID="upDel" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                ¿Seguro desea eliminar este registro?
                                <asp:HiddenField ID="hElementoID" runat="server" />
                                <asp:HiddenField ID="hClaseElemNivID" runat="server" />
                                                    
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