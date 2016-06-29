<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsultarUsuarios.aspx.cs" Inherits="LicsuWeb.Validado.ConsultarUsuarios" EnableEventValidation="false" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Listar Usuarios</title>
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
                <h2 class="pull-left">Listar Usuarios</h2>

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
                            <asp:DropDownList ID="dplEmpresas" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dplEmpresas_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="col-lg-4 col-xs-4 text-left">
                            <asp:Label ID="lblFiltro" AssociatedControlID="dplEmpresas" runat="server" CssClass="control-label">Filtrar por Empresas</asp:Label>
                        </div>
                        <div class="col-lg-2"></div>
                    </div>
                    <div class="col-lg-1"></div>
                 </div>
                <br />
                <div class="row">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-10">                       
                        <div class="col-lg-6 col-xs-8">
                             <asp:DropDownList ID="dplRol" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dplRol_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="col-lg-4 col-xs-4 text-left">
                            <asp:Label ID="Label1" AssociatedControlID="dplRol" runat="server" CssClass="control-label ">Filtrar por Rol</asp:Label>
                        </div>
                        <div class="col-lg-2"></div>
                    </div>
                    <div class="col-lg-1"></div>
                 </div>
                <br />
                <div class="row">
                    <div class="col-lg-1"></div>
                    <div class="col-lg-10">
                        <div class="col-lg-6 col-xs-8">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Buscar"></asp:TextBox>
                        </div>
                        <div class="col-lg-2 col-xs-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                       
                        </div>
                        <div class="col-lg-2 col-xs-8">&nbsp;</div>
                        <div class="col-lg-1 col-xs-2">
                            <asp:ImageButton ID="Add" runat="server" ImageUrl="~/Images/agregar.png" OnClick="btnAgregar_Click" />
                        </div>
                        <div class="col-lg-1 col-xs-2 text-right"> 
                            <asp:ImageButton ID="ImgButton3" runat="server"  ImageUrl="~/Images/descargar.png" OnClick="btnArchivo_Click" />     
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
                </div>
                <asp:GridView ID="GridView1" runat="server" Width="95%" HorizontalAlign="Center"
                    AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="UsuarioID" CssClass="footable" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging" AllowSorting="true" OnSorting="GridView1_Sorting"
                    onrowcommand="GridView1_RowCommand"
                    EmptyDataText="No Existen Usuarios.">
                    <Columns>
                        <asp:ButtonField CommandName="viewRecord" 
                            ButtonType="Image" ImageUrl="~/Images/ver.png" HeaderText="Ver" >
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
                        <asp:TemplateField HeaderText="Cédula">
                            <ItemTemplate>
                                <asp:Label ID="Cedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="Nombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                <asp:Label ID="IDUsuario_1" Visible="false" runat="server" Enabled="false" Text='<%# Eval("UsuarioID") %>' />  
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Apellido">
                            <ItemTemplate>
                                <asp:Label ID="Apellido" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Contraseña">
                            <ItemTemplate>
                                <asp:Label ID="Clave" runat="server" Enabled="false" Text='<%# Eval("UsuarioClave") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="Correo" runat="server" Enabled="false" Text='<%# Eval("UsuarioCorreo") %>' />
                            </ItemTemplate>
                        </asp:TemplateField> 
                       <asp:TemplateField HeaderText="Teléfono">
                            <ItemTemplate>
                                <asp:Label ID="Telefono" runat="server" Enabled="false" Text='<%# Eval("UsuarioTelefono") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Unidad">
                            <ItemTemplate>
                                <asp:Label ID="Empresa" runat="server" Enabled="false"  Text='<%# Eval("ClienteID") %>'/>
                                <asp:Label Visible="false" ID="ClienteID" runat="server" Enabled="false"  Text='<%# Eval("EmpresaID") %>'/>
                                <asp:Label Visible="false" ID="Observacion" runat="server" Enabled="false"  Text='<%# Eval("UsuarioObservacion") %>'/>
                                <asp:Label Visible="false" ID="EPS" runat="server" Enabled="false"  Text='<%# Eval("UsuarioEPS") %>'/>
                                <asp:Label Visible="false" ID="Celular2" runat="server" Enabled="false"  Text='<%# Eval("UsuarioCelular2") %>'/>
                                <asp:Label Visible="false" ID="Celular1" runat="server" Enabled="false"  Text='<%# Eval("UsuarioCelular1") %>'/>
                                <asp:Label Visible="false" ID="Sexo" runat="server" Enabled="false"  Text='<%# Eval("UsuarioSexo") %>'/>
                                <asp:Label Visible="false" ID="EstadoC" runat="server" Enabled="false"  Text='<%# Eval("UsuarioEstadoCivil") %>'/>
                                <asp:Label Visible="false" ID="FechaN" runat="server" Enabled="false"  Text='<%# Eval("UsuarioFechaNacimiento") %>'/>
                                
                            </ItemTemplate>
                        </asp:TemplateField>                                              
                        <asp:TemplateField HeaderText="Rol">
                            <ItemTemplate>
                                <asp:Label ID="Rol" runat="server" Enabled="false"  Text='<%# Eval("RolDescripcion") %>'/>
                            </ItemTemplate>
                        </asp:TemplateField>                                                
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="ImgButton3" />
            </Triggers>
        </asp:UpdatePanel>
        <!-- View Modal Starts here -->
        <div id="viewModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="Button1" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="H1">Ver Usuario</h3>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <asp:HiddenField ID="HiddenField1" runat="server" />  
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Cédula: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCedulaVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Clave: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtClaveVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Apellido: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtApellidoVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Rol: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtRolVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Correo: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCorreoVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Fecha de Nacimiento: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtFechaNVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Estado Civíl: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtEstadoCVer" runat="server" ClientIDMode="Static" CssClass="form-control " Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Sexo: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtSexoVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Teléfono: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtTelefonoVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div> 
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Celular 1: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCelular1Ver" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Celular 2: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCelular2Ver" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                        <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">EPS: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtEPSVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>       
                                                        
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Observación: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtObserVer" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="4"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>   
                                    <asp:Panel ID="panel1" runat="server">
                                        <!-- Campos Adicionales -->
                                    </asp:Panel>                                     
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Label ID="Label3" Visible="false" runat="server"></asp:Label>
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
                        <h3 id="editModalLabel">Modificar Usuario</h3>
                                            
                    </div>
                    <asp:UpdatePanel ID="upEdit" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="row">
                                    <asp:HiddenField ID="hClienteIDMod" runat="server" />                                                        
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Cédula: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCedulaEdit" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                                        
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Nombre: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Apellido: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtApellidoEdit" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Rol: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtRolEdit" runat="server" ClientIDMode="Static" CssClass="form-control" Enabled="false" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Correo: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCorreoEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Fecha de Nacimiento: </label>
                                        <div class="col-xs-6">                                                             
                                            <input runat="server" type='text' id="txtFechaNEdit2" class="form-control" />
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Estado Civíl: </label>
                                                            
                                        <div class="col-xs-6">                                                                
                                            <!--<asp:TextBox ID="txtEstadoCEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox> -->
                                            <asp:DropDownList runat="server" ID="txtEstCiv" CssClass="form-control" >
                                                <asp:ListItem Text="Soltero(a)" Value="S"  />
                                                <asp:ListItem Text="Casado(a)" Value="C"  />
                                                <asp:ListItem Text="Divorciado(a)" Value="D"  />
                                                <asp:ListItem Text="Viudo(a)" Value="V"  />
                                                <asp:ListItem Text="Otro(a)" Value="O"  />
                                            </asp:DropDownList>                                                               
                                        </div>
                                        <div class="col-xs-4"></div>                                                            
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Sexo: </label>
                                                             
                                        <div class="col-xs-6">                                                                                                                               
                                            <label class="radio-inline">
                                                <input  type="radio" runat="server" name="SexoOpcion" id="rdM" value="M" /> M
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" runat="server" name="SexoOpcion" id="rdF" value="F" /> F
                                            </label>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                                            
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Teléfono: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtTelefonoEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div> 
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Celular 1: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCelular1Edit" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Celular 2: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtCelular2Edit" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>    
                                        <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">EPS: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtEPSEdit" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>       
                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Observación: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtObserEdit" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>

                                        <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Contraseña: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtClave" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-2"></div>
                                        <label class="col-xs-2 control-label">Repita la Contraseña: </label>
                                        <div class="col-xs-6">
                                            <asp:TextBox ID="txtClave2" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>                                                                
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                    <asp:Panel ID="panel11" runat="server">
                                        <!-- Campos Adicionales -->
                                    </asp:Panel>  
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
                        <h3 id="delModalLabel">Eliminar Usuario</h3>
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

    $('#txtFechaNEdit2').datepicker({
        format: 'dd/mm/yyyy'
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