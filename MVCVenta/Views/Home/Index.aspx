<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MVCVenta.ViewModels.ProductoList>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Catálogo de Productos</h2>

<table cellspacing="10" cellpadding="10">
<tr>
<td valign="top">



<table width="150">
 <tr>
            <th >
                Categorias
            </th>
        </tr>
<%  
       List<MVCVenta.ViewModels.Dominio> listaOfDominios = (List<MVCVenta.ViewModels.Dominio>)ViewData["ListOfDominios"];

       foreach (var item in listaOfDominios)
       {%>
<tr>
<td>
    <%--<a href="#">
   <%: item.Descripcion%>
      </a>--%>

    <%:  Html.ActionLink(item.Descripcion, 
                "Index",   // <-- ActionMethod
                "Home",  // <-- Controller Name.
                new { id = item.ID }, // <-- Route arguments.
                null  // <-- htmlArguments .. which are none. You need this value
                      //     otherwise you call the WRONG method ...
                      //     (refer to comments, below).
                ) %>
</td>
</tr>
 <%}%>
</table>


</td>
<td valign="top">


        

    <table>
        <tr>
            <th colspan="4">
                Articulos
            </th>
        </tr>
        <% var intCont = 1; %>
        <tr>
            <% foreach (var item in Model)
               {%>
            <td>
                <table border="0" width="100%">
                    <tr>
                        <td align="center">
                            <img alt="<%: item.Descripcion%>" src="../../Imagenes/Productos/<%: item.ID%>.png"
                                width="150" height="200" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>
                                <%: item.Descripcion%>
                            </b>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <b>
                                <%: String.Format("{0:c}", item.Precio) %>
                            </b>
                            <br />
                            <br />
                           
                             <%:  Html.ActionLink("Ver Detalle",
                                                      "Details",   // <-- ActionMethod
                                    "Producto",  // <-- Controller Name.
                new { id = item.ID }, // <-- Route arguments.
                null  // <-- htmlArguments .. which are none. You need this value
                      //     otherwise you call the WRONG method ...
                      //     (refer to comments, below).
                ) %>
                        </td>
                    </tr>
                </table>
            </td>
            <% if (intCont % 4 == 0)
               {%>
        </tr>
        <tr>
            <%}%>
            <% intCont++; %>
            <% } %>
        </tr>
    </table>




    </td>
    </tr>
    </table>
 
</asp:Content>
