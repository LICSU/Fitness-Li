<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClaseAlumno.aspx.cs" Inherits="LicsuWeb.Validado.ClaseAlumno" %>
<%@ Register Src="~/Validado/ucHeader.ascx" TagPrefix="uc1" TagName="ucHeader" %>
<%@ Register Src="~/Validado/ucEncabezado.ascx" TagPrefix="uc2" TagName="ucEncabezado" %>
<%@ Register Src="~/Validado/ucMenu.ascx" TagPrefix="uc3" TagName="ucMenu" %>
<%@ Register Src="~/Validado/ucFooter.ascx" TagPrefix="uc4" TagName="ucFooter" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title id="Title1" runat="server">Licsu Reservas</title>
    <uc1:ucHeader runat="server" ID="ucHeader" />
    <!-- VALIDATIONS-->
    <link href="css/formValidation/formValidation.min.css" rel="stylesheet" />
   <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
<asp:ScriptManager runat="server"></asp:ScriptManager>
<!--<div id="wrapper">-->
<!-- Encabezado -->
<uc2:ucEncabezado runat="server" id="ucEncabezado" />
<!-- Menu superior y lateral -->
<uc3:ucMenu runat="server" ID="ucMenu" />
    <!--  PAGE WRAPPER  -->
    <div id="page-wrapper" >
        <div id="page-inner">
        <!-- Contenido pagina -->
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-4">
                    <h2 class="pull-left">Reservar</h2>

                    </div>               
                    <div class="col-md-3 col-md-offset-5">
                        <div class="form-group text-right">
                            <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-default" NavigateUrl="Inicio.aspx"> Regresar</asp:HyperLink>
                            <asp:LinkButton ID="btnVerHistoricoReserva" runat="server" CssClass="btn btn-purple" OnClick="Button2_Click" Text="Ver Historico de Clases" />
                        </div>
                    </div>
                </div>
            </div>
             <hr />

        <div class="form-horizontal">
 
            <div class="row">
                <div class="col-md-12">
                   <div class="col-md-2 pull-right text-right">
                       <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" ForeColor="#333333" GridLines="None" >
                                        <AlternatingRowStyle BackColor="White" />
                                        <CommandRowStyle Font-Bold="True" />
                                        <FieldHeaderStyle  Font-Bold="True" />
                                        <Fields>
                                            <asp:BoundField DataField="ClasesActivas" HeaderText="Clases Activas:" SortExpression="ClasesActivas" />
                                        </Fields>
                                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle  Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            
                                    </asp:DetailsView>
                                    <%--<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:licsu_RegistrosConnectionString %>" SelectCommand="SELECT [ClasesActivas] FROM [Clientes] WHERE ([Cedula] = @Cedula)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Label3" Name="Cedula" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>--%>

                   </div>

                    <div class="col-md-3">
                                <asp:Label ID="Label3" runat="server" Visible="False"></asp:Label>
                                <asp:Label ID="lblUnidad" runat="server" Visible="False"></asp:Label>
             
                        <h4>Calendario</h4>
                        <div class="form-group">
                                    <asp:Calendar ID="calendario" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" Width="220px">
                                    <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                                    <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                                    <OtherMonthDayStyle ForeColor="#CC9966" />
                                    <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                                    <SelectorStyle BackColor="#FFCC66" />
                                    <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                                    <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                                </asp:Calendar>
                                <br />
                               <div class="col-md-9">
                                <p class="text-justify"><small><asp:Label ID="lblMensaje" runat="server" ForeColor="Blue"></asp:Label></small></p>
                               </div>
                        </div>

                    </div>
                    <div class="col-md-7">

                        <h4>Mis Clases</h4>
                                   <asp:GridView ID="gvReservadas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered " HeaderStyle-BackColor="#69008C" HeaderStyle-ForeColor="White"
                                        AllowPaging="True" AllowSorting="True"
                                        OnRowCommand="gvReservadas_RowCommand">
                                        <Columns>     
                                            <asp:buttonfield buttontype="Link" commandname="Cancelar" text="Cancelar"/>                           
                                            <asp:BoundField DataField="ClaseDescripcion" HeaderText="Nombre" SortExpression="Nombre" />
                                            <asp:BoundField DataField="ClaseHoraInicio" HeaderText="Hora" SortExpression="Hora" />
                                            <asp:BoundField DataField="ClaseFechaInicio" HeaderText="Fecha" SortExpression="Fecha" DataFormatString = "{0:d}" />
                                        </Columns>
                                        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                                        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                                        <RowStyle BackColor="White" ForeColor="#330099" />
                                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                                        <SortedAscendingCellStyle BackColor="#FEFCEB" />
                                        <SortedAscendingHeaderStyle BackColor="#AF0101" />
                                        <SortedDescendingCellStyle BackColor="#F6F0C0" />
                                        <SortedDescendingHeaderStyle BackColor="#7E0000" />
                                    </asp:GridView>
                                    <%--<asp:SqlDataSource id="ContactsSource"
                                        selectcommand="SELECT Nombre, Hora, Fecha FROM dbo.Clases_Inscritas WHERE (Cedula = @Cedula) AND (Estado = 0)"
                                        connectionstring="<%$ ConnectionStrings:licsu_RegistrosConnectionString %>" 
                                        runat="server">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="Label3" Name="Cedula" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                    </asp:SqlDataSource>--%>

                          <%--Clases para el dia  --%>
                           <h4>Clases disponibles el <asp:Label ID="lblCalendario" runat="server"></asp:Label></h4>     

                                    <asp:GridView id="gvDisponibles" 
                                          AllowPaging="True" 
                                          AutoGenerateColumns="False"
                                          OnRowCommand="gvDisponibles_RowCommand"
                                          runat="server" CssClass="table table-bordered " HeaderStyle-BackColor="#69008C" HeaderStyle-ForeColor="White">
                                        <columns>
                                            <asp:buttonfield buttontype="Link" commandname="Reservar" text="Reservar"/>
                                            <asp:boundfield datafield="ClaseFechaInicio" headertext="Dia" SortExpression="Dia" DataFormatString = "{0:d}"/>
                                            <asp:boundfield datafield="ClaseHoraInicio" headertext="Hora" SortExpression="Hora"/>
                                            <asp:BoundField DataField="ClaseDescripcion" HeaderText="Nombre" SortExpression="Nombre" />
                                        </columns>
                                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                        <%--<HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />--%>
                                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                        <%--<SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />--%>
                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                        <SortedDescendingHeaderStyle BackColor="#242121" />
                                    </asp:GridView>

                                    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:licsu_RegistrosConnectionString %>" SelectCommand="SELECT Dia, Hora, Nombre FROM dbo.Clases WHERE (Dia = @Dia) AND (Estado = 'Habilitada') AND (Unidad = @Unidad)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblCalendario" Name="Dia" PropertyName="Text" Type="String" />
                                            <asp:ControlParameter ControlID="lblUnidad" Name="Unidad" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>--%>
                    </div>
        
                        </div>
                    </div>
                </div>

        </div>
        <!-- /. PAGE Inner  -->
    </div>
<!-- /. PAGE WRAPPER  -->

<uc4:ucFooter runat="server" id="ucFooter" />
      <!-- FORM Validation -->
    <script src="js/formValidation/formValidation.min.js"></script>
    <script src="js/formValidation/bootstrap.min.js"></script>
<!--</div>-->
<!-- /. WRAPPER  -->



<!---------------------------------- Modals --------------------------------->



<!-- Scripts -->
<script src="js/moment.min.js"></script>
<script src="js/moment-with-locales.min.js"></script>
<script src="js/bootstrap-datetimepicker.min.js"></script>
<%--<script src="js/funciones.js"></script>--%>

<script type="text/javascript">

    function MostrarModalExito(message) {
        $('#lblMsjModalExito').html(message);
        $('#modalExito').modal('show');
        return true;
    }
    function MostrarModalInformacion(message) {
        $('#lblMsjModalInformacion').html(message);
        $('#modalInformacion').modal('show');
        return true;
    }
    function MostrarModalError(message) {
        $('#lblMsjModalError').html(message);
        $('#modalError').modal('show');
        return true;
    }
</script>
</form>    
</body>
</html>