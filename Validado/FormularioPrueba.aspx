﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormularioPrueba.aspx.cs" Inherits="LicsuWeb.Validado.FormularioPrueba" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Formulario de Prueba</title>
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
    <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
    <div id="page-inner">
        <!-- Contenido pagina -->
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-4">
                    <h2 class="pull-left">Formulario de Prueba</h2>
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
                    <div class="row">                      
                        <asp:Panel ID="panel1" runat="server">
                            
                        </asp:Panel>
                        <div class="form-group">
                            <div class="col-xs-6">
                                <asp:Button ID="btnAdd" runat="server" Text="Agregar" CssClass="btn btn-purple"  OnClick="btnAdd_Click"/>
                            </div>
                            <div class="col-xs-4"></div>
                        </div>
                    </div>                    
                </ContentTemplate>
            </asp:UpdatePanel>            
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
    <<!-- Msj Modal -->
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
<script src="../Scripts/formValidation/formValidation.min.js"></script>
    <script src="../Scripts/formValidation/bootstrap.min.js"></script>
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


