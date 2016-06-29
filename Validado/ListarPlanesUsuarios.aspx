<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListarPlanesUsuarios.aspx.cs" Inherits="LicsuWeb.Validado.ListarPlanesUsuarios" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Usuarios - Planes</title>
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
                <h2 class="pull-left">Usuarios - Planes</h2>

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
                <div class="col-lg-12">
                    <div class="form-group">
                        <asp:Label ID="lblFiltro" AssociatedControlID="dplEmpresas" runat="server" CssClass="control-label col-xs-3">Filtrar por Empresa: </asp:Label>
                        <div class="col-xs-5">
                            <asp:DropDownList ID="dplEmpresas" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dplEmpresas_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>
                    <asp:Label runat="server" ID="ERROR" Text=""></asp:Label>
                    <div class="form-group">
                        <label class="control-label col-xs-3">Buscar: </label>
                        <div class="col-xs-5">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Buscar"></asp:TextBox>
                        </div>
                        <div class="col-xs-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                            <asp:Button ID="btnArchivo" runat="server" Text="Generar Archivo"   CssClass="btn btn-purple" OnClick="btnArchivo_Click" />
                            
                        </div>
                    </div>
                </div>
                <asp:GridView ID="GridView1" runat="server" Width="95%" HorizontalAlign="Center"
                    AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="UsuarioID" CssClass="footable" PageSize="20"
                    onpageindexchanging="GridView1_PageIndexChanging" AllowSorting="true"
                    onrowcommand="GridView1_RowCommand"
                    EmptyDataText="No Existen Usuarios.">
                    <Columns> 
                        <asp:TemplateField HeaderText="Nombres"  >
                            <ItemTemplate>
                                <asp:Label Visible="false" ID="UsuarioID" runat="server" Enabled="false" Text='<%# Eval("UsuarioID") %>' /> 
                                <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>      
                        <asp:TemplateField HeaderText="Cédula"  >
                            <ItemTemplate>
                                <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Plan"  >
                            <ItemTemplate>
                                <asp:Label ID="PlanNombre" runat="server" Enabled="false" Text='<%# Eval("PlanNombre") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Clases"  >
                            <ItemTemplate>
                                <asp:Label ID="PlanClases" runat="server" Enabled="false" Text='<%# Eval("TotalR") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Clases"  >
                            <ItemTemplate>
                                <asp:Label ID="PlanClasesC" runat="server" Enabled="false" Text='<%# Eval("TotalC") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Activas" >
                            <ItemTemplate>
                                <asp:Label ID="PlanCantidadClases" runat="server" Enabled="false" Text='<%# Eval("PlanCantidadClases") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Vence" >
                            <ItemTemplate>
                                <asp:Label ID="PlanAlumnoFechaFin" runat="server" Enabled="false" Text='<%# Eval("PlanAlumnoFechaFin") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Empresa">
                            <ItemTemplate>
                                <asp:Label ID="ClienteNombre" runat="server" Enabled="false"  Text='<%# Eval("ClienteNombre") %>'/>
                                <asp:Label Visible="false" ID="ClienteID" runat="server" Enabled="false"  Text='<%# Eval("ClienteID") %>'/>
                            </ItemTemplate>
                        </asp:TemplateField>                      
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnArchivo" />
            </Triggers>
        </asp:UpdatePanel>        
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