using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MVCVenta.Models;
using MVCVenta.ViewModels;

namespace MVCVenta.Controllers
{
    public class CompraController : Controller
    {

        public readonly VentaDataClassesDataContext _data;

        public CompraController(VentaDataClassesDataContext data)
        {
            _data = data;
        }

        public CompraController()
        {
            _data = new VentaDataClassesDataContext();
        }

        //
        // GET: /Compra/

        public ActionResult Index()
        {
            List<CarritoCompra> listaCarritoCompras = null;
            listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];
            Decimal dMonto = listaCarritoCompras.Sum(P => P.TotalProducto);
            Decimal dCostoEnvio=0 ;

            
            //Verificar si Usuario seleccion Envio de Articulos
            if (Session["Envio"] != null) { 
                 EnvioCourier objEnvCourier = new EnvioCourier();
                 objEnvCourier = (EnvioCourier)Session["Envio"];
                 dCostoEnvio = objEnvCourier.MontoEnvio;
                 dMonto = dMonto + dCostoEnvio;
                 ViewData["CostoEnvio"] = dCostoEnvio;
            }

            Session["MontoCarritoTotal"] = dMonto;
              ViewData["MontoCarrito"] = dMonto;
            return View();
        }

        //
        // GET: /Compra/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Compra/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Compra/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            string strTipoPago = string.Empty;
            try
            {
                // TODO: Add insert logic here
                Transaccion objTransaccion = new Transaccion();
                objTransaccion.CodigoTarjeta = Request.Form["CodigoTarjeta"].ToString();
                objTransaccion.NumeroTarjeta = Request.Form["NumeroTarjeta"].ToString();

                if(Request.Form["dropDownTipoPago"].ToString().Equals("1")){
                    strTipoPago="SOL";
                }else  if(Request.Form["dropDownTipoPago"].ToString().Equals("2")){
                    strTipoPago="DOL";
                }

                objTransaccion.TipoPago = strTipoPago;

                 List<Usuario> listaUsuarios = null;

                 if (Session["UserLogeado"] != null) {
                     listaUsuarios = (List<Usuario>)Session["UserLogeado"];
                     if(listaUsuarios.Count>0){
                         objTransaccion.IdCliente = listaUsuarios[0].IdCliente;
                     }
                 }

                Session["Transaccion"] = objTransaccion;

                return RedirectToAction("RealizarCompra","CarritoCompras");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Compra/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Compra/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Compra/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Compra/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
