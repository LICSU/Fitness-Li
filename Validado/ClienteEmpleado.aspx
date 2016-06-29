<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClienteEmpleado.aspx.cs" Inherits="LicsuWeb.Validado.ClienteEmpleado" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc3" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title id="Title1" runat="server">Empleados</title>
    <uc1:ucHeader runat="server" ID="ucHeader" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
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
                    <h2 class="pull-left">Empleados</h2>
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
                                    <div class="row col-md-offset-2 col-md-10">
                                        <asp:PlaceHolder ID="phCliente" runat="server">
                                            <div class="form-group">
                                                <asp:Label ID="lblCliente" runat="server" AssociatedControlID="ddlCliente" CssClass="col-sm-3 control-label">Cliente:</asp:Label>     
                                                <div class="col-sm-5 selectContainer">
                                                    <asp:DropDownList runat="server" ID="ddlCliente" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlCliente_SelectedIndexChanged"></asp:DropDownList>
                                                    </div>
                                            </div>
                                        </asp:PlaceHolder>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-xs-3 ">Buscar: </label>
                                        <div class="col-xs-5">
                                            <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Cédula o Nombre"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-4">
                                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                                            <asp:Button ID="btnAdd" runat="server" Text="Nuevo"  CssClass="btn btn-purple" OnClick="btnAdd_Click" />
                                        </div>
                                    </div>
                                    <asp:GridView ID="GridView1" runat="server" Width="940px" HorizontalAlign="Center"
                                        OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                                        DataKeyNames="Cedula" CssClass="table table-hover table-striped" PageSize="20"
                                        onpageindexchanging="GridView1_PageIndexChanging">
                                        <Columns>
                                            <asp:ButtonField CommandName="detail"
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
                                            <asp:BoundField DataField="Cedula" HeaderText="Cédula" />
                                            <asp:BoundField DataField="CodigoEmpleado" HeaderText="Cód_Empleado" />
                                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                            <asp:BoundField DataField="FechaIngreso" HeaderText="Fec_Ingreso" />
                                            <asp:BoundField DataField="FechaEgreso" HeaderText="Fec_Egreso" />
                                            <asp:BoundField DataField="Correo" HeaderText="Correo" />
                                            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                                            <asp:BoundField DataField="Zona" HeaderText="Zona" />
                                            <asp:BoundField DataField="Region" HeaderText="Región" />
                                            <asp:BoundField DataField="Empresa" HeaderText="Empresa" />
                                            <asp:BoundField DataField="TipoEmpleado" HeaderText="Tip_Empleado" />
                                            <asp:BoundField DataField="UnidadNegocio" HeaderText="Uni_Negocio" />
                                            <asp:BoundField DataField="Gerencia" HeaderText="Gerencia" />
                                            <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                                            <asp:BoundField DataField="EmpleadoActivo" HeaderText="Emp_Activo" />
                                            <asp:BoundField DataField="Beneficio1" HeaderText="Beneficio1" />
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                            <!-- Detail Modal Starts here-->
                            <div id="detailModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="myModalLabel">Ver Detalles</h3>
                                        </div>
                                        <div class="modal-body">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:DetailsView ID="DetailsView1" runat="server" CssClass="table table-bordered table-hover" BackColor="White" ForeColor="Black" FieldHeaderStyle-Wrap="false" FieldHeaderStyle-Font-Bold="true" FieldHeaderStyle-BackColor="LavenderBlush" FieldHeaderStyle-ForeColor="Black" BorderStyle="Groove" AutoGenerateRows="False">
                                                        <Fields>
                                                            <asp:BoundField DataField="Cedula" HeaderText="Cédula" />
                                                            <asp:BoundField DataField="CodigoEmpleado" HeaderText="Cód Empleado" />
                                                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                                            <asp:BoundField DataField="FechaIngreso" HeaderText="Fec Ingreso" />
                                                            <asp:BoundField DataField="FechaEgreso" HeaderText="Fec Egreso" />
                                                            <asp:BoundField DataField="Correo" HeaderText="Correo" />
                                                            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                                                            <asp:BoundField DataField="Zona" HeaderText="Zona" />
                                                            <asp:BoundField DataField="Region" HeaderText="Región" />
                                                            <asp:BoundField DataField="Empresa" HeaderText="Empresa" />
                                                            <asp:BoundField DataField="TipoEmpleado" HeaderText="Tip Empleado" />
                                                            <asp:BoundField DataField="UnidadNegocio" HeaderText="Uni Negocio" />
                                                            <asp:BoundField DataField="Gerencia" HeaderText="Gerencia" />
                                                            <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                                                            <asp:BoundField DataField="EmpleadoActivo" HeaderText="Emp Activo" />
                                                            <asp:BoundField DataField="Beneficio1" HeaderText="Beneficio1" />
                                                       </Fields>
                                                    </asp:DetailsView>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                            <div class="modal-footer">
                                                <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Detail Modal Ends here -->
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
                                                        <asp:PlaceHolder ID="phCedulaMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Cédula: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCedulaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCodigoEmpleadoMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Código Empleado: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCodigoEmpleadoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phNombreMod" runat="server">
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtNombreMod" runat="server" ClientIDMode="Static" CssClass="form-control"  />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaIngresoMod" runat="server">
                                                        <div class="form-group">
                                                            <asp:Label ID="lblFechaIngresoMod" runat="server" AssociatedControlID="txtFechaIngresoMod" CssClass="col-sm-4 control-label">Fecha Ingreso:</asp:Label>     
                                                            <div class="col-sm-8">                               
                                                                <asp:TextBox ID="txtFechaIngresoMod" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa"></asp:TextBox>
                                                             </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaEgresoMod" runat="server">
                                                        <div class="form-group">
                                                            <asp:Label ID="lblFechaEgresoMod" runat="server" AssociatedControlID="txtFechaEgresoMod" CssClass="col-sm-4 control-label">Fecha Egreso:</asp:Label>     
                                                            <div class="col-sm-8">                               
                                                                <asp:TextBox ID="txtFechaEgresoMod" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa"></asp:TextBox>
                                                             </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCorreoMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Correo: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCorreoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phTelefonoMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Teléfono: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtTelefonoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phZonaMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Zona: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtZonaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phRegionMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Región: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtRegionMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phEmpresaMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Empresa: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtEmpresaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phTipoEmpleadoMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Tipo Empleado: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtTipoEmpleadoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phUnidadNegocioMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Unidad de Negocio: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtUnidadNegocioMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phGerenciaMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Gerencia: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtGerenciaMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCargoMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Cargo: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCargoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phEmpleadoActivoMod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Empleado Activo: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtEmpleadoActivoMod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phBeneficio1Mod" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Beneficio 1: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtBeneficio1Mod" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
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
                                                            <label class="col-xs-4 control-label">Cédula: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCedulaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCodigoEmpleadoNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Código Empleado: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCodigoEmpleadoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phNombreNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtNombreNue" runat="server" ClientIDMode="Static" CssClass="form-control"  />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaIngresoNue" runat="server">
                                                        <div class="form-group">
                                                            <asp:Label ID="lblFechaIngresoNue" runat="server" AssociatedControlID="txtFechaIngresoNue" CssClass="col-sm-4 control-label">Fecha Ingreso:</asp:Label>     
                                                            <div class="col-sm-8">                               
                                                                <asp:TextBox ID="txtFechaIngresoNue" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa"></asp:TextBox>
                                                             </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phFechaEgresoNue" runat="server">
                                                        <div class="form-group">
                                                            <asp:Label ID="lblFechaEgresoNue" runat="server" AssociatedControlID="txtFechaEgresoNue" CssClass="col-sm-4 control-label">Fecha Egreso:</asp:Label>     
                                                            <div class="col-sm-8">                               
                                                                <asp:TextBox ID="txtFechaEgresoNue" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa"></asp:TextBox>
                                                             </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCorreoNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Correo: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCorreoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phTelefonoNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Teléfono: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtTelefonoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phZonaNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Zona: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtZonaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phRegionNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Región: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtRegionNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phEmpresaNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Empresa: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtEmpresaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phTipoEmpleadoNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Tipo Empleado: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtTipoEmpleadoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phUnidadNegocioNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Unidad de Negocio: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtUnidadNegocioNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phGerenciaNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Gerencia: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtGerenciaNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phCargoNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Cargo: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtCargoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phEmpleadoActivoNue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">EmpleadoActivo: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtEmpleadoActivoNue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
                                                        </div>
                                                        </asp:PlaceHolder>
                                                        <asp:PlaceHolder ID="phBeneficio1Nue" runat="server">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Beneficio 1: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtBeneficio1Nue" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                                            </div>
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
                    <!-- Contenido ...FIN... -->

    </div> 
        </div>
        <!-- /. PAGE Inner  -->
<!--     </div> -->
 <!--/. PAGE WRAPPER  -->

<uc3:ucFooter runat="server" id="ucFooter" />
    <script src="Scripts/formValidation/formValidation.min.js"></script>

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
<%--<script src="js/funciones.js"></script>--%>
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
