<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AsignarPlanes.aspx.cs" Inherits="LicsuWeb.Validado.AsignarPlanes" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Asignar Plan</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-footable/0.1.0/css/footable.min.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
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
                <h2 class="pull-left">Asignar Plan</h2>
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
                                            <label class="control-label col-xs-3">Consultar Asignación Por: </label>
                                            <div class="col-xs-5">
                                                <asp:DropDownList ID="dplFiltroAsignacion" runat="server" CssClass="form-control"
                                                    OnSelectedIndexChanged="dplFiltroAsignacion_SelectedIndexChanged" AutoPostBack="True" >
                                                    <asp:ListItem Value="" Text="Seleccione un Filtro"></asp:ListItem>
                                                    <asp:ListItem Value="sinCancelar" Text="Planes Sin Cancelar"></asp:ListItem>
                                                    <asp:ListItem Value="cancelados" Text="Planes Cancelados"></asp:ListItem>
                                                    <asp:ListItem Value="abonados" Text="Planes Abonados"></asp:ListItem>
                                                    <asp:ListItem Value="sinAbonar" Text="Planes Sin Abonar"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="control-label col-xs-3">Buscar: </label>
                                            <div class="col-xs-5">
                                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Nombre o Cédula"></asp:TextBox>
                                            </div>
                                            <div class="col-xs-4">
                                                <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                                                <asp:ImageButton ID="Add" runat="server" ImageUrl="~/Images/agregar.png" OnClick="Agregar_Click" />
                                            </div>
                                        </div>
                                    </div>
                                    <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                                        OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                                        DataKeyNames="PlanAlumnoID" CssClass="footable" PageSize="20"
                                        onpageindexchanging="GridView1_PageIndexChanging"
                                        EmptyDataText="No existen asignaciones..">
                                        <Columns>
                                            <asp:ButtonField CommandName="verBalance"
                                                ButtonType="Image" ImageUrl="~/Images/ver.png" HeaderText="Balance">
                                                <ControlStyle ></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="viewRecord"
                                                ButtonType="Image" ImageUrl="~/Images/ver.png" HeaderText="Ver">
                                                <ControlStyle ></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="editRecord"
                                                ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Mod">
                                                <ControlStyle ></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="deleteRecord"
                                                ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                                                <ControlStyle ></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:ButtonField CommandName="agregarPago"
                                                ButtonType="Button" Text="Pagar" HeaderText="Pagar">
                                                <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                            </asp:ButtonField>
                                            <asp:TemplateField HeaderText="Cédula">
                                                <ItemTemplate>
                                                    <asp:Label Visible="false" ID="UsuarioID" runat="server" Enabled="false" Text='<%# Eval("UsuarioID") %>' />
                                                    <asp:Label Visible="false" ID="PlanAlumnoID" runat="server" Enabled="false" Text='<%# Eval("PlanAlumnoID") %>' />
                                                    <asp:Label Visible="false" ID="PlanAlumnoFechaInicio" runat="server" Enabled="false" Text='<%# Eval("FechaInicio") %>' />
                                                    <asp:Label Visible="false" ID="PlanCosto" runat="server" Enabled="false" Text='<%# Eval("PlanCosto") %>' />
                                                    <asp:Label Visible="false" ID="PlanAlumnoFechaFin" runat="server" Enabled="false" Text='<%# Eval("FechaFin") %>' />
                                                    <asp:Label Visible="false" ID="FacturaNota" runat="server" Enabled="false" Text='<%# Eval("FacturaNota") %>' />
                                                    <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nombre(s)">
                                                <ItemTemplate>
                                                    <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                                    <asp:Label Visible="false" ID="UsuarioApellido" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Plan">
                                                <ItemTemplate>
                                                    <asp:Label ID="PlanNombre" runat="server" Enabled="false" Text='<%# Eval("PlanNombre") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Factura">
                                                <ItemTemplate>
                                                    <asp:Label ID="NumeroFactura" runat="server" Enabled="false" Text='<%# Eval("NumeroFactura") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>                                                                            
                                            <asp:TemplateField HeaderText="Total Pagado">
                                                <ItemTemplate>
                                                    <asp:Label ID="SaldoPositivo" runat="server" Enabled="false" Text='<%# Eval("SaldoPositivo") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField> 
                                            <asp:TemplateField HeaderText="Sin Cancelar">
                                                <ItemTemplate>
                                                    <asp:Label ID="SaldoNegativo" runat="server" Enabled="false" Text='<%# Eval("SaldoNegativo") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField> 
                                            <asp:TemplateField HeaderText="Finaliza el:">
                                                <ItemTemplate>
                                                    <asp:Label Visible="false" ID="ClasesActivas" runat="server" Enabled="false" Text='<%# Eval("ClasesActivas") %>' />
                                                    <asp:Label ID="PlanAlumnoFechaFinal" runat="server" Enabled="false" Text='<%# Eval("FechaFinal") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField> 
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                           <!-- Realizar Pago Starts here -->
                            <div id="addPago" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeAddPago" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="H4">Realizar Pago</h3>
                                        </div>
                                        <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Always" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <asp:HiddenField runat="server" ID="hdfDeuda" />
                                                        <asp:HiddenField runat="server" ID="hdfPositivo" />
                                                        <asp:HiddenField runat="server" ID="hdfPlanAlumnoID" />
                                                        <asp:HiddenField runat="server" ID="hdfUsuarioIDPago" />
                                                         <div class="form-group">
                                                            <label class="col-xs-4 control-label">Plan(es): </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="txtPlanAlumnoAdd" Enabled="false" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Factura Número: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox Enabled="false" ID="txtFacturaNumeroAdd" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>  
                                                        
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Fecha de la Factura: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="txtFechaFacturaAdd2" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa"></asp:TextBox>                                                          
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>    
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Monto: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox runat="server" ID="txtMontoAdd" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> 
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>    
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:Label ID="Label2" Visible="false" runat="server"></asp:Label>
                                                    <asp:Button ID="Pagar" runat="server" Text="Guardar" CssClass="btn btn-purple"  OnClick="Pagar_Click"/>
                                                    <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                 <img src="../Images/cargando2.gif" class="img-responsive center-block"><br />
                                                 <h5 class="text-center">Espere por Favor..</h5>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </div>
                                </div>
                            </div>
                            <!-- Realizar Pago Ends here -->
                            <!-- Add Modal Starts here -->
                            <div id="addModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="H1">Asignar Plan</h3>
                                        </div>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <asp:HiddenField runat="server" ID="hdfUsuarioID" />
                                                        <asp:HiddenField runat="server" ID="hdfSucursalID" />
                                                        <asp:HiddenField runat="server" ID="hdfClienteID" />
                                                        <asp:HiddenField runat="server" ID="hdfSaldoPositivo" />
                                                        <asp:HiddenField runat="server" ID="hdfSaldoNegativo" />
                                                        <asp:HiddenField runat="server" ID="hdfPlanCosto" />
                                                        <asp:HiddenField runat="server" ID="hdfClasesActivas" />
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Usuario: </label>
                                                            <div class="col-xs-6">
                                                                <div class="col-xs-8" style="padding:0;">
                                                                    <asp:TextBox ID="txtUsuario" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Cedula, Nombre o Empresa"></asp:TextBox>
                                                                </div>
                                                                <div class="col-xs-4" style="padding:0; text-align:right;">
                                                                    <asp:Button ID="BuscarUsr" runat="server" Text="Buscar" CssClass="btn btn-purple"  OnClick="BuscarUsr_Click"/> 
                                                                </div>
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div> 
                                                         <div class="form-group">
                                                            <label class="col-xs-4 control-label">Plan: </label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplPlan" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">¿Desea Acumular las clases?</label>
                                                            <div class="col-xs-6">
                                                                <asp:DropDownList ID="dplAcumulado" runat="server" OnSelectedIndexChanged="dplAcumulado_SelectedIndexChanged" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control">
                                                                    <asp:ListItem Text="Seleccione Un Valor" Value=""></asp:ListItem>
                                                                    <asp:ListItem Text="Si, por favor." Value="SI"></asp:ListItem>
                                                                    <asp:ListItem Text="No, gracias." Value="NO"></asp:ListItem>
                                                                </asp:DropDownList>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <asp:PlaceHolder runat="server" ID="phAcumulado" Visible="false">
                                                            <div class="form-group">
                                                               <label class="col-xs-4 control-label">Fecha de Vencimiento: </label>
                                                               <div class="col-xs-6">
                                                                    <asp:Label runat="server" ID="lblFechaVencimiento" CssClass="control-label" Text="Fecha de Vencimiento: "></asp:Label>  
                                                               </div>
                                                                <div class="col-xs-4"></div>
                                                            </div>
                                                            <div class="form-group">
                                                               <label class="col-xs-4 control-label">Clases Regulares: </label>
                                                               <div class="col-xs-6">
                                                                    <asp:Label runat="server" ID="lblClasesRegulares" CssClass="control-label" Text="Clases Acumuladas: " ></asp:Label>                                                    
                                                               </div>
                                                                <div class="col-xs-4"></div>
                                                            </div>
                                                            <div class="form-group">
                                                               <label class="col-xs-4 control-label">Clases Complementarias: </label>
                                                               <div class="col-xs-6">
                                                                    <asp:Label runat="server" ID="lblClasesComplemen" CssClass="control-label" Text="Clases Acumuladas: " ></asp:Label>                                                    
                                                               </div>
                                                                <div class="col-xs-4"></div>
                                                            </div>
                                                        </asp:PlaceHolder>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Factura Número: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="txtFacturaNumeroAsignar" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Factura Nota: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="txtFacturaNotaAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>     
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Fecha Inicio: </label>
                                                            <div class="col-xs-6">
                                                                <asp:HiddenField ID="hdfFechaINI" runat="server" />
                                                                <asp:TextBox ID="txtFechaInicio" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Fecha Fin: </label>
                                                            <div class="col-xs-6">
                                                                <asp:HiddenField ID="hdfFechaFIN" runat="server" />
                                                                <asp:TextBox ID="txtFechaFin" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
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
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                            <ProgressTemplate>
                                                <img src="../Images/cargando2.gif" class="img-responsive center-block"><br />
                                                 <h5 class="text-center">Espere por Favor..</h5>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </div>
                                </div>
                            </div>
                            <!-- Add Modal Ends here -->
                            <!-- Buscar Modal Starts here -->
                            <div id="bscModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="Button2" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="H3">Buscar Usuario</h3>
                                        </div>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>                                    
                                                <asp:GridView ID="GridView2" runat="server" Width="95%" HorizontalAlign="Center"
                                                    AutoGenerateColumns="false" AllowPaging="true"
                                                    CssClass="table table-hover table-striped" PageSize="20"
                                                    OnRowCommand="GridView2_RowCommand" 
                                                    EmptyDataText="No existen Usuarios..."
                                                    onpageindexchanging="GridView2_PageIndexChanging">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Nombre" HeaderStyle-CssClass="text-center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="UsuarioNombreB" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Apellido" HeaderStyle-CssClass="text-center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="UsuarioApellidoB" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cedula" HeaderStyle-CssClass="text-center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="UsuarioCedulaB" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Empresa" HeaderStyle-CssClass="text-center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="ClienteNombreB" runat="server" Enabled="false" Text='<%# Eval("ClienteNombre") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="UsuarioIDB" runat="server" Enabled="false" Text='<%# Eval("UsuarioID") %>' />
                                                                <asp:Label ID="SucursalIDB" runat="server" Enabled="false" Text='<%# Eval("SucursalID") %>' />
                                                                <asp:Label ID="ClienteIDB" runat="server" Enabled="false" Text='<%# Eval("ClienteID") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:ButtonField CommandName="selectRecord" ButtonType="Button" Text="Seleccionar" HeaderText="Seleccionar">
                                                            <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                                        </asp:ButtonField>
                                                                   
                                                    </Columns>
                                                </asp:GridView>
                                                <div class="modal-footer">
                                                    <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                            <ProgressTemplate>
                                                <img src="../Images/cargando2.gif" class="img-responsive center-block"><br />
                                                 <h5 class="text-center">Espere por Favor..</h5>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </div>
                                </div>
                            </div>
                            <!-- BUscar Modal Ends here -->

                            <!-- View Modal Starts here -->
                            <div id="viewModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="Button1" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="H2">Ver Asignación</h3>
                                        </div>
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblNombre" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Apellido: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblApellido" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Cédula: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblCedula" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>   
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Plan: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblPlan" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>       
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Inicio: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblFechaInicio" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Fin: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblFechaFin" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Factura: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblFactura" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                         <div class="form-group">
                                                            <label class="col-xs-4 control-label">Nota Factura: </label>
                                                            <div class="col-xs-6">
                                                                <asp:Label ID="lblNotaFactura" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:Label>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:Label ID="Label1" Visible="false" runat="server"></asp:Label>
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
                            <!-- View Modal Ends here -->
                             <!-- Edit Modal Starts here -->
                            <div id="editModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="editModalLabel">Modificar Asignación</h3>
                                            
                                        </div>
                                        <asp:UpdatePanel ID="upEdit" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <asp:HiddenField ID="hdfPlanAlumnoIDEdit" runat="server" />
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Nombre: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="lblNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Apellido: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="lblApellidoEdit" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Cédula: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="lblCedulaEdit" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>   
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Plan: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="lblPlanEdit" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>       
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Inicio: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="lblInicioEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-xs-4 control-label">Fin: </label>
                                                            <div class="col-xs-6">
                                                                <asp:TextBox ID="lblFinEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                            </div>
                                                            <div class="col-xs-4"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:Label ID="Label9" Visible="false" runat="server"></asp:Label>
                                                    <asp:Button ID="btnSave"  runat="server" Text="Modificar" CssClass="btn btn-purple" OnClick="btnSave_Click" />
                                                    <button class="btn btn-purple" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                            <ProgressTemplate>
                                                <img src="../Images/cargando2.gif" class="img-responsive center-block"><br />
                                                 <h5 class="text-center">Espere por Favor..</h5>
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
                                            <h3 id="delModalLabel">Eliminar Cliente</h3>
                                        </div>
                                        <asp:UpdatePanel ID="upDel" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    ¿Seguro desea eliminar este registro?
                                                    <asp:HiddenField ID="hPlanAlumnoID" runat="server" />
                                                    
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
                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
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
<script src="js/moment-with-locales.min.js"></script>
<script src="js/bootstrap-datetimepicker.min.js"></script>
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
    
    $(function () {
        $('#<%= txtFechaFacturaAdd2.ClientID %>').datetimepicker({
            locale: 'es',
            format: 'DD/MM/YYYY'
        });
    });
</script>
    </form>
</body>
</html>