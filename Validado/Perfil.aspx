<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="LicsuWeb.Validado.Perfil" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc1" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc2" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title id="Title1" runat="server">Licsu Perfíl</title>
    <uc1:ucHeader runat="server" ID="ucHeader" />
    <!-- VALIDATIONS-->
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
   <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
<%-- <asp:ScriptManager runat="server"></asp:ScriptManager>--%>
    <uc2:ucEncabezado runat="server" id="ucEncabezado" />
<div id="wrapper">
<!-- Menu superior y lateral -->
<uc1:ucMenu runat="server" ID="ucMenu" />

    <!--  PAGE WRAPPER  -->
    <div id="page-wrapper" >
        
        <div id="page-inner">
        <!-- Contenido pagina -->
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-4">
                    <h2 class="pull-left">Actualizar</h2>

                    </div>               
                    <div class="col-md-3 col-md-offset-5">
                        <div class="form-group text-right">
                            <!--<asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-default" > Regresar</asp:HyperLink>-->
                            
                        </div>
                    </div>
                </div>
            </div>
             <hr />
 

    <div class="form-horizontal">
     
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtNombre" CssClass="col-sm-3 control-label">Nombre</asp:Label> 
        <div class="col-sm-5">
            <asp:TextBox ID="txtNombre" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
        </div>                                   
    </div>
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtApellido" CssClass="col-sm-3 control-label">Apellido</asp:Label> 
        <div class="col-sm-5">
            <asp:TextBox ID="txtApellido" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
        </div>                                   
    </div>

    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtCedula" CssClass="col-sm-3 control-label">Cédula</asp:Label> 
        <div class="col-sm-5">
            <asp:TextBox ID="txtCedula" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
        </div>                                   
    </div>

    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-sm-3 control-label">E-Mail</asp:Label> 
        <div class="col-sm-5">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
        </div>                                   
    </div>

    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtFechaNacimiento" CssClass="col-sm-3 control-label">Fecha Nacimiento</asp:Label>     
        <div class="col-sm-5">                               
            <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="col-sm-4 form-control" placeholder="dd/mm/aaaa"></asp:TextBox>
         </div>
    </div>

    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="ddlEstadoCivil" CssClass="col-sm-3 control-label">Estado Civíl</asp:Label>     
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
       <label class="col-sm-3 control-label">Sexo</label>
        <div class="col-sm-5">
             <label class="radio-inline">
                <input  type="radio" runat="server" name="SexoOpcion" id="rdM" value="M" checked="true"/> M
            </label>
            <label class="radio-inline">
              <input type="radio" runat="server" name="SexoOpcion" id="rdF" value="F" /> F
            </label>
        </div>
       
         
    </div>

    <div class="form-group">
            
        <asp:Label runat="server" AssociatedControlID="txtTelefono" CssClass="col-sm-3 control-label">Teléfono</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="col-sm-4 form-control" ></asp:TextBox>
            </div>
        </div>

    <div class="form-group">
            
        <asp:Label runat="server" AssociatedControlID="txtCelular" CssClass="col-sm-3 control-label">Celular</asp:Label>                                          
        <div class="col-sm-5">
            <asp:TextBox ID="txtCelular" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
        </div>

        </div>


    <div class="form-group">
            
        <asp:Label runat="server" AssociatedControlID="txtCelular2" CssClass="col-sm-3 control-label">Celular 2</asp:Label>                                          
            <div class="col-sm-5">
            <asp:TextBox ID="txtCelular2" runat="server" CssClass="col-sm-4 form-control" ></asp:TextBox>
        </div>

        </div>
    <asp:PlaceHolder runat="server" ID="phProfesor" Visible="false">
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtRiesgos" ID="lblRiesgos" Text="Riesgos: " CssClass="col-sm-3 control-label"></asp:Label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtRiesgos" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPension" ID="Label1" Text="Pensión: " CssClass="col-sm-3 control-label"></asp:Label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtPension" runat="server" CssClass="col-sm-4 form-control"></asp:TextBox>
            </div>
        </div>
    </asp:PlaceHolder>

        <div class="form-group">
            <asp:Label ID="Label2" runat="server" AssociatedControlID="txtEPS" CssClass="col-sm-3 control-label">EPS</asp:Label>     
            <div class="col-sm-5">                               
                <asp:TextBox ID="txtEPS" runat="server" CssClass="col-sm-4 form-control" placeholder="EPS"></asp:TextBox>
             </div>
        </div>

         <div class="form-group">
            <label class="col-sm-3 control-label">Observación:</label>
            <div class="col-sm-5">
                <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtObservacion" Rows="4"
                   placeholder="¿Algún antecedente o condición física que debamos conocer?" ClientIDMode="Static"  />
            </div>
        </div>
<%--    <div class="form-group">

        <asp:Label runat="server" AssociatedControlID="FileUpload1" CssClass="col-sm-3 control-label">Foto</asp:Label>                                          
        <div class="col-sm-5">
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Image ID="imgFotoPerfil" runat="server" Height="179px" Width="233px" />
        </div>
    </div>--%>
    
    <div class="form-group" >
       <label class="col-sm-3 control-label">¿Desea actualizar la contraseña?</label>
        <div class="col-sm-5">             
                <input  type="checkbox" runat="server" id="chkCambioClave" /> 
        </div>
       
    </div>

    
    <div id="pnlClave" style="display:none">

        <div class="form-group">
           
            <asp:Label runat="server" AssociatedControlID="txtClaveNueva" CssClass="col-sm-3 control-label">Nueva Contraseña</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtClaveNueva" runat="server" TextMode="Password" CssClass="col-sm-4 form-control" ></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            
            <asp:Label runat="server" AssociatedControlID="txtClaveRepetir" CssClass="col-sm-3 control-label">Repetir contraseña</asp:Label>                                          
            <div class="col-sm-5">
                <asp:TextBox ID="txtClaveRepetir" runat="server" TextMode="Password" CssClass="col-sm-4 form-control"></asp:TextBox>
            </div>
        </div>

    </div>

    <hr />
    <div class="form-group">
        <div class="col-sm-offset-7 col-sm-3">
            <asp:Button ID="btnActualizar" CssClass="btn btn-purple" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" />
        </div>
    </div>

</div>

        </div>
        <!-- /. PAGE Inner  -->
    </div>
<!-- /. PAGE WRAPPER  -->

<uc2:ucFooter runat="server" id="ucFooter" />
      <!-- FORM Validation -->
    <script src="js/formValidation/formValidation.min.js"></script>
    <script src="js/formValidation/bootstrap.min.js"></script></div>
<!-- /. WRAPPER  -->



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
<script src="js/moment.min.js"></script>
<script src="js/moment-with-locales.min.js"></script>
<script src="js/bootstrap-datetimepicker.min.js"></script>
<%--<script src="js/funciones.js"></script>--%>

<script type="text/javascript">

    $(function () {
        $('#<%= txtFechaNacimiento.ClientID %>').datetimepicker({
                locale: 'es',
                format: 'DD/MM/YYYY'
        });


        $('#<%= chkCambioClave.ClientID %>').change(function () {
                        
            if ($(this).prop("checked") == true) 
                $('#pnlClave').show();
            else
                $('#pnlClave').hide();
            

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
                    txtNombre: {
                        
                        validators: {
                            notEmpty: {
                                message: 'El nombre es requerido'
                            }
                        }
                    },
                    txtApellido: {
                        
                        validators: {
                            notEmpty: {
                                message: 'El apellido es requerido'
                            }
                        }
                    },
                    txtCedula: {
                        validators: {
                            notEmpty: {
                                message: 'La cédula es requerido'
                            }
                        }
                    },

                    txtFechaNacimiento: {
                        validators: {
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'El formato de la fecha es invalido'
                            }
                        }
                    },

                    txtEmail: {
                        validators: {

                            emailAddress: {
                                message: 'El formato del E-mail no es valido'
                            }
                        }
                    },
                    txtTelefono: {
                        validators: {

                            regexp: {
                                message: 'Solo puede contener dígitos',
                                regexp: /\d/
                            }
                        }
                    },
                    txtCelular: {
                        validators: {

                            regexp: {
                                message: 'Solo puede contener dígitos',
                                regexp: /\d/
                            }
                        }
                    },
                    txtCelular2: {
                        validators: {

                            regexp: {
                                message: 'Solo puede contener dígitos',
                                regexp: /\d/
                            }
                        }
                    }
                    ,
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
                    }
                }
            })
            //.on('keyup', '[name="txtClaveNueva"]', function () {
            //    var isEmpty = $(this).val() == '';
            //    $('#form1')
            //            .formValidation('enableFieldValidators', 'txtClave', !isEmpty)
            //            .formValidation('enableFieldValidators', 'txtClaveRepetir', !isEmpty);

                
            //    if ($(this).val().length == 1) {
            //        $('#form1').formValidation('validateField', 'txtClave')
            //                        .formValidation('validateField', 'txtClaveRepetir');
            //    }
            //});;




       
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