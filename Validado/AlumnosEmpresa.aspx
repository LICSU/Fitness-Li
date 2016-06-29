<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AlumnosEmpresa.aspx.cs" Inherits="LicsuWeb.Validado.AlumnosEmpresa" %>
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
            <div style="width: 90%; margin-right: 5%; margin-left: 2%; text-align: center">
                <asp:UpdatePanel ID="upCrudGrid" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6">
                                <asp:DropDownList ID="dplClientes" runat="server" CssClass="form-control col-lg-6"
                                        OnSelectedIndexChanged="dplClientes_SelectedIndexChanged" AutoPostBack="True" >
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-3"></div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6"><br /></div>
                            <div class="col-lg-3"></div>
                        </div> 
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6">
                                <asp:DropDownList ID="dplPlan" runat="server" CssClass="form-control col-lg-6"
                                        OnSelectedIndexChanged="dplPlan_SelectedIndexChanged" AutoPostBack="True" >
                                    </asp:DropDownList> 
                            </div>
                            <div class="col-lg-3"></div>
                        </div>  
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6"><br /></div>
                            <div class="col-lg-3"></div>
                        </div> 
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6"><asp:Button CssClass="btn btn-purple" runat="server" ID="btnAsignarPlan" Text="Asignar Plan" Enabled="false" OnClick="btnAsignarPlan_Click"/></div>
                            <div class="col-lg-3"></div>
                        </div>  
                        <div class="col-lg-12">
                            <div class="col-lg-3"></div>
                            <div class="col-lg-6"><br /></div>
                            <div class="col-lg-3"></div>
                        </div>                   
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="UsuarioID" CssClass="footable" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging"
                            EmptyDataText="No existen Alumnos Activos.." OnRowCommand="GridView1_RowCommand">
                            <Columns> 
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioID" runat="server" Visible="false" Enabled="false" Text='<%# Eval("UsuarioID") %>' />
                                        <asp:Label ID="UsuarioNombre" runat="server" Enabled="false" Text='<%# Eval("UsuarioNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cédula">
                                    <ItemTemplate>
                                        <asp:Label ID="UsuarioCedula" runat="server" Enabled="false" Text='<%# Eval("UsuarioCedula") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Empresa">
                                    <ItemTemplate>
                                        <asp:Label ID="ClienteNombre" runat="server" Enabled="false" Text='<%# Eval("ClienteNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Activo">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkActivo" runat="server" Enabled="false" Checked='<%# Eval("PlanActivo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>  
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                  <img src="img/loading.gif" class="img-responsive center-block">
                </ProgressTemplate>
                </asp:UpdateProgress>                        
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
                    <img src="../Images/cargando.gif" class="img-responsive center-block"/>
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


    $(document).ready(function () {
        $('#btnAsignarPlan').on('click', function () {
            $('#pleaseWaitDialog').modal('show');
        });
    });
</script>
    </form>
</body>
</html>