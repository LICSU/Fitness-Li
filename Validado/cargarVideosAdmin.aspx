<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cargarVideosAdmin.aspx.cs" Inherits="LicsuWeb.Validado.cargarVideosAdmin" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Cargar Videos</title>
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
                <h2 class="pull-left">Cargar Videos</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
        <!-- Contenido --> 
        <asp:UpdatePanel ID="upCrudGrid" runat="server">
            <ContentTemplate>         
            <div class="row col-md-offset-2 col-md-10">
                <br />
            </div>
        
            <div class="row col-md-offset-2 col-md-10">
                <div class="col-lg-6">
                
                </div>
                <div class="col-lg-6">
                    <asp:Button runat="server" CssClass="btn btn-purple" ID="btnSubir" Text="Agregar" OnClick="btnSubir_Click" />
                </div>
            </div>      
            <div class="row col-md-offset-2 col-md-10">
                <br />
            </div>
        
            <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                DataKeyNames="PlanID" CssClass="table table-hover table-striped" PageSize="20"
                onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No existen Videos Cargados Aún">
                <Columns>
                    <asp:ButtonField CommandName="deleteRecord"
                        ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                        <ControlStyle></ControlStyle>
                    </asp:ButtonField>
                    <asp:TemplateField HeaderText="VideoUrl"  >
                        <ItemTemplate>
                            <asp:Label ID="VideoID" Visible="false" runat="server" Enabled="false" Text='<%# Eval("VideoID") %>' />
                            <asp:Label  ID="UrlVideo" runat="server" Enabled="false" Text='<%# Eval("UrlVideo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha Inicio"  >
                        <ItemTemplate>
                            <asp:Label  ID="FechaInicioVideo" runat="server" Enabled="false" Text='<%# Eval("FechaInicioVideo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha Fin" HeaderStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Label  ID="FechaFinVideo" runat="server" Enabled="false" Text='<%# Eval("FechaFinalVideo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Video" >
                        <ItemTemplate>
                            <asp:Label  ID="NumeroVideo" runat="server" Enabled="false" Text='<%# Eval("NumeroVideo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>                           
                </Columns>
            </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <!-- Fin del Contenido -->    
        <!-- Add Modal Starts here -->
        <div id="addModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="H1">Agregar Video</h3>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group">
                            <div class="col-xs-2"></div>
                            <label class="col-xs-2 control-label">Url Video: </label>
                            <div class="col-xs-6">
                                <asp:TextBox ID="txtUrlVideo" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                            </div>
                            <div class="col-xs-4"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-2"></div>
                            <label class="col-xs-2 control-label">Fecha de Inicio: </label>
                            <div class="col-xs-6">
                                 <asp:TextBox ID="txtFechaInicio" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                  
                            </div>
                            <div class="col-xs-4"></div>
                        </div>   
                        <div class="form-group">
                            <div class="col-xs-2"></div>
                            <label class="col-xs-2 control-label">Fecha de Inicio: </label>
                            <div class="col-xs-6">
                                 <asp:TextBox ID="txtFechaFin" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                  
                            </div>
                            <div class="col-xs-4"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-2"></div>
                            <label class="col-xs-2 control-label">Número de Video: </label>
                            <div class="col-xs-6">
                                 <asp:DropDownList runat="server" ID="dplVideos" CssClass="form-control">
                                     <asp:ListItem Text="Seleccione una Opción" Value=""></asp:ListItem>
                                     <asp:ListItem Text="Video 1" Value="video1"></asp:ListItem>
                                     <asp:ListItem Text="Video 2" Value="video2"></asp:ListItem>
                                     <asp:ListItem Text="Video 3" Value="video3"></asp:ListItem>
                                     <asp:ListItem Text="Video 4" Value="video4"></asp:ListItem>
                                     <asp:ListItem Text="Video 5" Value="video5"></asp:ListItem>
                                     <asp:ListItem Text="Video 6" Value="video6"></asp:ListItem>
                                     <asp:ListItem Text="Video 7" Value="video7"></asp:ListItem>
                                     <asp:ListItem Text="Video 8" Value="video8"></asp:ListItem>
                                     <asp:ListItem Text="Video 9" Value="video9"></asp:ListItem>
                                     <asp:ListItem Text="Video 10" Value="video10"></asp:ListItem>
                                 </asp:DropDownList>                                                             
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
                </div>
            </div>
        </div>
        <!-- Add Modal Ends here -->  
    <!-- Delete Record Modal Starts here-->
                            <div id="deleteModal"  class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button id="closeDelete" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="delModalLabel">Eliminar Archivo</h3>
                                        </div>
                                        <asp:UpdatePanel ID="upDel" runat="server">
                                            <ContentTemplate>
                                                <div class="modal-body">
                                                    ¿Seguro desea eliminar este registro?
                                                    <asp:HiddenField ID="hdArchivoID" runat="server" />
                                                    
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
