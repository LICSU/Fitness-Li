<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="selectEmpresa1.aspx.cs" Inherits="LicsuWeb.selectEmpresa1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Licsu - Regístrate</title>
    <link href="css/font-awesome.css" rel="stylesheet" />   
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="Validado/css/bootstrap-datepicker.css" />
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
    <style type="text/css">
        .navbar-default .navbar-nav > li > a {
            font-family: Geneva, Verdana, Lucida Sans, Lucida Sans Unicode, sans-serif;
            color:#FFF !important;
            font-size: medium;
        }
        .navbar-default .navbar-nav > li > a:hover {
            color:#b0aeae !important;
            font-size: medium;
        }
        #form1 .selectContainer .form-control-feedback {
            right: 30px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-default navbar-static-top" style="background-color:#69008C; color:#FFF; height:100px" role="navigation">
      <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-navbar-collapse-up">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.html">
              <img src="Images/Logo_blanco.png" style="height:80px"/>
          </a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling  height="80px"-->
        <div class="collapse navbar-collapse" style="background-color:#69008C; margin-top:40px" id="bs-navbar-collapse-up">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="index.aspx">Inicio</a></li>
            <li><a href="Validado/Ingreso.aspx">Ingresar</a></li>
            <li><a href="Contactanos.aspx">Contáctanos</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>

    <!-- Contenido pagina INICIO-->
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-4">
            <h2 class="pull-left">Regístrate</h2>
            </div>               
        </div>
    </div>
    <hr />
    <form id="form1" runat="server" class="form-horizontal">
    <div class="row col-md-offset-2 col-md-10">
        <div class="form-group">
            <asp:Label ID="lblPlan" runat="server" AssociatedControlID="dplUnidad" CssClass="col-sm-3 control-label">Unidad de Negocio:</asp:Label>     
            <div class="col-sm-5 selectContainer">
                <asp:DropDownList runat="server" Enabled="false" ID="dplUnidad" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="dplUnidad_SelectedIndexChanged"></asp:DropDownList>
             </div>
        </div>        
    </div>

    <!-- Contenido pagina  FIN-->

<!---------------------------------- Modals --------------------------------->
    <!-- Modal PleaseWait-->
    <div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="clearfix">
                    <img src="Validado/img/loading.gif" class="img-responsive center-block">
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

    <script src="Validado/js/jquery-1.10.2.js"></script>
    <script src="Validado/js/bootstrap.min.js"></script>
    <script src="Scripts/formValidation/formValidation.min.js"></script>
    <script src="Scripts/formValidation/bootstrap.min.js"></script>
    <script src="Scripts/formValidation/language/es_ES.js"></script>
    <script src="Validado/js/bootstrap-datepicker.js"></script>

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
