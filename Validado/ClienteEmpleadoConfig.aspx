<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClienteEmpleadoConfig.aspx.cs" Inherits="LicsuWeb.Validado.ClienteEmpleadoConfig" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cfg. Empleados</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="css/bootstrap.css" rel="stylesheet" />
    <!-- FONTAWESOME STYLES-->
    <link href="css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLES-->
    <link href="css/custom.css" rel="stylesheet" />
    <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>
<body>
<form id="form1" runat="server">
<asp:ScriptManager runat="server" ID="sm1" />
<!--<div id="wrapper">-->
<!-- Encabezado -->
    <uc2:ucEncabezado runat="server" id="ucEncabezado" />
<!-- Menu superior y lateral -->

    <!--  PAGE WRAPPER 
    <div id="page-wrapper" > -->
        <div id="page-inner">
        <!-- Contenido pagina -->
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-4">
                    <h2 class="pull-left">Cfg. Empleados</h2>
                    </div>               
                    <div class="col-md-3 col-md-offset-5">
                        <div class="form-group text-right">
                            <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-default" NavigateUrl="Inicio.aspx"> Regresar</asp:HyperLink>
                        </div>
                    </div>
                </div>

            </div>
             <hr />

    <div class="form-horizontal">

                    <!-- Contenido ...INICIO...-->
                    <div class="col-md-12">

                      <div class="row placeholders">
                        <div style="width: 90%; margin-right: 5%; margin-left: 5%; text-align: center">
                            <asp:UpdatePanel ID="upCrudGrid" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <label class="control-label col-xs-3 ">Buscar: </label>
                                        <div class="col-xs-5">
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Cliente"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-4">
                                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                                            <asp:Button ID="btnAdd" runat="server" Text="Nuevo" CssClass="btn btn-purple" OnClick="btnAdd_Click" />
                                        </div>
                                    </div>
                                    <asp:GridView ID="GridView1" runat="server" Width="940px" HorizontalAlign="Center"
                                        OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                                        DataKeyNames="ClienteID" CssClass="table table-hover table-striped" PageSize="20"
                                        onpageindexchanging="GridView1_PageIndexChanging">
                                        <Columns>
                                            <asp:ButtonField CommandName="editRecord"
                                                ButtonType="Button" Text="M" HeaderText="Mod">
                                                <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="deleteRecord"
                                                ButtonType="Button" Text="E" HeaderText="Eli">
                                                <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:BoundField DataField="ClienteNombre" HeaderText="Cliente" />
                                            <asp:TemplateField HeaderText="Cédula">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCedula" runat="server" Enabled="false" Checked='<%# Eval("Cedula") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cód_Empleado">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCodigoEmpleado" runat="server" Enabled="false" Checked='<%# Eval("CodigoEmpleado") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nombre">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkNombre" runat="server" Enabled="false" Checked='<%# Eval("Nombre") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fec_Ingreso">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkFechaIngreso" runat="server" Enabled="false" Checked='<%# Eval("FechaIngreso") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fec_Egreso">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkFechaEgreso" runat="server" Enabled="false" Checked='<%# Eval("FechaEgreso") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Correo">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCorreo" runat="server" Enabled="false" Checked='<%# Eval("Correo") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Teléfono">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkTelefono" runat="server" Enabled="false" Checked='<%# Eval("Telefono") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Zona">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkZona" runat="server" Enabled="false" Checked='<%# Eval("Zona") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Región">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkRegion" runat="server" Enabled="false" Checked='<%# Eval("Region") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Uni_Negocio">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkUnidadNegocio" runat="server" Enabled="false" Checked='<%# Eval("UnidadNegocio") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Gerencia">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkGerencia" runat="server" Enabled="false" Checked='<%# Eval("Gerencia") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cargo">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCargo" runat="server" Enabled="false" Checked='<%# Eval("Cargo") %>' />
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
                                            <h3 id="editModalLabel">Modificar</h3>
                                        </div>
                                        <asp:UpdatePanel ID="upEdit" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <asp:HiddenField ID="hClienteIDMod" runat="server" />
                                                        <asp:PlaceHolder ID="phCedulaMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Cédula: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCedulaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCodigoEmpleadoMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>                                                            
                                                            <label class="col-xs-4 control-label">Código Empleado: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCodigoEmpleadoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phNombreMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label  class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkNombreMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaIngresoMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <asp:Label ID="lblFechaIngresoMod" runat="server" AssociatedControlID="chkFechaIngresoMod" CssClass="col-xs-4 control-label">Fecha Ingreso:</asp:Label>     
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkFechaIngresoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />                               
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaEgresoMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <asp:Label ID="lblFechaEgresoMod" runat="server" AssociatedControlID="chkFechaEgresoMod" CssClass="col-xs-4 control-label">Fecha Egreso:</asp:Label>     
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkFechaEgresoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />                               
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCorreoMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Correo: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCorreoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phTelefonoMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Teléfono: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkTelefonoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phZonaMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Zona: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkZonaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phRegionMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Región: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkRegionMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phUnidadNegocioMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Unidad de Negocio: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkUnidadNegocioMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phGerenciaMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Gerencia: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkGerenciaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCargoMod" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Cargo: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCargoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
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
                            <!-- Add Record Modal Starts here-->
                            <div id="addModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="addModalLabel">Nuevo</h3>
                                        </div>
                                        <asp:UpdatePanel ID="upAdd" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <asp:PlaceHolder ID="phCedulaNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Cédula: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCedulaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCodigoEmpleadoNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>                                                            
                                                            <label class="col-xs-4 control-label">Código Empleado: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCodigoEmpleadoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phNombreNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label  class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkNombreNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaIngresoNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <asp:Label ID="lblFechaIngresoNue" runat="server" AssociatedControlID="chkFechaIngresoNue" CssClass="col-xs-4 control-label">Fecha Ingreso:</asp:Label>     
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkFechaIngresoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />                               
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaEgresoNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <asp:Label ID="lblFechaEgresoNue" runat="server" AssociatedControlID="chkFechaEgresoNue" CssClass="col-xs-4 control-label">Fecha Egreso:</asp:Label>     
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkFechaEgresoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />                               
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCorreoNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Correo: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCorreoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phTelefonoNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Teléfono: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkTelefonoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phZonaNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Zona: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkZonaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phRegionNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Región: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkRegionNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phUnidadNegocioNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Unidad de Negocio: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkUnidadNegocioNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phGerenciaNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Gerencia: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkGerenciaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCargoNue" runat="server">
                                                        <div class="form-group">
                                                            <div class="col-xs-2"></div>
                                                            <label class="col-xs-4 control-label">Cargo: </label>
                                                            <div class="col-xs-2">
                                                                <asp:CheckBox ID="chkCargoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">                          
                                                    <asp:Button ID="btnAddRecord" runat="server" Text="Agregar" CssClass="btn btn-purple" OnClick="btnAddRecord_Click" />
                                                    <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnAddRecord" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <!--Add Record Modal Ends here-->
                            <!-- Delete Record Modal Starts here-->
                            <div id="deleteModal"  class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeDelete" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="delModalLabel">Eliminar</h3>
                                        </div>
                                        <asp:UpdatePanel ID="upDel" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    ¿Seguro desea eliminar este registro?
                                                    <asp:HiddenField ID="hfCedula" runat="server" />
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:Button Enabled="false" ID="btnDelete" runat="server" Text="Eliminar" CssClass="btn btn-purple" OnClick="btnDelete_Click" />
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
                    <!-- Contenido ...FIN... -->

    </div> 
        </div>
        <!-- /. PAGE Inner  -->
<!--     </div> -->
 <!--/. PAGE WRAPPER  -->
    
 <footer class="footer"> <p>Copyright (c) LICSU 2015</p> </footer>
      <!-- JQUERY SCRIPTS -->
    <script src="js/jquery-1.10.2.js"></script>
      <!-- BOOTSTRAP SCRIPTS -->
    <script src="js/bootstrap.min.js"></script>
      <!-- METISMENU SCRIPTS -->
    <script src="js/jquery.metisMenu.js"></script>
      <!-- CUSTOM SCRIPTS -->
    <script src="js/custom.js"></script>
<!--</div>-->
<!--/. WRAPPER 

    <!---------------------------------- Modals --------------------------------->
    <!-- Modal Error -->
    <div class="modal fade" id="modalError" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4  class="modal-title">Error</h4>
          </div>
          <div class="modal-body">
            <div class="row">
                <div class="col-md-1">
                    <span class="fa fa-times fa-2x text-danger"></span>
                </div>
                <div class="col-md-11">
                    <label  id="lblMsjModalError"></label>
                </div>
            </div>
            <div class="clearfix"></div>
          </div><!-- /modal-body -->
          <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
          </div>
        </div> 
      </div>
    </div> 

    <!-- Modal Exito -->
    <div class="modal fade" id="modalExito" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4  class="modal-title">Éxito</h4>
          </div>
          <div class="modal-body">
            <div class="row">
                <div class="col-md-1">
                    <span class="fa fa-check fa-2x text-success"></span>
                </div>
                <div class="col-md-11">
                    <label id="lblMsjModalExito"></label>
                </div>
            </div>
            <div class="clearfix"></div>      
          </div><!-- /modal-body -->
          <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
          </div>
        </div> 
      </div>
    </div>

    <!-- Modal Informacion -->
    <div class="modal fade" id="modalInformacion" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4  class="modal-title">Información</h4>
          </div>
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-1">
                        <span class="fa fa-check fa-2x text-info"></span>
                    </div>
                    <div class="col-md-11">
                        <label id="lblMsjModalInformacion"></label>
                    </div>
                </div>
                <div class="clearfix"></div>      
          </div><!-- /modal-body -->
          <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
          </div>
        </div> 
      </div>
    </div> 
<!-- Scripts -->
<script type="text/javascript">
    function MostrarModalExito(message) {
        $('#lblMsjModalExito').html(message);
        $('#modalExito').modal('show');
        return true;
    }
    function MostrarModalInformacion(message) {
        $('#lblMsjModalInformacion').html(message);
        $('#modalInformacion').modal('show');
        return true;
    }
    function MostrarModalError(message) {
        $('#lblMsjModalError').html(message);
        $('#modalError').modal('show');
        return true;
    }
</script>
</form>
</body>
</html>
