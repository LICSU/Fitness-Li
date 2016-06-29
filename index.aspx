<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="LicsuWeb.index" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Fitness Li</title>
    <meta name="description" content="Más que una Academia." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
    <link href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.1.1/animate.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <link rel="stylesheet" href="css/styles.css" />
      <link href="Validado/css/ingreso.css" rel="stylesheet" />
    <script type="text/javascript" src="js1/scripts.js"></script>
    <style>
        .redondo2 {
             margin:0 auto;
             width:260px;
             height:190px;
        }
        .fondo {
            background-color:#fff;
            height:692px;
            width:100%;
        }
        .grande {
            font-size:18px;
            color:#9c27c1;
            text-align:left;
        }
        .grande2 {
            color:#9c27c1;
            font-size:18px;
            text-align:center !important; 
        }
        .fondoTeatro {
            background:url('Images/teatro_fondo.png') no-repeat;
            height:300px;
        }
        .videoCentralClase {
            margin-left:-16px;
            padding-top:59px;
        }
        .page-scroll a {
            color:#9c27c1;
        }
    </style>
  </head>
  <body>
    <nav id="topNav" class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="#first"><img src="Images/logo_fitness.png"></a>
            </div>
            <div class="navbar-collapse collapse" id="bs-navbar">
                <ul class="nav navbar-nav">
                    <li>
                        <a class="page-scroll" href="#first">Inicio</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#">Nosotros</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#">Clases</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#">Inscripciones</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#">Contáctanos</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#">Servicios Especiales</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#">Almacén</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <header id="first">
        <div class="header-content" style="padding-left:0px;">
            <form id="form1" runat="server" class="form-horizontal">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="inner">
                <div class="col-lg-4">                   
                    <div runat="server" id="lblAviso" class="control-label grande2" style="opacity:0;">Intro de los programas semana
                        <br /><img src="Images/titulo.png" />
                    </div>

                    <div id="videoCentral" class="fondoTeatro" runat="server" style="opacity:0;">
                        <asp:Panel CssClass="videoCentralClase" runat="server" ID="panelCentral"></asp:Panel>
                    </div>                
                </div> 
                <div class=" col-lg-6">
                    <div class="col-lg-3" style="padding:0 !important; text-align:left;">
                        <p>
                            <asp:LinkButton runat="server" ID="video1" CssClass="control-label" Text="Pole Fit" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video2" CssClass="control-label" Text="Pole Dance" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video3" CssClass="control-label" Text="Power (GAP, total)" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video4" CssClass="control-label" Text="Hatha Yoga" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video5" CssClass="control-label" Text="Plasticidad" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video6" CssClass="control-label" Text="Rumba" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video7" CssClass="control-label" Text="Insanity" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video8" CssClass="control-label" Text="Telas" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video9" CssClass="control-label" Text="Acro Yoga" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                            <asp:LinkButton runat="server" ID="video10" CssClass="control-label" Text="Tae-bo" OnClick="video1_Click"></asp:LinkButton>
                            <br />
                        </p>
                    </div>
                    <div class="col-lg-9">
                        <asp:Image runat="server" ID="imagen1" ImageUrl="~/Images/circulo2.png" Visible="false" />
                        <asp:PlaceHolder runat="server" ID="phImagen">
                            <img id="circulo" style="opacity:0;" src="~/Images/circulo2.png" runat="server" />
                        </asp:PlaceHolder>                            
                    </div>                
                </div>

                <div class=" col-lg-2">
                    <div class="card card-container">
                        <img class="profile-img" src="../Images/logo_fitness.png" alt="Usuario"/>
                        <asp:Label ID="lblValidado" runat="server" Text="" Visible="False"></asp:Label>
                            <span id="reauth-email" class="reauth-email"></span>
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
                                <asp:Button ID="bAceptar" runat="server" Text="Ingresar" class="btn btn-lg btn-purple btn-block"  OnClick="bAceptar_Click" />
                            </div>
                            <div class="row" style="text-align:center;"><a href="../selectEmpresa1.aspx" class="text-center text-primary">Eres Nuevo ¡Regístrate!</a></div> 
                    </div>
                    <asp:Label ID="lblError" runat="server" Text="Label" Visible="False"></asp:Label>
                </div>
                
                <!-- Fin del Cuadro -->
            </div>
                </form>
        </div>
        <asp:PlaceHolder ID="lpVideo" runat="server">
        <div id="fondo"><video poster="" data-wow-delay="0.5s" autoplay preload="auto"  muted="muted" width="100%" height="auto" id="video-background">            
                <source src="Images/video.mp4" type="video/mp4" />
                <source src="Images/video.webm" type="video/webm" />
                Tu navegador no soporta HTML5 Video            
         </video></div>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="lpImage" runat="server" Visible="false">
            <div class="fondo"></div>
        </asp:PlaceHolder>
    </header>
    <!--<section class="bg-primary" id="one">
        <div class="container">
            <h2 class="margin-top-0 text-primary text-center">Academia</h2>
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">
                    <div class="col-lg-4">
                        <img class="img-circle" src="Images/columna1.jpg" />
                    </div>
                    <div class="col-lg-8 text-justify">
                    <br>
                    <p class="text-faded">
                       Licsu es una academia de acondicionamiento físico e integral que ofrece programas que están diseñados para satisfacer diferentes objetivos, los cuales van desde lograr cero sobrepeso y reducir el estrés, pasando por el fortalecimiento muscular, ritmo y movimiento, capacidad cardiovascular, capacidad de elongación y estiramiento hasta programas lúcidos y recreativos.
 </p>
                        <p class="text-faded">
Nuestras técnicas y programas están diseñados cuidadosamente para llegar a personas reales, de diferentes grupos de edad, estados fisicos y patologías.
                    </p>
                    </div>
                </div>
                <div class="col-lg-2"></div>
            </div>
        </div>
    </section>
    <section id="two">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="margin-top-0 text-primary">Empresas</h2>
                    <div class="col-lg-2"></div>
                    <div class="col-lg-8 text-justify">
                        <div class="col-lg-4">
                            <img class="img-circle"  src="Images/columna2.jpg"/>
                        </div>
                        <div class="col-lg-1"></div>
                        <div class="col-lg-7">
                            <p class="text-faded">
                            Además ofrecemos servicios al público general, también y de la mano de empresas comprometidas con la salud integral de sus empleados hacemos extensivos estos beneficios a sus grupos de empleados.
                            </p>
                            <p class="text-faded">
Algunos de nuestros clientes son
                            </p>
                            <br />
                            <img class="img-thumbnail" src="Images/clientes.jpg" />
                        </div>
                    </div>
                    <div class="col-lg-2"></div>
                </div>
            </div>
        </div>
    </section>
      <section class="bg-primary" id="Section1">
        <div class="container">
            <h2 class="margin-top-0 text-primary text-center">Academia</h2>
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">                    
                    <div class="col-lg-8 text-justify">
                    <br>
                    <p class="text-faded">
                       Licsu tiene 9 años de experiencia con la escuela de seducción, siendo la primera del pais en especializarse en este tipo de clase, más de 5 años acompañando a las futurasnovias en las despedidas de solteras y organizando fiestas temáticas y de amigas.
SECRET LICSU tiene un sello de garantía especial, miles de clientas satisfechas y programas hechos con calidad. No es una simpe clase, son profesionales con gran estilo y trayectoria a nivel nacional.
                    </p>
                    <h4 class="text-primary">PORTAFOLIO</h4>
                    <ul class="list-unstyled">
                        <li>Sexy Lúcida</li>
                        <li>Conversatorio ërotico Personalizado</li>
                        <li>Clase Temática de Sexy Dance</li>
                        <li>Taller de Masajes Erótico y Sexo Oral</li>
                        <li>Plan Premium Cúpido</li>
                        <li>Plan Premium Fashion</li>
                        <li>Plan Premium Oriente</li>
                        <li>Pasabocas</li>
                        <li>Camisetas</li>
                        <li>Decoración y Accesorios</li>
                        <li>Striper</li>
                        <li>Shows</li>
                        <li>Conferencias para Empresas</li>
                        <li>Aniversarios Personalizados</li>
                    </ul>
                    </div>
                    <div class="col-lg-4">
                        <img class="img-circle" src="Images/columna1.jpg" />
                    </div>
                </div>
                
                <div class="col-lg-2"></div>
            </div>
        </div>
    </section>
    <section id="three" class="no-padding">
        <div class="container-fluid">
            <div class="row no-gutter">
                <div class="col-lg-4 col-sm-6">
                    <a href="#galleryModal" class="gallery-box" data-toggle="modal" data-src="//splashbase.s3.amazonaws.com/unsplash/regular/photo-1430916273432-273c2db881a0%3Fq%3D75%26fm%3Djpg%26w%3D1080%26fit%3Dmax%26s%3Df047e8284d2fdc1df0fd57a5d294614d">
                        <img src="//splashbase.s3.amazonaws.com/unsplash/regular/photo-1430916273432-273c2db881a0%3Fq%3D75%26fm%3Djpg%26w%3D1080%26fit%3Dmax%26s%3Df047e8284d2fdc1df0fd57a5d294614d" class="img-responsive" alt="Image 1">
                        <div class="gallery-box-caption">
                            <div class="gallery-box-content">
                                <div>
                                    <i class="icon-lg ion-ios-search"></i>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <a href="#galleryModal" class="gallery-box" data-toggle="modal" data-src="//splashbase.s3.amazonaws.com/getrefe/regular/tumblr_nqune4OGHl1slhhf0o1_1280.jpg">
                        <img src="//splashbase.s3.amazonaws.com/getrefe/regular/tumblr_nqune4OGHl1slhhf0o1_1280.jpg" class="img-responsive" alt="Image 2">
                        <div class="gallery-box-caption">
                            <div class="gallery-box-content">
                                <div>
                                    <i class="icon-lg ion-ios-search"></i>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <a href="#galleryModal" class="gallery-box" data-toggle="modal" data-src="//splashbase.s3.amazonaws.com/unsplash/regular/photo-1433959352364-9314c5b6eb0b%3Fq%3D75%26fm%3Djpg%26w%3D1080%26fit%3Dmax%26s%3D3b9bc6caa190332e91472b6828a120a4">
                        <img src="//splashbase.s3.amazonaws.com/unsplash/regular/photo-1433959352364-9314c5b6eb0b%3Fq%3D75%26fm%3Djpg%26w%3D1080%26fit%3Dmax%26s%3D3b9bc6caa190332e91472b6828a120a4" class="img-responsive" alt="Image 3">
                        <div class="gallery-box-caption">
                            <div class="gallery-box-content">
                                <div>
                                    <i class="icon-lg ion-ios-search"></i>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <a href="#galleryModal" class="gallery-box" data-toggle="modal" data-src="//splashbase.s3.amazonaws.com/lifeofpix/regular/Life-of-Pix-free-stock-photos-moto-drawing-illusion-nabeel-1440x960.jpg">
                        <img src="//splashbase.s3.amazonaws.com/lifeofpix/regular/Life-of-Pix-free-stock-photos-moto-drawing-illusion-nabeel-1440x960.jpg" class="img-responsive" alt="Image 4">
                        <div class="gallery-box-caption">
                            <div class="gallery-box-content">
                                <div>
                                    <i class="icon-lg ion-ios-search"></i>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <a href="#galleryModal" class="gallery-box" data-toggle="modal" data-src="//splashbase.s3.amazonaws.com/lifeofpix/regular/Life-of-Pix-free-stock-photos-new-york-crosswalk-nabeel-1440x960.jpg">
                        <img src="//splashbase.s3.amazonaws.com/lifeofpix/regular/Life-of-Pix-free-stock-photos-new-york-crosswalk-nabeel-1440x960.jpg" class="img-responsive" alt="Image 5">
                        <div class="gallery-box-caption">
                            <div class="gallery-box-content">
                                <div>
                                    <i class="icon-lg ion-ios-search"></i>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <a href="#galleryModal" class="gallery-box" data-toggle="modal" data-src="//splashbase.s3.amazonaws.com/lifeofpix/regular/Life-of-Pix-free-stock-photos-clothes-exotic-travel-nabeel-1440x960.jpg">
                        <img src="//splashbase.s3.amazonaws.com/lifeofpix/regular/Life-of-Pix-free-stock-photos-clothes-exotic-travel-nabeel-1440x960.jpg" class="img-responsive" alt="Image 6">
                        <div class="gallery-box-caption">
                            <div class="gallery-box-content">
                                <div>
                                    <i class="icon-lg ion-ios-search"></i>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>    
    <section id="#last">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 text-center">
                    <h2 class="margin-top-0 wow fadeIn">Contáctanos</h2>
                    <hr class="primary">
                    <p>Envianos un correo si deseas saber algo adicional.</p>
                </div>
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <form class="contact-form row"  method="post" action="mailto:roberthalexander13@gmail.com">
                        <div class="col-md-4">
                            <label></label>
                            <input type="text" name="nombres" class="form-control" placeholder="Nombre">
                        </div>
                        <div class="col-md-4">
                            <label></label>
                            <input type="text" name="correo" class="form-control" placeholder="Correo">
                        </div>
                        <div class="col-md-4">
                            <label></label>
                            <input type="text" name="telefono" class="form-control" placeholder="Teléfono">
                        </div>
                        <div class="col-md-12">
                            <label></label>
                            <textarea class="form-control" name="mensaje" rows="9" placeholder="Escribe tu mensaje.."></textarea>
                        </div>
                        <div class="col-md-4 col-md-offset-4">
                            <label></label>
                            <button type="submit" name="Submit" data-toggle="modal" data-target="#alertModal" class="btn btn-primary btn-block btn-lg">Enviar <i class="ion-android-arrow-forward"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>-->
    <footer id="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-6 col-sm-3 column">
                    <h4>Fitness Li</h4>
                    <ul class="list-unstyled">
                        <li><a href="#">Nosotros</a></li>
                        <li><a href="#">Clases</a></li>
                        <li><a href="#">Inscripciones</a></li>
                        <li><a href="#">Contáctanos</a></li>
                    </ul>
                </div>
                <div class="col-xs-6 col-sm-3 column">
                    <h4>Ubicanos</h4>
                    <p>Dirección: Calle 10#40-60, Medellín Teléfono: (4)3115472 Horario: Lun-Vie 9:00am-9:00pm, Sab 8:00am-3:00pm</p>
                </div>
                <div class="col-xs-12 col-sm-3 column">
                    
                </div>
                <div class="col-xs-12 col-sm-3 text-right">
                    <h4>Siguenos</h4>
                    <ul class="list-inline">
                      <li><a rel="nofollow" href="" title="Twitter"><i class="icon-lg ion-social-twitter-outline"></i></a>&nbsp;</li>
                      <li><a rel="nofollow" href="" title="Facebook"><i class="icon-lg ion-social-facebook-outline"></i></a>&nbsp;</li>
                      <li><a rel="nofollow" href="" title="Dribble"><i class="icon-lg ion-social-dribbble-outline"></i></a></li>
                    </ul>
                </div>
            </div>
            <br/>
        </div>
        <div class="row text-center"><span class="pull-center text-muted small"><a href="http://www.licsu.com">Fitness Li</a> ©2016 Derechos Reservados</span></div>
    </footer>
    <div id="galleryModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
        <div class="modal-content">
        	<div class="modal-body">
        		<img src="//placehold.it/1200x700/222?text=..." id="galleryImage" class="img-responsive" />
        		<p>
        		    <br/>
        		    <button class="btn btn-primary btn-lg center-block" data-dismiss="modal" aria-hidden="true">Close <i class="ion-android-close"></i></button>
        		</p>
        	</div>
        </div>
        </div>
    </div>
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
    <!--scripts loaded here from cdn for performance -->
    <script src="Validado/js/jquery-1.10.2.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.js"></script>
    <script src="js1/scripts.js"></script>
    <script type="text/javascript">

          function MostrarMsjModal(message, title, ccsclas) {
              var vIcoModal = document.getElementById("icoModal");
              vIcoModal.className = ccsclas;
              $('#lblMsjTitle').html(title);
              $('#lblMsjModal').html(message);
              $('#Msjmodal').modal('show');
              return true;
          }

          function MostrarImagen() {
              document.getElementById("circulo").style.opacity = "1";
              return true;
          }
          $(document).ready(function () {                          
              /*setTimeout(function () {
                  $('#videoCentral').fadeOut('fast');
              }, 70000);*/
              setTimeout(function () {
                  $('#fondo').fadeOut('fast');
                  document.getElementById("circulo").style.opacity = "1";
                  document.getElementById("lblAviso").style.opacity = "1";
                  document.getElementById("videoCentral").style.opacity = "1";
              }, 66000);
          });
    </script>
  </body>
</html>
