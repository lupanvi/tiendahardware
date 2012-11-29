<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MVCVenta.ViewModels.ProductoList>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Listado de Productos</h2>

       <p>
        <%: Html.ActionLink("Crear Nuevo Producto", "Create") %>
       </p>

    <table>
        <tr>
            <th></th>
            <th>
                ID
            </th>
            <th>
                Línea
            </th>
            <th>
                Descripcion
            </th>
            <th>
                Precio
            </th>
            <th>
               Especificacion
            </th>
            <th>
                Imagen
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Editar", "Edit", new { id=item.ID }) %> |
                <%: Html.ActionLink("Detalles", "Details", new { id=item.ID })%> |
                <%: Html.ActionLink("Eliminar", "Delete", new { id=item.ID })%>
            </td>
            <td>
                <%: item.ID %>
            </td>
            <td>
                <%: item.Dominio%>
            </td>
            <td>
                <%: item.Descripcion%>
            </td>
            <td>
                <%: String.Format("{0:c}", item.Precio) %>
            </td>
            <td>
                <%: item.Especificacion %>
            </td>
            <td>
                <%: item.Imagen %>
            </td>
        </tr>
    
    <% } %>

    </table>

 

</asp:Content>

