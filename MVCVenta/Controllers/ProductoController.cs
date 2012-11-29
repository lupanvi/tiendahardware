using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MVCVenta.Models;
using MVCVenta.ViewModels;

namespace MVCVenta.Controllers
{
    public class ProductoController : Controller
    {
        //
        // GET: /Producto/
        public readonly VentaDataClassesDataContext _data;

        public ProductoController(VentaDataClassesDataContext data)
        {
            _data = data;
        }

        public ProductoController()
        {
            _data = new VentaDataClassesDataContext();
        }

        public ActionResult Index()
        {
  
            List<ProductoList> listaProductos = null;
            var productos = (from p in _data.TB_Productos
                             join d in _data.TB_Dominios
                             on p.Fk_eDominio equals d.Pk_eDominio
                             select new
                                  {
                                      p.Pk_eProducto,
                                      dominio = d.cDescripcion,
                                      producto = p.cDescripcion,
                                      p.dPrecio,
                                      p.cEspecificacion,
                                      p.bImagen
                                  }).ToList();

            listaProductos = productos.ConvertAll(o => new ProductoList(o.Pk_eProducto,o.dominio,o.producto,o.dPrecio,o.cEspecificacion,o.bImagen));
             
            return View(listaProductos);
        }

        //
        // GET: /Producto/Details/5

        public ActionResult Details(int id)
        {
            //Seleccionar el producto segun su id y obtener sus datos
            TB_Producto producto;
            producto = _data.TB_Productos
                  .Single(Id => Id.Pk_eProducto == id);

            
            return View(producto);


        }

        //
        // GET: /Producto/Create

        public ActionResult Create()
        {
            //Llenar combo Linea
            var dominios = from c in _data.TB_Dominios select c;
            ViewData["Dominios"] = new SelectList(dominios, "Pk_eDominio", "cDescripcion");

            return View();
        } 

        //
        // POST: /Producto/Create

        [HttpPost]
           public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here
                //Crear un nuevo objecto producto .
                TB_Producto newProducto = new TB_Producto();
                newProducto.Fk_eDominio = Int16.Parse(Request.Form["Fk_eDominio"].ToString());
                newProducto.cDescripcion = Request.Form["cDescripcion"].ToString();
                newProducto.dPrecio = decimal.Parse(Request.Form["dPrecio"].ToString());
                newProducto.cEspecificacion = Request.Form["cEspecificacion"].ToString();
                //newProducto.bImagen = "v";
               
                //Agregar el producto a la tabla productos.
                _data.TB_Productos.InsertOnSubmit(newProducto);
                _data.SubmitChanges();
               return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Producto/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Producto/Edit/5

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
        // GET: /Producto/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Producto/Delete/5

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
