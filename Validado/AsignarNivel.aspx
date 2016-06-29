<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AsignarNivel.aspx.cs" Inherits="LicsuWeb.Validado.AsignarNivel" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Asignar Nivel</title>
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
            <h2 class="pull-left">Asignar Nivel</h2>
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
            <div style="width: 90%; margin-right: 5%; margin-left: 2%; text-align: center">
                <asp:UpdatePanel ID="upCrudGrid" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label class="control-label col-xs-3">Buscar: </label>
                                <div class="col-xs-5">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Cédula o Nombre"></asp:TextBox>
                                </div>
                                <div class="col-xs-3">
                                    <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                   
                                </div>
                                <div class="col-xs-1">
                                    <asp:ImageButton ID="ImgAgregar" runat="server" ImageUrl="~/Images/agregar.png" OnClick="Agregar_Click" />
                                </div>
                            </div>
                        </div>
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="AluNivClaseID" CssClass="table table-hover table-striped" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No existe ninguna Asignación">
                            <Columns>
                                <asp:ButtonField CommandName="ModificarNivel"
                                    ButtonType="Button" Text="Modificar" HeaderText="Modificar">
                                    <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="AluNivClaseID" runat="server" Enabled="false" Text='<%# Eval("AluNivClaseID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Apellido">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioApellido" runat="server" Enabled="false" Text='<%# Eval("UsuarioApellido") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:TemplateField HeaderText="Cédula">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:TemplateField HeaderText="Clase">
                                    <ItemTemplate>
                                        <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:TemplateField HeaderText="Nivel">
                                    <ItemTemplate>
                                        <asp:Label ID="NivelNombre" runat="server" Enabled="false" Text='<%# Eval("NivelNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:TemplateField HeaderText="Nivel" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="NivelID" runat="server" Enabled="false" Text='<%# Eval("NivelID") %>' />
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
                                <h3 id="H1">Asignar Nivel</h3>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <div class="row">
                                            <asp:HiddenField runat="server" ID="hdfAlumnoID" />
                                            <asp:HiddenField runat="server" ID="hdfClaseID" />
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Alumno: </label>
                                                <div class="col-xs-6">
                                                    <div class="col-xs-8" style="padding:0;">
                                                        <asp:TextBox ID="txtAlumnoAdd" runat="server" ClientIDMode="Static" CssClass="form-control" ></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-4" style="padding:0; text-align:right;">
                                                        <asp:Button ID="BuscarUsr" runat="server" Text="Buscar" CssClass="btn btn-purple"  OnClick="BuscarUsr_Click"/> 
                                                    </div>
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div> 
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Clase: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtClaseAdd" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Nivel: </label>
                                                <div class="col-xs-4">
                                                    <asp:DropDownList CssClass="form-control" ID="dplNivel" runat="server" ClientIDMode="Static"  ></asp:DropDownList>                                                               
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>                                 
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Label ID="Label3" Visible="false" runat="server"></asp:Label>
                                        <asp:Button ID="btnAdd" runat="server" Text="Asignar" CssClass="btn btn-purple"  OnClick="btnAdd_Click"/>
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
                                    DataKeyNames="AlumnoID"
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
                                        <asp:TemplateField HeaderText="Clase" HeaderStyle-CssClass="text-center">
                                            <ItemTemplate>
                                                <asp:Label ID="ClaseDescripcionB" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="ClaseIDB" runat="server" Enabled="false" Text='<%# Eval("ClaseID") %>' />
                                                <asp:Label ID="UsuarioIDB" runat="server" Enabled="false" Text='<%# Eval("AlumnoID") %>' />
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
                    </div>
                </div>
            </div>
            <!-- BUscar Modal Ends here -->
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
                                            <asp:HiddenField runat="server" ID="hdfAluNivClaseID" />
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Alumno: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtAlumnoMod" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Clase: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtClaseMod" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Nivel: </label>
                                                <div class="col-xs-4">
                                                    <asp:DropDownList CssClass="form-control" ID="dplNivelMod" runat="server" ClientIDMode="Static"  ></asp:DropDownList>                                                               
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
            </div>
            </div>
        </div>
        <!-- Contenido ...FIN... -->
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

