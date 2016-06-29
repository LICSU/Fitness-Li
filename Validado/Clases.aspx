<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clases.aspx.cs" Inherits="LicsuWeb.Validado.Clasees" EnableEventValidation="false" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Listar Clases</title>
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
                <h2 class="pull-left">Listar Clases</h2>

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
                                    <asp:GridView ID="GridView1" CssClass="footable" runat="server" Width="90%" HorizontalAlign="Center"
                                        OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                                        DataKeyNames="ClaseID"  PageSize="20"
                                        onpageindexchanging="GridView1_PageIndexChanging">
                                        <Columns>                                            
                                            <asp:ButtonField CommandName="editRecord"
                                                ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Mod">
                                                <ControlStyle></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="deleteRecord"
                                                ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                                                <ControlStyle></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:TemplateField HeaderText="Nombre">
                                                <ItemTemplate>
                                                    <asp:Label ID="IDClase_1" runat="server" Visible="false" Enabled="false" Text='<%# Eval("ClaseID") %>' />
                                                    <asp:Label ID="Nombre" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tipo">
                                                <ItemTemplate>
                                                    <asp:Label ID="Tipo" runat="server" Enabled="false" Text='<%# Eval("Tipo") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Tipo de Calificación">
                                                <ItemTemplate>
                                                    <asp:Label ID="TipoCalificacionID" runat="server" Visible="false" Enabled="false" Text='<%# Eval("TipoCalificacionID") %>' />
                                                    <asp:Label ID="TipoCalificacion" runat="server" Enabled="false" Text='<%# Eval("TipoCalificacion") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>  
                                            <asp:TemplateField HeaderText="Unidades">
                                                <ItemTemplate>
                                                    <asp:Label ID="Unidad" runat="server" Enabled="false" Text='<%# Eval("Unidad") %>' />
                                                    <asp:Label ID="Sensor" Visible="false" runat="server" Enabled="false" Text='<%# Eval("Sensor") %>' />
                                                    <asp:Label ID="Break" Visible="false" runat="server" Enabled="false" Text='<%# Eval("TiempoCambio") %>' />
                                                    <asp:Label ID="Intervalo" Visible="false" runat="server" Enabled="false" Text='<%# Eval("Intervalo") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>  
                                            <asp:TemplateField HeaderText="Activa">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="Activa" runat="server" Enabled="false" Checked='<%# Eval("ClaseActiva") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>                                  
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="ImgbtnArchivo" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <h4 class="text-info">Verificando..</h4><br />
                                    <img src="img/loading.gif" class="img-responsive center-block"><br />
                                    <h4 class="text-info">Espere Por Favor</h4>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <!-- Add Modal Starts here -->
                            <div id="addModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="H1">Agregar Clase</h3>
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
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Tipo de Clase: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplTipo" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                    <asp:ListItem Value="" Text="Seleccione el Tipo"></asp:ListItem>
                                                                    <asp:ListItem Value="Complementaria" Text="Complementaria"></asp:ListItem>
                                                                    <asp:ListItem Value="Regular" Text="Regular"></asp:ListItem>
                                                                </asp:DropDownList>                                                                
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Unidades: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplUnidad" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                    <asp:ListItem Value="" Text="Seleccione la Unidad"></asp:ListItem>
                                                                    <asp:ListItem Value="0,25" Text="0.25"></asp:ListItem>
                                                                    <asp:ListItem Value="0,5" Text="0.5"></asp:ListItem>
                                                                    <asp:ListItem Value="0,75" Text="0.75"></asp:ListItem>
                                                                    <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                                                </asp:DropDownList>                                                                
                                                            </div>
                                                        </div>
                                                         <div class="form-group">
                                                            <label class="col-xs-4 control-label">Tipo de Calificación: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList runat="server" ID="dplTipoCalificacion" ClientIDMode="Static" CssClass="form-control">
                                                                    <asp:ListItem Value="" Text="Seleccione el Tipo"></asp:ListItem>
                                                                </asp:DropDownList>                                                           
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">¿Ordenada por espacios? </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList CssClass="form-control" ID="dplOrden" AutoPostBack="true" runat="server" ClientIDMode="Static" OnSelectedIndexChanged="dplOrden_SelectedIndexChanged"  >
                                                                    <asp:ListItem Text="Seleccione una Opción" Value=""></asp:ListItem>
                                                                    <asp:ListItem Text="Si" Value="Si"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                </asp:DropDownList>                                                               
                                                            </div>
                                                        </div>   
                                                        <asp:PlaceHolder runat="server" ID="plhOrdenAdd" Visible="false">
                                                            <div class="form-group">
                                                                <label class="col-xs-4 control-label">Filas: </label>
                                                                <div class="col-xs-6">
                                                                    <asp:TextBox CssClass="form-control" ID="txtFilasAdd" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                               
                                                                </div>
                                                            </div> 
                                                            <div class="form-group">
                                                                <label class="col-xs-4 control-label">Columnas: </label>
                                                                <div class="col-xs-6">
                                                                    <asp:TextBox CssClass="form-control" ID="txtColumnasAdd" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                               
                                                                </div>
                                                            </div>  
                                                        </asp:PlaceHolder>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Activa: </label>
                                                            <div class="col-xs-1">
                                                                <asp:CheckBox ID="chkActivoAdd" runat="server" ClientIDMode="Static"  />                                                               
                                                            </div>
                                                        </div> 
                                                        <div class="form-group">
                                                            <label class="col-xs-10 control-label text-left">Solo para Sistema Medical Li: </label>                                                            
                                                        </div>    
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">¿Duración de cada actividad?: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplIntervaloAdd" CssClass="form-control" runat="server" ClientIDMode="Static"  >
                                                                    <asp:ListItem Text="Seleccione un Valor" Value=""></asp:ListItem>
                                                                    <asp:ListItem Text="5 Minutos" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="10 Minutos" Value="10"></asp:ListItem>
                                                                    <asp:ListItem Text="15 Minutos" Value="15"></asp:ListItem>
                                                                    <asp:ListItem Text="20 Minutos" Value="20"></asp:ListItem>
                                                                    <asp:ListItem Text="25 Minutos" Value="25"></asp:ListItem>
                                                                    <asp:ListItem Text="30 Minutos" Value="30"></asp:ListItem>
                                                                </asp:DropDownList>                                                               
                                                            </div>
                                                        </div>  
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">¿Número de Sensores?: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplSensoresAdd" CssClass="form-control" runat="server" ClientIDMode="Static"  >
                                                                    <asp:ListItem Text="Seleccione un Valor" Value=""></asp:ListItem>
                                                                    <asp:ListItem Text="1 Sensor" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2 Sensores" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3 Sensores" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4 Sensores" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5 Sensores" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6 Sensores" Value="6"></asp:ListItem>
                                                                </asp:DropDownList>                                                               
                                                            </div>
                                                        </div>  
                                                        <div class="form-group">  
                                                            <label class="col-xs-4 control-label">¿Tiempo de Intercambio por Turno?: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox runat="server" ID="txtBreakAdd" CssClass="form-control" placeholder="En Minutos"></asp:TextBox>
                                                            </div>
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
                                                <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"  />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <h4 class="text-info">Guardando..</h4><br />
                                                <img src="img/loading.gif" class="img-responsive center-block"><br />
                                                <h4 class="text-info">Espere Por Favor</h4>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
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
                                            <h3 id="editModalLabel">Modificar Clase</h3>                                            
                                        </div>
                                        <asp:UpdatePanel ID="upEdit" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <asp:HiddenField ID="hClaseMod" runat="server" /> 
                                                         <div class="form-group">
                                                            <label class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Tipo de Clase: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplTipoEdit" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                    <asp:ListItem Value="" Text="Seleccione el Tipo"></asp:ListItem>
                                                                    <asp:ListItem Value="Complementaria" Text="Complementaria"></asp:ListItem>
                                                                    <asp:ListItem Value="Regular" Text="Regular"></asp:ListItem>
                                                                </asp:DropDownList>                                                                
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Unidades: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplUnidadEdit" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                    <asp:ListItem Value="" Text="Seleccione la Unidad"></asp:ListItem>
                                                                    <asp:ListItem Value="0.25" Text="0.25"></asp:ListItem>
                                                                    <asp:ListItem Value="0.5" Text="0.5"></asp:ListItem>
                                                                    <asp:ListItem Value="0.75" Text="0.75"></asp:ListItem>
                                                                    <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                                                </asp:DropDownList>                                                                
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Tipo de Calificación: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList runat="server" ID="dplTipoCalificacionEdit" ClientIDMode="Static" CssClass="form-control">
                                                                </asp:DropDownList>                                                           
                                                            </div>
                                                        </div>
                                                        <asp:PlaceHolder runat="server" ID="plhOrdenEdit" Visible="false">
                                                            <div class="form-group">
                                                                <label class="col-xs-4 control-label">Filas: </label>
                                                                <div class="col-xs-6">
                                                                    <asp:TextBox CssClass="form-control" ID="txtFilasEdit" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                               
                                                                </div>
                                                            </div> 
                                                            <div class="form-group">
                                                                <label class="col-xs-4 control-label">Columnas: </label>
                                                                <div class="col-xs-6">
                                                                    <asp:TextBox CssClass="form-control" ID="txtColumnasEdit" runat="server" ClientIDMode="Static"  ></asp:TextBox>                                                               
                                                                </div>
                                                            </div>  
                                                        </asp:PlaceHolder>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Activa: </label>
                                                                <div class="col-xs-1">
                                                                    <asp:CheckBox ID="chkActivaEdit" runat="server" ClientIDMode="Static" />
                                                                </div>
                                                        </div>  
                                                        <div class="form-group">
                                                            <label class="col-xs-10 control-label">En caso de ser para Sistema Medical Li: </label>                                                            
                                                        </div>    
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">¿Duración de cada actividad?: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplIntervaloEdit" CssClass="form-control" runat="server" ClientIDMode="Static"  >
                                                                    <asp:ListItem Text="Seleccione un Valor" Value=""></asp:ListItem>
                                                                    <asp:ListItem Text="5 Minutos" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="10 Minutos" Value="10"></asp:ListItem>
                                                                    <asp:ListItem Text="15 Minutos" Value="15"></asp:ListItem>
                                                                    <asp:ListItem Text="20 Minutos" Value="20"></asp:ListItem>
                                                                    <asp:ListItem Text="25 Minutos" Value="25"></asp:ListItem>
                                                                    <asp:ListItem Text="30 Minutos" Value="30"></asp:ListItem>
                                                                </asp:DropDownList>                                                               
                                                            </div>
                                                        </div>     
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">¿Número de Sensores?: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplSensoresEdit" CssClass="form-control" runat="server" ClientIDMode="Static"  >
                                                                    <asp:ListItem Text="Seleccione un Valor" Value=""></asp:ListItem>
                                                                    <asp:ListItem Text="1 Sensor" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2 Sensores" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3 Sensores" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4 Sensores" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5 Sensores" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6 Sensores" Value="6"></asp:ListItem>
                                                                </asp:DropDownList>                                                               
                                                            </div>
                                                        </div>     
                                                        <div class="form-group">  
                                                            <label class="col-xs-4 control-label">¿Tiempo de Intercambio por Turno?: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox runat="server" ID="txtBreakEdit" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
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
                                        <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                            <ProgressTemplate>
                                                <h4 class="text-info">Guardando..</h4><br />
                                                <img src="img/loading.gif" class="img-responsive center-block"><br />
                                                <h4 class="text-info">Espere Por Favor</h4>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
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
                        </div>
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