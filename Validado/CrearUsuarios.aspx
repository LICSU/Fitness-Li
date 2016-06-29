<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrearUsuarios.aspx.cs" Inherits="LicsuWeb.Validado.CrearUsuarios" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Licsu Crear Usuario</title>
<uc1:ucHeader runat="server" ID="ucHeader" />
    <link rel="stylesheet" href="../Content/bootstrap.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="css/bootstrap-datepicker.css" />
    <link href="../css/formValidation/formValidation.min.css" rel="stylesheet" />
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
                <h2 class="pull-left">Crear Usuarios</h2>
            </div>
        
            <div class="col-md-3 col-md-offset-5">
                <div class="form-group text-right">
                    
                </div>
            </div>
        </div>
    </div>
    <hr />
        <!-- Contenido -->  
        
        <div class="row col-md-offset-2 col-md-10">
        <asp:PlaceHolder ID="phPlan" runat="server">
        <!--<div class="form-group">
            <asp:Label ID="lblPlan" runat="server" AssociatedControlID="ddlPlan" CssClass="col-sm-3 control-label">Unidad de Negocio:</asp:Label>     
            <div class="col-sm-5 selectContainer">
                <asp:DropDownList runat="server" ID="ddlPlan" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlPlan_SelectedIndexChanged"></asp:DropDownList>
             </div>
        </div>-->
        
        <div id="pnlOtro" style="display:none">
            <div class="form-group">
                <asp:Label ID="lblOtroTipoEmpleado" runat="server" AssociatedControlID="txtOtroTipoEmpleado" CssClass="col-sm-3 control-label">Especifique Otro:</asp:Label>                                          
                <div class="col-sm-5">
                    <asp:TextBox ID="txtOtroTipoEmpleado"  runat="server" CssClass="col-sm-4 form-control" ></asp:TextBox>
                </div>
            </div>
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phSucursal" runat="server">
        <div class="form-group">
            <asp:Label ID="lblSucursal" runat="server" AssociatedControlID="ddlSucursal" CssClass="col-sm-3 control-label">Sucursal:</asp:Label>     
            <div class="col-sm-5 selectContainer">
                <asp:DropDownList runat="server" ID="ddlSucursal" CssClass="form-control"></asp:DropDownList>
             </div>
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phTipoUsuario" runat="server">
            <div class="form-group">
                <asp:Label ID="lblRol" runat="server" AssociatedControlID="txtRol" CssClass="col-sm-3 control-label">Tipo de Usuario:</asp:Label>     
                <div class="col-sm-5 selectContainer">
                    <asp:DropDownList runat="server" AutoPostBack="true" ID="txtRol" CssClass="form-control" OnSelectedIndexChanged="txtRol_SelectedIndexChanged"></asp:DropDownList>
                 </div>
            </div> 
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phTipoEmpleado" runat="server">
        <div class="form-group">
            <asp:Label ID="lblTipoEmpleado" runat="server" AssociatedControlID="ddlTipoEmpleado" CssClass="col-sm-3 control-label">Relación Laboral:</asp:Label>     
            <div class="col-sm-5 selectContainer">
                <asp:DropDownList runat="server" ID="ddlTipoEmpleado" CssClass="form-control" >
                    <asp:ListItem Text="Seleccione un Tipo" Value=""  />
                    <asp:ListItem Text="Empleado" Value="Empleado"  />
                    <asp:ListItem Text="Contratado/Temporal" Value="Contratado"  />
                    <asp:ListItem Text="Otro" Value="Otro"  />
                </asp:DropDownList>
             </div>
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phCedula" runat="server">
        <div class="form-group">
            <asp:Label ID="lblBono" runat="server" AssociatedControlID="txtBono"  CssClass="col-sm-3 control-label">Bono #:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtBono" runat="server" placeholder="Código de Prueba - Si lo Posee" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
                <asp:HiddenField runat="server" ID="hdfBono" />
            </div>                                   
        </div>
        <div class="form-group">
            <asp:Label ID="lblCedula" runat="server" AssociatedControlID="txtCedula" CssClass="col-sm-3 control-label">Cédula:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtCedula" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
                <asp:HiddenField runat="server" ID="hfCedulaActual" />
            </div>                                   
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phNombre" runat="server">
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" AssociatedControlID="txtNombre" CssClass="col-sm-3 control-label">Nombre:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtNombre" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>                                   
        </div>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" AssociatedControlID="txtApellido" CssClass="col-sm-3 control-label">Apellido:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtApellido" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>                                   
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phClave" runat="server">
        <div class="form-group">
            <asp:Label ID="Label10" runat="server" AssociatedControlID="txtClaveNueva" CssClass="col-sm-3 control-label">Contraseña:</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtClaveNueva" runat="server" TextMode="Password" CssClass="col-sm-4 form-control" ClientIDMode="Static" ></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label11" runat="server" AssociatedControlID="txtClaveRepetir" CssClass="col-sm-3 control-label">Confirmar contraseña:</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtClaveRepetir" runat="server" TextMode="Password" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phCorreo" runat="server">
        <div class="form-group">
            <asp:Label ID="Label4" runat="server" AssociatedControlID="txtCorreo" CssClass="col-sm-3 control-label">Correo:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>                                   
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phCelular" runat="server">
        <div class="form-group">
            <asp:Label ID="Label8" runat="server" AssociatedControlID="txtCelular" CssClass="col-sm-3 control-label">Celular:</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtCelular" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phCamposLicsu" runat="server">
        <div class="form-group">
            <asp:Label ID="Label9" runat="server" AssociatedControlID="txtCelular2" CssClass="col-sm-3 control-label">Celular 2:</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtCelular2" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static" ></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <asp:Label ID="Label7" runat="server" AssociatedControlID="txtTelefono" CssClass="col-sm-3 control-label">Teléfono fijo:</asp:Label>                                          
                <div class="col-sm-5">
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static" ></asp:TextBox>
                </div>
        </div>

        <div class="form-group">
            <asp:Label ID="Label5" runat="server" AssociatedControlID="txtFechaNacimiento" CssClass="col-sm-3 control-label">Fecha Nacimiento:</asp:Label>     
            <div class="col-sm-5">    
                <input title="txtFechaNacimiento" runat="server"  type='text' id="txtFecNac1" class="form-control" />                           
                <!--<asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa" ClientIDMode="Static"></asp:TextBox>-->
             </div>
        </div>

        <div class="form-group">
            <asp:Label ID="Label6" runat="server" AssociatedControlID="ddlEstadoCivil" CssClass="col-sm-3 control-label">Estado Civíl:</asp:Label>     
            <div class="col-sm-5">
                <asp:DropDownList runat="server" ID="ddlEstadoCivil" CssClass="form-control" >
                    <asp:ListItem Text="Soltero(a)" Value="S"  />
                    <asp:ListItem Text="Casado(a)" Value="C"  />
                    <asp:ListItem Text="Divorciado(a)" Value="D"  />
                    <asp:ListItem Text="Viudo(a)" Value="V"  />
                    <asp:ListItem Text="Otro(a)" Value="O"  />
                </asp:DropDownList>
             </div>
        </div>

        <div class="form-group">
           <label class="col-sm-3 control-label">Sexo:</label>
            <div class="col-sm-5">
                 <label class="radio-inline">
                    <input  type="radio" runat="server" name="SexoOpcion" id="rdM" value="M" checked/> M
                </label>
                <label class="radio-inline">
                  <input type="radio" runat="server" name="SexoOpcion" id="rdF" value="F" /> F
                </label>
            </div>
        </div>
       <asp:PlaceHolder ID="phProfesor" runat="server">
       <div class="form-group">
            <asp:Label ID="Label3" runat="server" AssociatedControlID="txtRiesgos" CssClass="col-sm-3 control-label">Riesgos:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtRiesgos" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>                                   
        </div>
        
        <div class="form-group">
            <asp:Label ID="Label13" runat="server" AssociatedControlID="txtPension" CssClass="col-sm-3 control-label">Pensión:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtPension" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>                                   
        </div>
        </asp:PlaceHolder> 
        <div class="form-group">
            <asp:Label ID="Label12" runat="server" AssociatedControlID="txtEPS" CssClass="col-sm-3 control-label">EPS:</asp:Label> 
            <div class="col-sm-5">
                <asp:TextBox ID="txtEPS" runat="server" CssClass="col-sm-4 form-control" ClientIDMode="Static"></asp:TextBox>
            </div>                                   
        </div>

        </asp:PlaceHolder>

        <asp:Panel ID="panel1" runat="server">
            <!-- Campos Adicionales -->
        </asp:Panel>

        <asp:PlaceHolder ID="phObservacion" runat="server">
        <div class="form-group">
            <label class="col-sm-3 control-label">Observación:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtObservacion" Rows="4"
                   placeholder="¿Algún antecedente o condición física que debamos conocer?" ClientIDMode="Static"  />
            </div>
        </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="phPlanActivar" runat="server">
            <div class="form-group">
            <label class="col-sm-3 control-label">¿Desea Activar el Plan?</label>
            <div class="col-sm-5">
                <asp:DropDownList runat="server"  ID="dplActivarPlan" CssClass="form-control">
                    <asp:ListItem Text="Seleccione un Valor" Value=""></asp:ListItem>
                    <asp:ListItem Text="Si" Value="Si"></asp:ListItem>
                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        </asp:PlaceHolder>
        <%--<div class="form-group">
            <asp:Label ID="Label12" runat="server" AssociatedControlID="FileUpload1" CssClass="col-sm-3 control-label">Foto:</asp:Label>                                          
            <div class="col-sm-5">
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Image ID="imgFotoPerfil" runat="server" Height="179px" Width="233px" />
            </div>
        </div>--%>
        
        <asp:PlaceHolder ID="phRegistrar" runat="server">
        <div class="form-group">
            <div class="col-sm-offset-7 col-sm-3">
                <asp:Button ID="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click" Text="Registrar" />
            </div>
        </div>
        </asp:PlaceHolder>        
    </div>
    
    
        <!-- Fin del Contenido -->  
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
                    <img src="../Images/cargando.gif" class="img-responsive center-block" />
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
    
    <!-- Msj Modal -->
    <div class="modal fade" id="Msjmodal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
            <h4 class="modal-title"><label id="lblMsjTitle1"></label></h4>
          </div>
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-1">
                        <span id="icoModal1" class="fa fa-times fa-2x text-danger"></span>
                    </div>
                    <div class="col-md-11">
                        <label id="lblMsjModal1"></label>
                    </div>
                </div>
                <div class="clearfix"></div>      </div><!-- /modal-body -->
          <div class="modal-footer">
                <asp:Button runat="server" CssClass="btn btn-default" ID="btnIr" OnClick="btnIr_Click"  Text="Cerrar Cerrar"></asp:Button>
          </div>
        </div> 
      </div>
    </div>
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>

<script src="../Scripts/formValidation/formValidation.min.js"></script>
<script src="../Scripts/formValidation/bootstrap.min.js"></script>
<script src="../Scripts/formValidation/language/es_ES.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript">

    $('#txtFecNac1').datepicker({ format: 'mm/dd/yyyy' });

    $(document).ready(function () {
        

        function EndRequestHandler(sender, args) {
            $('#txtFecNac1').datepicker({ format: 'mm/dd/yyyy' });
        }

    });

        $(document).ready(function () {
            $(window).load(function () {
                if (document.getElementById("ddlTipoEmpleado")) {
                    var vddlTipoEmpleado = document.getElementById("ddlTipoEmpleado");
                    if (vddlTipoEmpleado.value == "Otro")
                        $('#pnlOtro').show();
                    else
                        $('#pnlOtro').hide();
                }
            });
            $('#ddlTipoEmpleado').on('change', function () {
                if (this.value == "Otro")
                { var vtxtOtroTipoEmpleado = document.getElementById("txtOtroTipoEmpleado"); vtxtOtroTipoEmpleado.value = ""; $('#pnlOtro').show(); }
                else
                { $('#pnlOtro').hide(); }
            }); 
            $('#txtRol').on('change', function () {
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
                        ddlTipoEmpleado: {
                            validators: {
                                notEmpty: {
                                    message: 'La relación laboral es requerida.'
                                }
                            }
                        },
                        txtRol: {
                            validators: {
                                notEmpty: {
                                    message: 'El Rol es requerido.'
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
                        txtClaveNueva: {
                            validators: {
                                notEmpty: {
                                    message: 'La clave es requerida.'
                                }
                            }
                        },
                        txtClaveRepetir: {
                            validators: {
                                notEmpty: {
                                    message: 'La confirmación es requerida.'
                                },
                                identical: {
                                    field: 'txtClaveNueva',
                                    message: 'La clave y su confirmación deben ser iguales'
                                }
                            }
                        },
                        txtFechaNacimiento: {
                            validators: {
                                date: {
                                    format: 'DD/MM/YYYY',
                                    message: 'El formato de la fecha es invalido.'
                                }
                            }
                        },
                        txtCorreo: {
                            validators: {
                                emailAddress: {
                                    message: 'El formato del correo no es valido.'
                                }
                            }
                        },
                        txtTelefono: {
                            validators: {
                                regexp: {
                                    message: 'Solo puede contener números.',
                                    regexp: /\d/
                                }
                            }
                        },
                        txtCelular: {
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
        function MostrarMsjModal2(message, title, ccsclas) {
            var vIcoModal = document.getElementById("icoModal1");
            vIcoModal.className = ccsclas;
            $('#lblMsjTitle1').html(title);
            $('#lblMsjModal1').html(message);
            $('#Msjmodal2').modal('show');
            return true;
        }
    </script>
    </form>
</body>
</html>