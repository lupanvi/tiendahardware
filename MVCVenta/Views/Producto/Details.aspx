<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MVCVenta.Models.TB_Producto>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <br />
        <br />
        <br />
    <table width="40%">
        <tr>
            <td>
                <a href="../../Imagenes/Productos/<%: Model.Pk_eProducto%>_big.png" class="zoom">
                <img alt="<%:   Model.cDescripcion %>" src="../../Imagenes/Productos/<%: Model.Pk_eProducto%>.png" width="200" height="200" />
                </a>
            </td>

            <td valign="top" >
           <br />
           <br />
           <br />
          <h2>  <span> <%:   Model.cDescripcion %> </span> </h2>
            <br />
            <span> <%:   Model.cEspecificacion%> </span>
            <br />
         <h3>  <span>  <%: String.Format("{0:c}", Model.dPrecio)%> </span> </h3>
           <br />
           <br />
           <span>  <%: Html.ActionLink("Comprar", "Index", "CarritoCompras", new { id = Model.Pk_eProducto },null)%>  </span>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />

</asp:Content>

