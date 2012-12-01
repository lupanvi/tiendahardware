<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MVCVenta.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Crear una Nueva Cuenta</h2>
    <p>
        Use el formulario de abajo para crear una nueva cuenta. 
    </p>
    <p>
        La cantidad minima de caracteres para la clave es de <%: ViewData["PasswordLength"] %> characters .
    </p>

    <% using (Html.BeginForm()) { %>
        <%: Html.ValidationSummary(true, "La creación de la cuenta no fue satisfactoria. Por favor corregir los errores y tratar otra vez.") %>
        <div>
            <fieldset id="Contenedor">
                <legend>Información de cuenta</legend>

                <div class="editor-label">
                    <%: Html.LabelFor(m => m.Telefono) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.Telefono)%>
                    <%: Html.ValidationMessageFor(m => m.Telefono)%>
                </div>


                <div class="editor-label">
                    Departamento
                </div>
                <div class="editor-label">
                    <%= Html.DropDownListFor(model => model.codDepartamento, (IEnumerable<SelectListItem>)ViewData["Departamentos"], new { onchange = "this.form.action = '/Account/ListarCombo'; this.form.submit(); " })%>
                    <%: Html.ValidationMessageFor(model => model.codDepartamento)%>
                </div>
                <div class="editor-label">
                    Provincia
                </div>
                <div class="editor-label">
                    <% if (ViewData["Provincias"] != null)
                    {%>
                    <%= Html.DropDownListFor(model => model.codProvincia, (IEnumerable<SelectListItem>)ViewData["Provincias"], new { onchange = "this.form.action = '/Account/ListarCombo'; this.form.submit(); " })%>
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
                    <%: Html.LabelFor(m => m.Direccion) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.Direccion)%>
                    <%: Html.ValidationMessageFor(m => m.Direccion)%>
                </div>

                   <div class="editor-label">
                    <%: Html.LabelFor(m => m.TipoCliente) %>
                </div>
             
             
                <div id="Combo">
                    <select id='dropDownTipoCliente' name='dropDownTipoCliente' style="width: 150px">
                        <option value="1" selected="selected">Natural</option>
                        <option value="2">Jurídico</option>
                    </select>
                </div>

                <div id="Natural">
                    <div class="editor-label">
                        <%: Html.LabelFor(m => m.Dni) %>
                    </div>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(m => m.Dni)%>
                        <%: Html.ValidationMessageFor(m => m.Dni)%>
                    </div>
                    <div class="editor-label">
                        <%: Html.LabelFor(m => m.Nombres) %>
                    </div>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(m => m.Nombres)%>
                        <%: Html.ValidationMessageFor(m => m.Nombres)%>
                    </div>
                    <div class="editor-label">
                        <%: Html.LabelFor(m => m.Apellidos) %>
                    </div>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(m => m.Apellidos)%>
                        <%: Html.ValidationMessageFor(m => m.Apellidos)%>
                    </div>
                </div>


                <div id="Juridico">
                    <div class="editor-label">
                        <%: Html.LabelFor(m => m.Ruc) %>
                    </div>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(m => m.Ruc)%>
                        <%: Html.ValidationMessageFor(m => m.Ruc)%>
                    </div>
                    <div class="editor-label">
                        <%: Html.LabelFor(m => m.RazonSocial) %>
                    </div>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(m => m.RazonSocial)%>
                        <%: Html.ValidationMessageFor(m => m.RazonSocial)%>
                    </div>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.UserName) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.UserName) %>
                    <%: Html.ValidationMessageFor(m => m.UserName) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.Email) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.Email) %>
                    <%: Html.ValidationMessageFor(m => m.Email) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.Password) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.Password) %>
                    <%: Html.ValidationMessageFor(m => m.Password) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.ConfirmPassword) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.ConfirmPassword) %>
                    <%: Html.ValidationMessageFor(m => m.ConfirmPassword) %>
                </div>
                
                <p>
                    <input type="submit" value="Registro" />
                </p>
            </fieldset>
        </div>
    <% } %>


<script type='text/javascript'\>
    var id_div_natural = $('#Natural');
    var id_div_juridico = $('#Juridico');
    $(document).ready(function () {
    });

    $('#dropDownTipoCliente').change(function () {
            if ($(this).find("option:selected").text() == "Natural") {
                  $(this).parent().append(id_div_natural);
             $('#Juridico').remove();
            } else {
      
            $(this).parent().append(id_div_juridico);
             $('#Natural').remove();
           
        }
    });
</script>
</asp:Content>
