﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Planes.aspx.cs" Inherits="LicsuWeb.Validado.Planes" EnableEventValidation="false" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Listar Planes</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-footable/0.1.0/css/footable.min.css" rel="stylesheet" type="text/css" />
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
                <h2 class="pull-left">Listar Planes</h2>

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
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Clase"></asp:TextBox>
                                </div>
                                <div class="col-lg-2 col-xs-4">
                                    <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                        
                                </div>
                                <div class="col-lg-2 col-xs-8">&nbsp;</div>
                                <div class="col-lg-1 col-xs-2">
                                    <asp:ImageButton ID="Add" runat="server" ImageUrl="~/Images/agregar.png" OnClick="btnAdd_Click" />
                                </div>
                                <div class="col-lg-1 col-xs-2 text-right">                                                
                                    <asp:ImageButton ID="ImgbtnArchivo" runat="server" ImageUrl="~/Images/descargar.png" OnClick="btnArchivo_Click" />
                                </div>
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="PlanID" CssClass="footable" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Nombre" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label  ID="PlanNombre" runat="server" Enabled="false" Text='<%# Eval("PlanNombre") %>' />
                                        <asp:Label ID="PlanID" Visible="false" runat="server" Enabled="false" Text='<%# Eval("PlanID") %>' />
                                        <asp:Label  ID="PlanDescripcion" Visible="false" runat="server" Enabled="false" Text='<%# Eval("PlanDescripcion") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fecha de Fin"  Visible="false">
                                    <ItemTemplate>
                                        <asp:Label  ID="PlanFechaFin" runat="server" Enabled="false" Text='<%# Eval("PlanFechaFin") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fecha de Inicio"  Visible="false">
                                    <ItemTemplate>
                                        <asp:Label  ID="PlanFechaInicio" runat="server" Enabled="false" Text='<%# Eval("PlanFechaInicio") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Complementarias" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="clasesComplemen" runat="server" Enabled="false" Text='<%# Eval("clasesComplemen") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Regulares" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="clasesRegulares" runat="server" Enabled="false" Text='<%# Eval("clasesRegulares") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Costo" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="PlanCosto" runat="server" Enabled="false" Text='<%# Eval("PlanCosto") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Activo" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="PlanActivo" runat="server" Enabled="false" Checked='<%# Eval("PlanActivo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:ButtonField CommandName="editRecord"
                                    ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Modificar" HeaderStyle-CssClass="text-center">
                                    <ControlStyle></ControlStyle>
                                </asp:ButtonField> 
                                <asp:ButtonField CommandName="deleteRecord" 
                                    ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eliminar" HeaderStyle-CssClass="text-center">
                                    <ControlStyle></ControlStyle>
                                </asp:ButtonField>                          
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
    <!-- Fin del Contenido -->  
<!-- Add Modal Starts here -->
                <div id="addModal" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h3 id="H1">Agregar Plan</h3>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <div class="row">
                                                <div class="form-group">
                                                <label class="col-xs-4 control-label">Nombre: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtNombreAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Descripción: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtDescripcionAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Fecha Inicio: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtFechaIniAdd" placeholder="dd/mm/yyyy" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>    
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Fecha Fin: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox runat="server" ID="txtFechaFinAdd" placeholder="dd/mm/yyyy" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Activo: </label>
                                                <div class="col-xs-6">
                                                    <asp:CheckBox ID="chkActivoAdd" runat="server" ClientIDMode="Static" CssClass="checkbox"></asp:CheckBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Clases Complementarias: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="clasesComplemenAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Clases Regulares: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="clasesRegularesAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Costo: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtCostoAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Label ID="Label3" Visible="false" runat="server"></asp:Label>
                                        <asp:Button ID="btnAdd" runat="server" Text="Agregar" CssClass="btn btn-purple"  OnClick="btnAgregar_Click"/>
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
                                <h3 id="H2">Editar Plan</h3>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <div class="row">
                                            <asp:HiddenField ID="hPlanIDEdit" runat="server" /> 
                                                <div class="form-group">
                                                <label class="col-xs-4 control-label">Nombre: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Descripción: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtDescripcionEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Fecha Inicio: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtFechaIniEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>    
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Fecha Fin: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox runat="server" ID="txtFechaFinEdit" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Activo: </label>
                                                <div class="col-xs-6">
                                                    <asp:CheckBox ID="chkActivoEdit" runat="server" ClientIDMode="Static" CssClass="checkbox"></asp:CheckBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Clases Complementarias: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="clasesComplemenEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Clases Regulares: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="clasesRegularesEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Costo: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtCostoEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Label ID="Label1" Visible="false" runat="server"></asp:Label>
                                        <asp:Button ID="Editar" runat="server" Text="Guardar" CssClass="btn btn-purple"  OnClick="Editar_Click"/>
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
                                <h3 id="delModalLabel">Eliminar Plan</h3>
                            </div>
                            <asp:UpdatePanel ID="upDel" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        ¿Seguro desea eliminar este registro?
                                        <asp:HiddenField ID="hPlanDel" runat="server" />
                                                    
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