using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using MVCVenta.Models;
using MVCVenta.ViewModels;
namespace MVCVenta.Controllers
{

    [HandleError]
    public class AccountController : Controller
    {

        public IFormsAuthenticationService FormsService { get; set; }
        public IMembershipService MembershipService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            if (MembershipService == null) { MembershipService = new AccountMembershipService(); }

            base.Initialize(requestContext);
        }

        public readonly VentaDataClassesDataContext _data;

        public AccountController(VentaDataClassesDataContext data)
        {
            _data = data;
        }

        public AccountController()
        {
            _data = new VentaDataClassesDataContext();
        }

        // **************************************
        // URL: /Account/LogOn
        // **************************************

        public ActionResult LogOn()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {

                  List<Usuario> listaUsuarios = null;
                  var usuarios = (from u in _data.TB_Usuarios
                                  join c in _data.TB_Clientes
                                  on u.Fk_eCliente equals c.Pk_eCliente
                                  where u.cUsuario == model.UserName && u.cContrasena== model.Password
                                  select new
                                  {
                                      
                                      c.Pk_eCliente,
                                      u.Pk_eUsuario,
                                      u.cUsuario,
                                      u.cContrasena
                                     
                                  }).ToList();

                listaUsuarios=usuarios.ConvertAll(o=> new Usuario(o.Pk_eCliente,o.Pk_eUsuario,o.cUsuario,o.cContrasena));

                  if (listaUsuarios.Count>0)
                  {
                      FormsService.SignIn(model.UserName, model.RememberMe);
                      if (!String.IsNullOrEmpty(returnUrl))
                      {
                          return Redirect(returnUrl);
                      }
                      else
                      {
             
                          Session["UserLogeado"] = listaUsuarios;
                          return RedirectToAction("Create", "EnvioCourier");
                          //Aqui antes iba
                        //  return RedirectToAction("Index", "Compra");
                      }
                  }
                  else
                  {
                      ModelState.AddModelError("", "El nombre de usuario o clave ingresados no son correctos.");
                  }

            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        // **************************************
        // URL: /Account/LogOff
        // **************************************

        public ActionResult LogOff()
        {
            FormsService.SignOut();

            return RedirectToAction("Index", "Home");
        }

        // **************************************
        // URL: /Account/Register
        // **************************************

        //private bool inicio = false;

        public ActionResult Register()
        {

                //Llenar combo Departamento
                var departamentos = from c in _data.Ubigeo group c by new { c.codDepartamento, c.departamento } into grp select new { grp.Key.codDepartamento, grp.Key.departamento };
                ViewData["Departamentos"] = new SelectList(departamentos, "codDepartamento", "departamento", Session["DptoSeleccionado"]);

                //Llenar combo Provincia
                if (Session["DptoSeleccionado"] != null) {
                    var provincias = from c in _data.Ubigeo group c by new { c.codDepartamento, c.departamento, c.codProvincia, c.provincia } into grp where grp.Key.codDepartamento == Session["DptoSeleccionado"].ToString() select new { grp.Key.codDepartamento, grp.Key.departamento, grp.Key.codProvincia, grp.Key.provincia };
                    ViewData["Provincias"] = new SelectList(provincias, "codProvincia", "provincia", Session["ProvSeleccionado"]);
                }

                //Llenar combo Distrito
                if (Session["ProvSeleccionado"] != null)
                {
                    var distritos = from c in _data.Ubigeo group c by new {c.codDepartamento, c.departamento,c.codProvincia, c.provincia, c.codDistrito, c.distrito } into grp where grp.Key.codDepartamento == Session["DptoSeleccionado"].ToString() && grp.Key.codProvincia == Session["ProvSeleccionado"].ToString()  select new { grp.Key.codDepartamento,grp.Key.departamento,grp.Key.codProvincia, grp.Key.provincia, grp.Key.codDistrito, grp.Key.distrito };
                    ViewData["Distritos"] = new SelectList(distritos, "codDistrito", "distrito", Session["DistSeleccionado"]);

                }

                ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

               return View();
        }



        [HttpPost]
        public ActionResult ListarCombo(FormCollection fc)
        {

            Session["DptoSeleccionado"] = Request.Form["codDepartamento"].ToString();
            if (Request.Form["codProvincia"] != null)
            {
                Session["ProvSeleccionado"] = Request.Form["codProvincia"].ToString();
            }


            return RedirectToAction("Register", "Account");
        }



        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
     
            //Clientes
            TB_Cliente newCliente = new TB_Cliente();
            newCliente.cTelefono = Request.Form["Telefono"].ToString();
            newCliente.cDireccion = Request.Form["Direccion"].ToString();

            if (Request.Form["codDepartamento"] != null)
            {
                newCliente.codDepartamento = Request.Form["codDepartamento"].ToString();
            }

            if (Request.Form["codProvincia"] != null)
            {
                newCliente.codProvincia = Request.Form["codProvincia"].ToString();
            }

            if (Request.Form["codDistrito"] != null)
            {
                newCliente.codDistrito = Request.Form["codDistrito"].ToString();
            }

            
            if (Request.Form["dropDownTipoCliente"].Equals("1"))
            {
                newCliente.cTipCliente = "NAT";
            }
            else {
                newCliente.cTipCliente = "JUR";
            }
     
            //Agregar el Cliente a la tabla clientes.
            _data.TB_Clientes.InsertOnSubmit(newCliente);
           // newCliente.Pk_eCliente;
            _data.SubmitChanges();

            //Agregar el tipo de cliene segun tipo de cliente
            if (newCliente.cTipCliente.Equals("JUR")) {
                TB_PersonaJuridica newClienteJuridico = new TB_PersonaJuridica();
                newClienteJuridico.Fk_eCliente = newCliente.Pk_eCliente;
                newClienteJuridico.cRuc = Request.Form["Ruc"].ToString();
                newClienteJuridico.cRazSocial = Request.Form["RazonSocial"].ToString();

                _data.TB_PersonaJuridicas.InsertOnSubmit(newClienteJuridico);
                _data.SubmitChanges();
            }
            else if (newCliente.cTipCliente.Equals("NAT")) {
                TB_PersonaNatural newClienteNatural = new TB_PersonaNatural();
                newClienteNatural.Fk_eCliente = newCliente.Pk_eCliente;
                newClienteNatural.cDNI = Request.Form["Dni"].ToString();
                newClienteNatural.cNombres = Request.Form["Nombres"].ToString();
                newClienteNatural.cApellidos = Request.Form["Apellidos"].ToString();

                _data.TB_PersonaNaturals.InsertOnSubmit(newClienteNatural);
                _data.SubmitChanges();
            }

            //Usuario
            TB_Usuario newUsuario = new TB_Usuario();
            newUsuario.Fk_eCliente = newCliente.Pk_eCliente;
            newUsuario.cUsuario = Request.Form["UserName"].ToString();
            newUsuario.cContrasena = Request.Form["Password"].ToString();

            _data.TB_Usuarios.InsertOnSubmit(newUsuario);
            _data.SubmitChanges();

            return RedirectToAction("Logon", "Account");
        }

        // **************************************
        // URL: /Account/ChangePassword
        // **************************************

        [Authorize]
        public ActionResult ChangePassword()
        {
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
            return View();
        }

        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {
                if (MembershipService.ChangePassword(User.Identity.Name, model.OldPassword, model.NewPassword))
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
            return View(model);
        }

        // **************************************
        // URL: /Account/ChangePasswordSuccess
        // **************************************

        public ActionResult ChangePasswordSuccess()
        {
            return View();
        }

    }
}
