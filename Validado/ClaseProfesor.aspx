<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClaseProfesor.aspx.cs" Inherits="LicsuWeb.Validado.ClaseProfesor" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc3" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title id="Title1" runat="server">Clases</title>
    <uc1:ucHeader runat="server" ID="ucHeader" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
    
<style type="text/css">
 .modalwait
{
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}
.centerwait
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
 .centerwait img
{
    height: 100px;
    width: 100px;
}</style>

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
                    <h2 class="pull-left">Gestión</h2>
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
                    <asp:UpdateProgress ID="up1" runat="server" AssociatedUpdatePanelID="upCrudGrid">
                        <ProgressTemplate>
                            <div class="modalwait">
                                <div class="centerwait">
                                    <img src="img/loading.gif" alt=""/>
                                </div>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div class="col-md-12">
                      <div class="row placeholders">
                        <div style="width: 90%; margin-right: 5%; margin-left: 5%; text-align: center">
                            <asp:UpdatePanel ID="upCrudGrid" runat="server">
                                <ContentTemplate>
                                    <div class="row col-md-offset-2 col-md-10">
                                        <asp:PlaceHolder ID="phPlan" runat="server">
                                            <div class="form-group">
                                                <asp:Label ID="lblPlan" runat="server" AssociatedControlID="ddlPlan" CssClass="col-sm-3 control-label">Plan:</asp:Label>     
                                                <div class="col-sm-5 selectContainer">
                                                    <asp:DropDownList runat="server" ID="ddlPlan" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlPlan_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </asp:PlaceHolder>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-xs-3 ">Buscar: </label>
                                        <div class="col-xs-5">
                                            <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Clase o Profesor"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-4">
                                            <asp:Button ID="btnSearch" runat="server" Text="Buscar" CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                                            <asp:Button ID="btnAdd" runat="server" Text="Nuevo" CssClass="btn btn-purple" OnClick="btnAdd_Click" />
                                        </div>
                                    </div>
                                    <asp:GridView ID="GridView1" runat="server" Width="1024px" HorizontalAlign="Center"
                                        OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                                        CssClass="table table-hover table-striped" PageSize="30"
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
                                            <asp:ButtonField CommandName="copyRecord"
                                                ButtonType="Button" Text="C" HeaderText="Cop">
                                                <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="deleteRecord"
                                                ButtonType="Button" Text="E" HeaderText="Eli">
                                                <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:BoundField DataField="ClaseProfesorID" HeaderText="Código" />
                                            <asp:BoundField DataField="ClaseDescripcion" HeaderText="Clase" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="NivelNombre" HeaderText="Nivel" />
                                            <asp:BoundField DataField="ProfesorNombre" HeaderText="Profesor" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="SalonNombre" HeaderText="Salón" />
                                            <asp:BoundField DataField="ClaseCupo" HeaderText="Cupos" />
                                            <asp:BoundField DataField="SalonTipoReserva" HeaderText="Espacio" />
                                            <asp:BoundField DataField="ClaseFechaInicio" HeaderText="Fecha" />
                                            <asp:BoundField DataField="ClaseHoraInicio" HeaderText="Hora" />
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
                                                            <asp:BoundField DataField="ClaseProfesorID" HeaderText="Código" />
                                                            <asp:BoundField DataField="ClaseDescripcion" HeaderText="Clase" />
                                                            <asp:BoundField DataField="NivelNombre" HeaderText="Nivel" />
                                                            <asp:BoundField DataField="ProfesorNombre" HeaderText="Profesor" />
                                                            <asp:BoundField DataField="SalonNombre" HeaderText="Salón" />
                                                            <asp:BoundField DataField="ClaseCupo" HeaderText="Cupos" />
                                                            <asp:BoundField DataField="SalonTipoReserva" HeaderText="Espacio" />
                                                            <asp:BoundField DataField="ClaseFechaInicio" HeaderText="Fecha" />
                                                            <asp:BoundField DataField="ClaseHoraInicio" HeaderText="Hora" />
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
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Clase: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlClaseMod" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Nivel: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlNivelMod" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Profesor: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlProfesorMod" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Salón: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlSalonMod" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Cupos: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtClaseCupoMod" runat="server" ClientIDMode="Static" CssClass="form-control"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Espacio: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtSalonTipoReservaMod" runat="server" ClientIDMode="Static" CssClass="form-control"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Fecha: </label>
                                                            <div class="col-xs-8">                               
                                                                <asp:TextBox ID="txtClaseFechaInicioMod" runat="server" ClientIDMode="Static" CssClass="form-control col-xs-4" placeholder="dd/mm/aaaa"></asp:TextBox>
                                                             </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Hora: </label>
                                                            <div class="col-xs-8">                               
                                                                <asp:DropDownList runat="server" ID="ddlHoraMod" CssClass="form-control">
                                                                    <asp:ListItem Value="6:00">6:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="6:30">6:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="7:00">7:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="7:30">7:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="8:00">8:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="8:30">8:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="9:00">9:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="9:30">9:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="10:00" Selected="True">10:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="10:15">10:15 AM</asp:ListItem>
                                                                    <asp:ListItem Value="10:30">10:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="11:00">11:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="11:15">11:15 AM</asp:ListItem>
                                                                    <asp:ListItem Value="11:30">11:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="12:00">12:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="12:15">12:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="12:30">12:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="13:00">1:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="13:15">1:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="13:30">1:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="14:00">2:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="14:15">2:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="14:30">2:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="15:00">3:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="15:15">3:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="15:30">3:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="16:00">4:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="16:15">4:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="16:30">4:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="17:00">5:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="17:15">5:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="17:30">5:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="18:00">6:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="18:15">6:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="18:30">6:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="19:00">7:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="19:15">7:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="19:30">7:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="20:00">8:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="20:15">8:15 PM</asp:ListItem>
                                                                </asp:DropDownList>
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
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Clase: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlClaseNue" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Nivel: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlNivelNue" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Profesor: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlProfesorNue" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Salón: </label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList runat="server" ID="ddlSalonNue" CssClass="form-control" AutoPostBack="False"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Cupos: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtClaseCupoNue" runat="server" ClientIDMode="Static" CssClass="form-control"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Espacio: </label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtSalonTipoReservaNue" runat="server" ClientIDMode="Static" CssClass="form-control"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Fecha: </label>
                                                            <div class="col-xs-8">                               
                                                                <asp:TextBox ID="txtClaseFechaInicioNue" runat="server" ClientIDMode="Static" CssClass="form-control col-xs-4" placeholder="dd/mm/aaaa"></asp:TextBox>
                                                             </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="col-xs-4 control-label">Hora: </label>
                                                            <div class="col-xs-8">                               
                                                                <asp:DropDownList runat="server" ID="ddlHoraNue" CssClass="form-control">
                                                                    <asp:ListItem Value="6:00">6:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="6:30">6:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="7:00">7:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="7:30">7:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="8:00">8:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="8:30">8:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="9:00">9:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="9:30">9:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="10:00" Selected="True">10:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="10:15">10:15 AM</asp:ListItem>
                                                                    <asp:ListItem Value="10:30">10:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="11:00">11:00 AM</asp:ListItem>
                                                                    <asp:ListItem Value="11:15">11:15 AM</asp:ListItem>
                                                                    <asp:ListItem Value="11:30">11:30 AM</asp:ListItem>
                                                                    <asp:ListItem Value="12:00">12:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="12:15">12:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="12:30">12:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="13:00">1:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="13:15">1:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="13:30">1:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="14:00">2:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="14:15">2:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="14:30">2:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="15:00">3:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="15:15">3:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="15:30">3:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="16:00">4:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="16:15">4:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="16:30">4:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="17:00">5:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="17:15">5:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="17:30">5:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="18:00">6:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="18:15">6:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="18:30">6:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="19:00">7:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="19:15">7:15 PM</asp:ListItem>
                                                                    <asp:ListItem Value="19:30">7:30 PM</asp:ListItem>
                                                                    <asp:ListItem Value="20:00">8:00 PM</asp:ListItem>
                                                                    <asp:ListItem Value="20:15">8:15 PM</asp:ListItem>
                                                                </asp:DropDownList>
                                                             </div>
                                                        </div>
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
                                                    <asp:HiddenField ID="hfID" runat="server" />
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
<!-- Scripts -->
<%--<script src="js/funciones.js"></script>--%>
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
