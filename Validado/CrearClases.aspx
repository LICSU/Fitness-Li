<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrearClases.aspx.cs" Inherits="LicsuWeb.Validado.CrearClases" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Crear Clase</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server" class="form-horizontal">
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
                <h2 class="pull-left">Crear Clase</h2>

            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="row col-md-offset-2 col-md-10">
           <!-- Crear el Módulo de Registro -->
            <div class="form-group">
                <asp:Label ID="errorIns" runat="server" CssClass="col-md-10 control-label" Text="Error" Visible="false"></asp:Label>   
            </div>
            <div class="form-group">
                <asp:Label ID="lblPlan" runat="server" AssociatedControlID="ddlPlan" CssClass="col-sm-3 control-label">Unidad de Negocio:</asp:Label>     
                <div class="col-sm-5 selectContainer">
                    <asp:DropDownList runat="server" ID="ddlPlan" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlPlan_SelectedIndexChanged"></asp:DropDownList>
                 </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblSucursal" CssClass="col-sm-3 control-label" Text="Sucursal: " AssociatedControlID="txtSucursal"></asp:Label>
                <div class="col-sm-5">
                    <asp:DropDownList runat="server" ID="txtSucursal" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblRol" runat="server" AssociatedControlID="txtRol" CssClass="col-sm-3 control-label">Tipo de Usuario:</asp:Label>     
                <div class="col-sm-5 selectContainer">
                    <asp:DropDownList runat="server" ID="txtRol" CssClass="form-control" OnSelectedIndexChanged="txtRol_SelectedIndexChanged"></asp:DropDownList>
                 </div>
            </div> 
        <!--<asp:PlaceHolder ID="phTipoEmpleado" Visible="false" runat="server">
            <div class="form-group">
                <asp:Label ID="lblTipoEmpleado" runat="server" AssociatedControlID="ddlTipoEmpleado" CssClass="col-sm-3 control-label">Relación Laboral:</asp:Label>     
                <div class="col-sm-5 selectContainer">
                    <asp:DropDownList runat="server" ID="ddlTipoEmpleado" CssClass="form-control" >
                        <asp:ListItem Text="Empleado" Value="Empleado"  />
                        <asp:ListItem Text="Practicante" Value="Practicante"  />
                        <asp:ListItem Text="Contratista Temporal" Value="Contratista Temporal"  />
                        <asp:ListItem Text="Asesor Independiente" Value="Asesor Independiente"  />
                        <asp:ListItem Text="Otro" Value="Otro"  />
                    </asp:DropDownList>
                 </div>
            </div>     
            </asp:PlaceHolder> -->
        <div class="form-group">
            <asp:Label ID="lblCedula" runat="server" AssociatedControlID="txtCedula" CssClass="col-sm-3 control-label">Cédula:</asp:Label> 
            <div class="col-sm-5">
               <asp:TextBox ID="txtCedula" runat="server" CssClass="col-sm-4 form-control" placeholder="Cédula"></asp:TextBox>
            </div>                                   
        </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblClave" CssClass="col-sm-3 control-label" Text="Contraseña: " AssociatedControlID="txtContrasenha"></asp:Label>
                <div class="col-sm-5">
                    <asp:TextBox runat="server" ID="txtContrasenha" CssClass="form-control" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="Label1" CssClass="col-sm-3 control-label" Text="Repita Contraseña: " AssociatedControlID="txtContrasenha2"></asp:Label>
                <div class="col-sm-5">
                    <asp:TextBox runat="server" ID="txtContrasenha2" CssClass="form-control" placeholder="Repita la Contraseña" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <asp:PlaceHolder runat="server" ID="grupoLicsu">
                <div class="form-group">
                    <asp:Label runat="server" ID="lblNombre" CssClass="col-sm-3 control-label" Text="Nombre: " AssociatedControlID="txtNombre"></asp:Label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                    </div>
                </div>
            
                <div class="form-group">
                    <asp:Label runat="server" ID="lblApellido" CssClass="col-sm-3 control-label" Text="Apellido: " AssociatedControlID="txtApellido"></asp:Label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" placeholder="Apellido"></asp:TextBox>
                    </div>
                </div>
                <!--<div class="form-group">
                    <asp:Label ID="Label12" runat="server" AssociatedControlID="FileUpload1" CssClass="col-sm-3 control-label">Foto:</asp:Label>                                          
                    <div class="col-sm-5">
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:Image ID="imgFotoPerfil" runat="server" Height="179px" Width="233px" />
                    </div>
                </div>-->
                <div class="form-group">
                    <asp:Label runat="server" ID="lblEmail" CssClass="col-sm-3 control-label"><strong>Email: </strong></asp:Label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"  placeholder="correo@ejemplo.com"></asp:TextBox> 
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblFecNac" CssClass="col-sm-3 control-label" ><strong>Fecha de Nacimiento: </strong></asp:Label>
                    <div class="col-sm-5">  
                        <asp:TextBox runat="server" ID="txtFecNac"  CssClass="form-control" placeholder="dd/mm/yyyy" Text=""></asp:TextBox> 
                        <!--<asp:Calendar runat="server" TargetControlID="Date1" CssClass="ClassName"  Format="dd/MM/yyyy" PopupButtonID="Image1" > </asp:Calendar> -->
                                 
                    </div>
                </div>
                <div class="form-group">
                <asp:Label ID="lblEstCiv" runat="server" AssociatedControlID="txtEstCiv" CssClass="col-sm-3 control-label">Estado Civíl: </asp:Label>     
                    <div class="col-sm-5">
                        <asp:DropDownList runat="server" ID="txtEstCiv" CssClass="form-control" >
                            <asp:ListItem Text="Soltero(a)" Value="S"  />
                            <asp:ListItem Text="Casado(a)" Value="C"  />
                            <asp:ListItem Text="Divorciado(a)" Value="D"  />
                            <asp:ListItem Text="Viudo(a)" Value="V"  />
                            <asp:ListItem Text="Otro(a)" Value="O"  />
                        </asp:DropDownList>
                     </div>
                </div>
                <div class="form-group">
                   <label class="col-sm-3 control-label">Sexo: </label>
                    <div class="col-sm-5">
                         <label class="radio-inline">
                            <input  type="radio" runat="server" name="SexoOpcion" id="rdM" value="M" /> M
                        </label>
                        <label class="radio-inline">
                          <input type="radio" runat="server" name="SexoOpcion" id="rdF" value="F" /> F
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblFijo" CssClass="col-sm-3 control-label" Text="Teléfono Fijo: " AssociatedControlID="TxtFijo"></asp:Label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" ID="TxtFijo" CssClass="form-control" placeholder="Teléfono Fijo"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblCel1" CssClass="col-sm-3 control-label" Text="Teléfono Celular 1: " AssociatedControlID="TxtFijo"></asp:Label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" ID="txtCelular1" CssClass="form-control" placeholder="Teléfono Celular"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblCel2" CssClass="col-sm-3 control-label" Text="Teléfono Celular 1: " AssociatedControlID="TxtFijo"></asp:Label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" ID="txtCelular2" CssClass="form-control" placeholder="Teléfono Celular"></asp:TextBox>
                    </div>
                </div>
            </asp:PlaceHolder>
            <div class="form-group">
                <asp:Label runat="server" ID="lblEps" CssClass="col-sm-3 control-label" Text="EPS: " AssociatedControlID="TxtEps"></asp:Label>
                <div class="col-sm-5">
                    <asp:TextBox runat="server" ID="txtEps" CssClass="form-control" placeholder="EPS"></asp:TextBox>
                </div>
            </div>
            <asp:PlaceHolder ID="phObservacion" runat="server">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Observación:</label>
                    <div class="col-sm-5">
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtObservacion" Rows="4"
                           placeholder="¿Algún antecedente o condición física que debamos conocer?" ClientIDMode="Static"  />
                    </div>
                </div>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="phRegistrar" runat="server">
        <div class="form-group">
            <div class="col-sm-9">
                <asp:Button ID="btnAdd" CssClass="btn btn-lg btn-purple btn-block" runat="server" OnClick="btnAdd_Click" Text="Registrar" />
            </div>
        </div>
        </asp:PlaceHolder>            
        </div>

          </div>
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
                        txtCedula: {
                            validators: {
                                notEmpty: {
                                    message: 'La cédula es requerida.'
                                },
                                regexp: {
                                    message: 'Solo puede contener números.',
                                    regexp: /\d/
                                }
                            }
                        },
                        ddlPlan: {
                            validators: {
                                notEmpty: {
                                    message: 'El plan es requerido.'
                                }
                            }
                        },
                        txtRol: {
                            validators: {
                                notEmpty: {
                                    message: 'El rol es requerido.'
                                }
                            }
                        },
                        ddlTipoEmpleado: {
                            validators: {
                                notEmpty: {
                                    message: 'La relación laboral es requerida.'
                                }
                            }
                        },
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
                        txtContrasenha: {
                            validators: {
                                notEmpty: {
                                    message: 'La clave es requerida.'
                                }
                            }
                        },
                        txtContrasenha2: {
                            validators: {
                                notEmpty: {
                                    message: 'La confirmación es requerida.'
                                },
                                identical: {
                                    field: 'txtContrasenha',
                                    message: 'La clave y su confirmación deben ser iguales'
                                }
                            }
                        },
                        txtFecNac: {
                            validators: {
                                date: {
                                    format: 'DD/MM/YYYY',
                                    message: 'El formato de la fecha es invalido.'
                                }
                            }
                        },
                        txtEmail: {
                            validators: {
                                emailAddress: {
                                    message: 'El formato del correo no es valido.'
                                }
                            }
                        },
                        TxtFijo: {
                            validators: {
                                regexp: {
                                    message: 'Solo puede contener números.',
                                    regexp: /\d/
                                }
                            }
                        },
                        txtCelular1: {
                            validators: {
                                regexp: {
                                    message: 'Solo puede contener números.',
                                    regexp: /\d/
                                }
                            }
                        },
                        txtCelular2: {
                            validators: {
                                regexp: {
                                    message: 'Solo puede contener números.',
                                    regexp: /\d/
                                }
                            }
                        },
                        txtObservacion: {
                            validators: {
                                stringLength: {
                                    max: 250,
                                    message: 'El número máximo de caracteres es de 250.'
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
    </form>
</body>
</html>
