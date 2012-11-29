<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	RealizarCompra
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Compra Efectuada</h2>

     
      <h3> <font color="green" > Código Transacción : <%: ViewData["Cod.Transaccion"] %> </font></h3>


     <h3> <font color="green" > <%: ViewData["Message"] %> </font></h3>

      <p>
        <%: Html.ActionLink("Regresar", "Index/1","Home") %>
       </p>

</asp:Content>
