<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contactanos.aspx.cs" Inherits="LicsuWeb.Contactanos" %>
<!DOCTYPE html>
<html">
<head runat="server">
   <title>Contáctanos</title>
    <link href="css/font-awesome.css" rel="stylesheet" />   
    <link href="css/bootstrap.css" rel="stylesheet" />
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
            <li><a href="index.html">Inicio</a></li>
            <li><a href="Validado/Ingreso.aspx">Ingresar</a></li>
            <li><a href="Registro.aspx">Regístrate</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>
    <!-- Contenido pagina INICIO-->
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-4">
            <h2 class="pull-left">Contáctanos</h2>
            </div>               
        </div>
    </div>
    <hr />
    <form runat="server" id="form1" class="form-horizontal">
    <div class="row col-md-offset-2 col-md-10">
        <div class="form-group">
            <label class="col-sm-3 control-label">Nombre:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control" ID="txtNombre" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">Apellido:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control" ID="txtApellido" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">Teléfono:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control" ID="txtTelefono"  />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">Correo:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control" ID="txtEmail"  />
            </div>
        </div>

         <div class="form-group">
            <label class="col-sm-3 control-label">Asunto:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control" ID="txtAsunto"  />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">Mensaje:</label>
            <div class="col-sm-8">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="MultiLine" ID="txtMensaje" Rows="7"  />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-9 col-sm-offset-3">
                <asp:Button runat="server" ID="btnEnviar" CssClass="btn btn-success" Text="Enviar" OnClick="btnEnviar_Click" />
            </div>
        </div>
    </div>
    </form>
	<div id="confirmation" class="alert alert-success hidden">
		<span class="glyphicon glyphicon-star"></span> Mensaje enviado
	</div>
    <!-- Contenido pagina  FIN-->
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <script src="Scripts/formValidation/formValidation.min.js"></script>
    <script src="Scripts/formValidation/bootstrap.min.js"></script>
    <script src="Scripts/formValidation/language/es_ES.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $('#form1')
            .formValidation({
                framework: 'bootstrap',
                icon: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    txtNombre: {
                        validators: {
                            notEmpty: {
                                message: 'El nombre es requerido.'
                            }
                        }
                    },
                    txtApellido: {
                        validators: {
                            notEmpty: {
                                message: 'El apellido es requerido.'
                            }
                        }
                    },
                    txtTelefono: {
                        validators: {
                            notEmpty: {
                                message: 'El teléfono es requerido.'
                            },
                            regexp: {
                                message: 'Solo puede contener números.',
                                regexp: /\d/
                            }
                        }
                    },
                    txtEmail: {
                        validators: {
                            notEmpty: {
                                message: 'El correo es requerido.'
                            },
                            emailAddress: {
                                message: 'El formato del correo no es valido.'
                            }
                        }
                    },
                    txtAsunto: {
                        validators: {
                            notEmpty: {
                                message: 'El asunto es requerido.'
                            }
                        }
                    },
                    txtMensaje: {
                        validators: {
                            notEmpty: {
                                message: 'El mensaje es requerido.'
                            },
                            stringLength: {
                                max: 700,
                                message: 'El número máximo de caracteres es de 700.'
                            }
                        }
                    }
                }
            })
            .on("success.form.bv", function (e) {
            e.preventDefault();
            $("#form1").addClass("hidden");
            $("#confirmation").removeClass("hidden");
        });
    });
</script>

</body>
</html>
