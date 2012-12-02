<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MVCVenta.ViewModels.EnvioCourier>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Envio del Producto</h2>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Envio</legend>
            
            <%--<div class="editor-label">
                <%: Html.LabelFor(model => model.IdEnvio) %>
            </div>


            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.IdEnvio) %>
                <%: Html.ValidationMessageFor(model => model.IdEnvio) %>
            </div>--%>

            
            <%--<div class="editor-label">
                <%: Html.LabelFor(model => model.codDepartamento) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.codDepartamento) %>
                <%: Html.ValidationMessageFor(model => model.codDepartamento) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.codProvincia) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.codProvincia) %>
                <%: Html.ValidationMessageFor(model => model.codProvincia) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.codDistrito) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.codDistrito) %>
                <%: Html.ValidationMessageFor(model => model.codDistrito) %>
            </div>--%>

                 <div class="editor-label">
                    Departamento
                </div>
                <div class="editor-label">
                    <%= Html.DropDownListFor(model => model.codDepartamento, (IEnumerable<SelectListItem>)ViewData["Departamentos"], new { onchange = "this.form.action = '/EnvioCourier/ListarCombo'; this.form.submit(); " })%>
                    <%: Html.ValidationMessageFor(model => model.codDepartamento)%>
                </div>
                <div class="editor-label">
                    Provincia
                </div>
                <div class="editor-label">
                    <% if (ViewData["Provincias"] != null)
                    {%>
                    <%= Html.DropDownListFor(model => model.codProvincia, (IEnumerable<SelectListItem>)ViewData["Provincias"], new { onchange = "this.form.action = '/EnvioCourier/ListarCombo'; this.form.submit(); " })%>
                    <%: Html.ValidationMessageFor(model => model.codProvincia)%>
                    <%}%>
                </div>
                <div class="editor-label">
                    Distrito
                </div>
                <div class="editor-label">
                    <% if (ViewData["Distritos"] != null)
                    {%>
                    <%= Html.DropDownListFor(model => model.codDistrito, (IEnumerable<SelectListItem>)ViewData["Distritos"])%>
                    <%: Html.ValidationMessageFor(model => model.codDistrito)%>
                    <%}%>
                </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Direccion) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Direccion) %>
                <%: Html.ValidationMessageFor(model => model.Direccion) %>
            </div>
            
            <br />

          <h3>  ¿Desea Registrar Destino de Envio? </h3>
            <p>
                <input type="submit" id="btnRegistrar" name="btnRegistrar" value="Registrar" />
                <input type="submit" id="btnNoRegistrar" name="btnNoRegistrar" value="No Registrar" />
            </p>
        </fieldset>

    <% } %>

    <%--<div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>--%>

</asp:Content>

