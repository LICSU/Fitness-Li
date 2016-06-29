<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucEncabezado.ascx.cs" Inherits="LicsuWeb.Validado.ucEncabezado" %>
 <!-- NAV TOP  -->
<nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
    <div class="row">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand licsu" href="#">LICSU</a> 
        </div>
        
    </div>
     <!-- Inicio barra superior -->
    <div class="row nueva">
        <div class="col-lg-3 col-sm-3  col-xs-3 pp">
            <asp:ImageButton CssClass="img2" ID="ImageButton1" ImageUrl="~/Images/logo_fitness.png" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="estadisticas" ImageUrl="~/Images/menu.png" OnClick="estadisticas_Click" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="medidas" ImageUrl="~/Images/medidas.png" OnClick="medidas_Click" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="ImageButton2" ImageUrl="~/Images/electro.png" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="ImageButton3" ImageUrl="~/Images/glucosa.png" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="ImageButton4" ImageUrl="~/Images/colesterol.png" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="ImageButton5" ImageUrl="~/Images/tension.png" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="ImageButton7" ImageUrl="~/Images/obligaciones.png" runat="server"/>
        </div>
        <div class="col-lg-1 col-sm-2  col-xs-3 cuadro">
            <asp:ImageButton CssClass="img1" ID="salir" ImageUrl="~/Images/salir.png" runat="server" OnClick="lnkCerrarSesion_Click"/>
        </div>
    </div>
    <!-- Fin barra superior -->
</nav>   

<!-- Estadisticas Modal Starts here -->
<div id="modalEstadisticas2" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="closeAdd" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="H1">Estadisticas y/o Diagnosticos</h3>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="modal-body">
                        <div class="alert alert-info luz" id="Div1" >
                            <strong>Aviso!</strong> A partir de Abril!
                        </div>
                        <asp:Label runat="server" ID="lblPrueba"></asp:Label>
                    </div>
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
<!-- Estadisticas Modal Ends here -->
<!-- Medidas Modal Starts here -->
<div id="modalMedidas" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="Button1" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="H2">Medidas</h3>
            </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="modal-body">
                        <div class="alert alert-info luz" id="blink" >
                            <strong>Aviso!</strong> A partir del 15 de Abril!
                        </div>  
                        <div class="row">
                            <asp:Image runat="server" ImageUrl="~/Images/medidas_1.jpg" />     
                        </div>
                        <div class="row">
                            <asp:Label CssClass="text-justify negro" runat="server" Text="Vamos a capturar de manera regular tus medidas y vas a poder llevar el registro del impacto de tu actividad en las medidas de tu cuerpo."></asp:Label>
                        </div>                                              
                    </div>
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
<!-- Medidas Modal Ends here -->
<script type="text/javascript">
    function MostrarEstadisticas2() {
        $('#modalEstadisticas2').modal('show');
        return true;
    }
    function MostrarMedidas() {
        $('#modalMedidas').modal('show');
        return true;
    }
    (function () {
        setInterval(function () {
            var el = document.getElementById('blink');
            if (el.className == 'luz') {
                el.className = 'luz on';
            } else {
                el.className = 'luz';
            }
        }, 500);

    })();
</script>
 <!-- /. NAV TOP  -->
