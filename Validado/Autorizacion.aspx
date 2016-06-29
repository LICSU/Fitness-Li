<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Autorizacion.aspx.cs" Inherits="LicsuWeb.Validado.Autorizacion" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Usuarios</title>
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
                <h2 class="pull-left">Usuarios Bloqueados</h2>

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
                        <div class="row">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6">
                                <div class="col-lg-9 col-xs-8 text-right">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Nombre o Cédula"></asp:TextBox>
                                </div>
                                <div class="col-lg-3 col-xs-4 text-left">
                                    <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />                                                                                        
                                </div>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                        <br />
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="AutorizacionID" CssClass="footable" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging">
                            <Columns>
                                <asp:ButtonField CommandName="editRecord"
                                    ButtonType="Image" ImageUrl="~/Images/editar.png" HeaderText="Mod">
                                    <ControlStyle ></ControlStyle>
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                        <asp:Label ID="AutorizacionID" runat="server" Visible="false"  Enabled="false" Text='<%# Eval("AutorizacionID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cédula">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bloqueado">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="AutorizacionActivo" runat="server" Enabled="false" Checked='<%# Eval("AutorizacionActivo") %>' />
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
                                <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h3 id="editModalLabel">Modificar Usuario</h3>                                            
                            </div>
                            <asp:UpdatePanel ID="upEdit" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <div class="row">
                                            <asp:HiddenField ID="hAutorizacionMod" runat="server" /> 
                                                <div class="form-group">
                                                <label class="col-xs-4 control-label">Nombre: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox Enabled="false" ID="txtNombreEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Cédula: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox Enabled="false" ID="txtCedulaEdit" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>     
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label">Bloquear: </label>
                                                <div class="col-xs-6">
                                                    <asp:CheckBox ID="chkBloquearEdit" runat="server" ClientIDMode="Static" CssClass="checkbox"></asp:CheckBox>                                                                
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
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
                <!-- Edit Modal Ends here -->
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
