<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ingreso.aspx.cs" Inherits="LicsuWeb.Validado.Ingreso"  %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Licsu</title>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/ingreso.css" rel="stylesheet" />
    <link href="../css/formValidation/formValidation.min.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="fondoIngreso">
    <div class="container">
        <div class="card card-container">
            <img class="profile-img" src="../Images/logo_fitness.png" alt="Usuario"/>
            <asp:Label ID="lblValidado" runat="server" Text="" Visible="False"></asp:Label>
            <form id="form1" runat="server" class="form-signin">
                <span id="reauth-email" class="reauth-email"></span>
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <div class="form-group">
                    <asp:TextBox ID="Usuario" runat="server" TextMode="SingleLine" ClientIDMode="Static" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                    <asp:HiddenField runat="server" ID="hfUsuarioActual" />
                </div>
                <div class="form-group">
                    <asp:TextBox ID="Clave" runat="server" TextMode="Password" ClientIDMode="Static" CssClass="form-control" placeholder="Clave"></asp:TextBox>
                    <asp:HiddenField runat="server" ID="hfClaveActual" />
                </div>
                <asp:Literal ID="Msj" runat="server"></asp:Literal>
                <div class="form-group">
                    <asp:Button ID="bAceptar" runat="server" Text="Aceptar" class="btn btn-lg btn-purple btn-block"  OnClick="bAceptar_Click" />
                </div>
                <div class="row" style="text-align:center;"><a href="../selectEmpresa1.aspx" class="text-center text-primary">Eres Nuevo ¡Regístrate!</a></div> 
            </form>
        </div>
        <asp:Label ID="lblError" runat="server" Text="Label" Visible="False"></asp:Label>
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
    </div>
    <script type="text/javascript" src="js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script src="js/formValidation/formValidation.min.js"></script>
    <script src="../Scripts/formValidation/language/es_ES.js"></script>
    <script src="js/formValidation/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#bAceptar').on('click', function () {
                $('#pleaseWaitDialog').modal('show');
            });

            $('#form1')
                .formValidation({
                    framework: 'bootstrap',
                    icon: {
                        valid: 'fa fa-check',
                        invalid: 'fa fa-times',
                        validating: 'fa fa-refresh'
                    },
                    fields: {
                        Usuario: {
                            validators: {
                                notEmpty: {
                                    message: 'El Usuario es requerido.'
                                }
                            }
                        },
                        Clave: {
                            validators: {
                                notEmpty: {
                                    message: 'La Clave es requerida.'
                                }
                            }
                        }
                    }
                })
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
</body>
</html>
