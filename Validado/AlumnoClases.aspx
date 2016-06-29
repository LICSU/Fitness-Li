<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AlumnoClases.aspx.cs" Inherits="LicsuWeb.Validado.AlumnoClases" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Clases Alumno</title>
	<!-- BOOTSTRAP STYLES-->
    <link href="css/bootstrap.css" rel="stylesheet" />
    <!-- FONTAWESOME STYLES-->
    <link href="css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLES-->
    <link href="css/custom.css" rel="stylesheet" />
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
                    <h2 class="pull-left">Clases Alumno</h2>
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
                                    <asp:DropDownList OnSelectedIndexChanged="dplClasesUsuario_SelectedIndexChanged" CssClass="form-control" runat="server" ID="dplClasesUsuario" AutoPostBack="true"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                            OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                            DataKeyNames="AluNivClaseID" CssClass="table table-hover table-striped" PageSize="20"
                            onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="El alumno no posee Clases">
                            <Columns>
                                <asp:ButtonField CommandName="Evaluar"
                                    ButtonType="Button" Text="Evaluar" HeaderText="Evaluar">
                                    <ControlStyle CssClass="btn btn-purple"></ControlStyle>
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="AluNivClaseID" runat="server" Enabled="false" Text='<%# Eval("AluNivClaseID") %>' />
                                        <asp:Label ID="ClaseElemNivID" runat="server" Enabled="false" Text='<%# Eval("ClaseElemNivID") %>' />
                                        <asp:Label ID="ClaseID" runat="server" Enabled="false" Text='<%# Eval("ClaseID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Clase">
                                    <ItemTemplate>
                                        <asp:Label ID="ClaseDescripcion" runat="server" Enabled="false" Text='<%# Eval("ClaseDescripcion") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Elemento">
                                    <ItemTemplate>
                                        <asp:Label ID="ElementoNombre" runat="server" Enabled="false" Text='<%# Eval("ElementoNombre") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>                                                                                           
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
                <!-- Edit Modal Starts here -->
                <div id="modalEvaluar" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button id="closeEdit" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h3 id="editModalLabel">Evaluar Elemento</h3>
                                            
                            </div>
                            <asp:UpdatePanel ID="upEdit" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <div class="row">
                                            <asp:HiddenField runat="server" ID="hdfAluNivClaseID" />
                                            <asp:HiddenField runat="server" ID="hdfClaseElemNivID" />
                                            <asp:HiddenField runat="server" ID="hdfClaseID" />
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Clase: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtClaseEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Elemento: </label>
                                                <div class="col-xs-6">
                                                    <asp:TextBox ID="txtElementoEdit" runat="server" Enabled="false" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-2"></div>
                                                <label class="col-xs-2 control-label">Calificación: </label>
                                                <div class="col-xs-4">
                                                    <asp:DropDownList CssClass="form-control" ID="dplCalificacion" runat="server" ClientIDMode="Static"  ></asp:DropDownList>                                                               
                                                </div>
                                                <div class="col-xs-4"></div>
                                            </div>               
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Label ID="lblResult" Visible="false" runat="server"></asp:Label>
                                        <asp:Button ID="btnSave" runat="server" Text="Evaluar" CssClass="btn btn-purple" OnClick="btnSave_Click" />
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



