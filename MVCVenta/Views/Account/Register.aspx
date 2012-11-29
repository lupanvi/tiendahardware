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
        Passwords are required to be a minimum of <%: ViewData["PasswordLength"] %> characters in length.
    </p>

    <% using (Html.BeginForm()) { %>
        <%: Html.ValidationSummary(true, "Account creation was unsuccessful. Please correct the errors and try again.") %>
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
                    <%: Html.LabelFor(m => m.Direccion) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.Direccion)%>
                    <%: Html.ValidationMessageFor(m => m.Direccion)%>
                </div>

                   <div class="editor-label">
                    <%: Html.LabelFor(m => m.TipoCliente) %>
                </div>
             <%--   <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.TipoCliente)%>
                    <%: Html.ValidationMessageFor(m => m.TipoCliente)%>
                </div>--%>


              <%--  <%= Html.DropDownList("qchap", new SelectList( (IEnumerable)ViewData["qchap"], "Id", "Title" ), new { onchange = "this.form.action = 'someAnotherUrl'; this.form.submit();" }) %>--%>
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
        //        $('#Natural').css('visibility', 'visible');
        // $('#Juridico').css('visibility', 'hidden');
       // $('#Juridico').remove();
    });

    $('#dropDownTipoCliente').change(function () {
        //        var id_div_natural = $('#Natural');
        //        var id_div_juridico = $('#Juridico');
        if ($(this).find("option:selected").text() == "Natural") {
            //              $('#Natural').css('visibility', 'visible');
            //              $('#Juridico').css('visibility', 'hidden');
            //$('#Natural').append();
            //$('#Contenedor').append($('#Natural'));
             $(this).parent().append(id_div_natural);
           // $("Combo").after(id_div_natural);
          //  $(this).parent().append(id_div_juridico);
           // $('#Juridico').css('visibility', 'hidden');
          //  $("Combo").after(id_div_natural);
          //  $('#Juridico').detach();

           // $(this).parent().remove(id_div_juridico);

             $('#Juridico').remove();
            //id_div_juridico.remove();
            //id_div_juridico.remove();
        } else {
            //              $('#Natural').css('visibility', 'hidden');
            //              $('#Juridico').css('visibility', 'visible');
            //$('#Juridico').append();
            // $('#Contenedor').append($('#Juridico'));
            //$(this).parent().append($('#Juridico'));
            $(this).parent().append(id_div_juridico);
           // $("Combo").after(id_div_juridico);
         //   $(this).parent().append(id_div_natural);
           // $('#Natural').css('visibility', 'hidden');
          //  $("Combo").after(id_div_juridico);
            // $('#Natural').detach();
          //  var span = $('#Natural').detach();


         //   $(this).parent().remove(id_div_natural);
             $('#Natural').remove();
           // id_div_natural.remove();
        }
    });
</script>
</asp:Content>
