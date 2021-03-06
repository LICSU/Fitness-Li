﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Salones.aspx.cs" Inherits="LicsuWeb.Validado.Salones" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Gestión de Salones</title>
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
                <h2 class="pull-left">Gestión de Salones</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
    <!-- Contenido -->  
    <div class="row">        
    <asp:UpdatePanel ID="upCrudGrid" runat="server">
        <ContentTemplate>
            <div class="col-lg-12">
                <div class="form-group">
                    <label class="control-label col-xs-3">Buscar: </label>
                    <div class="col-xs-5">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Salón"></asp:TextBox>
                    </div>
                    <div class="col-xs-4">
                        <asp:Button ID="btnSearch" runat="server" Text="Buscar"  CssClass="btn btn-purple" OnClick="btnSearch_Click" />
                        <asp:ImageButton ID="Add" runat="server" ImageUrl="~/Images/agregar.png" OnClick="Agregar_Click" />            
                    </div>
                </div>               
            </div>
            <asp:GridView ID="GridView1" runat="server" Width="90%" HorizontalAlign="Center"
                OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                DataKeyNames="SalonID" CssClass="footable" PageSize="20"
                onpageindexchanging="GridView1_PageIndexChanging" EmptyDataText="No existen salones registrados.">
                <Columns>
                    <asp:ButtonField CommandName="deleteRecord"
                        ButtonType="Image" ImageUrl="~/Images/eliminar.png" HeaderText="Eli">
                        <ControlStyle ></ControlStyle>
                    </asp:ButtonField>
                    <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                            <asp:Label Visible="false" ID="SalonID" runat="server" Enabled="false" Text='<%# Eval("SalonID") %>' />
                            <asp:Label ID="SalonNombre" runat="server" Enabled="false" Text='<%# Eval("SalonNombre") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Descripción">
                        <ItemTemplate>
                            <asp:Label ID="SalonDescripcion" runat="server" Enabled="false" Text='<%# Eval("SalonDescripcion") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>      
                    <asp:TemplateField HeaderText="Frente">
                        <ItemTemplate>
                            <asp:Label ID="frenteSalon" runat="server" Enabled="false" Text='<%# Eval("frenteSalon") %>' />
                        </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Forma">
                        <ItemTemplate>
                            <asp:Label ID="formaSalon" runat="server" Enabled="false" Text='<%# Eval("formaSalon") %>' />
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
                    <h3 id="H1">Agregar Salón</h3>
                </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Nombre: </label>
                                <div class="col-xs-6">
                                    <asp:TextBox ID="txtNombreAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                </div>
                                <div class="col-xs-2"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Descripción: </label>
                                <div class="col-xs-6">
                                    <asp:TextBox ID="txtDescripcionAdd" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>                                                                
                                </div>
                                <div class="col-xs-2"></div>
                            </div>   
                            <div class="form-group">
                                <div class="col-xs-4"></div>
                                <div class="col-lg-6">
                                    <asp:Image ImageAlign="Middle" runat="server" ImageUrl="~/Validado/Imagenes/imagenEjemplo.jpg" CssClass="img-responsive"/>
                                </div>
                                <div class="col-xs-2"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Frente: </label>
                                <div class="col-xs-6">
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="dplFrente" ClientIDMode="Static" >
                                            <asp:ListItem Text="Seleccione el Frente" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Frente A" Value="frenteA"></asp:ListItem>
                                            <asp:ListItem Text="Frente B" Value="frenteB"></asp:ListItem>
                                            <asp:ListItem Text="Frente C" Value="frenteC"></asp:ListItem>
                                            <asp:ListItem Text="Frente D" Value="frenteD"></asp:ListItem>
                                        </asp:DropDownList>                                                        
                                </div>
                                <div class="col-xs-2"></div>
                            </div>    
                            <div class="form-group">
                                <label class="col-xs-4 control-label">Forma: </label>
                                <div class="col-xs-6">
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="dplFroma" ClientIDMode="Static" >
                                            <asp:ListItem Text="Seleccione la Forma" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Rectangular" Value="Rectangular"></asp:ListItem>
                                            <asp:ListItem Text="Cuadrado" Value="Cuadrado"></asp:ListItem>
                                        </asp:DropDownList>                                                        
                                </div>
                                <div class="col-xs-2"></div>
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
                    <h3 id="delModalLabel">Eliminar Salón</h3>
                </div>
                <asp:UpdatePanel ID="upDel" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            ¿Seguro desea eliminar este registro?
                            <asp:HiddenField ID="hSalonNombreeDel" runat="server" />
                            <asp:HiddenField ID="hSalonDel" runat="server" />
                                                    
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
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <img src="img/loading.gif" class="img-responsive center-block">
        </ProgressTemplate>
    </asp:UpdateProgress>
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
