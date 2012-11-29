<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MVCVenta.Models.TB_Producto>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Registro de Productos </h2>

    <% using (Html.BeginForm("Create", "Producto", FormMethod.Post))
       {%>
        <%: Html.ValidationSummary(true) %>

         <fieldset>
            <legend>Producto</legend>
            
            <div class="editor-label">
               Linea
            </div>

             <div class="editor-label">
            <%= Html.DropDownListFor(model => model.Fk_eDominio, (IEnumerable<SelectListItem>)ViewData["Dominios"])%>
             <%: Html.ValidationMessageFor(model => model.Fk_eDominio)%>
            </div>

          
            <div class="editor-label">
               Descripción
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.cDescripcion) %>
                <%: Html.ValidationMessageFor(model => model.cDescripcion) %>
            </div>
            
            <div class="editor-label">
                 Precio
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.dPrecio) %>
                <%: Html.ValidationMessageFor(model => model.dPrecio) %>
            </div>
            
            <div class="editor-label">
                Especificación
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.cEspecificacion) %>
                <%: Html.ValidationMessageFor(model => model.cEspecificacion) %>
            </div>
            
              
            <p>
                <input type="submit" value="Guardar" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Regresar", "Index") %>
    </div>

</asp:Content>

