using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MVCVenta.Models;
using MVCVenta.ViewModels;
using System.Messaging;
using System.Net.Mail;

namespace MVCVenta.Controllers
{
    public class CarritoComprasController : Controller
    {
        //
        // GET: /CarritoCompras/

            public readonly VentaDataClassesDataContext _data;

        public CarritoComprasController(VentaDataClassesDataContext data)
        {
            _data = data;
        }

        public CarritoComprasController()
        {
            _data = new VentaDataClassesDataContext();
        }

      
        public ActionResult Index(int id)
        {
            List<CarritoCompra> listaCarritoCompras = null;
            //Si no escogido ningun producto
            if (id != 0)
            {
                CarritoCompra objCarrito = new CarritoCompra();

                var productoAgregado = _data.TB_Productos
                   .Single(Id => Id.Pk_eProducto == id);


                if (Session["Carrito"] != null)
                {
                    listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];
                    objCarrito.IdProducto = productoAgregado.Pk_eProducto;
                    objCarrito.DescripcionProducto = productoAgregado.cDescripcion;
                    objCarrito.PrecioProducto = productoAgregado.dPrecio;
                    objCarrito.CantProducto = 1;
                    objCarrito.TotalProducto = productoAgregado.dPrecio;
                    objCarrito.Peso = productoAgregado.dPeso;
                    listaCarritoCompras.Add(objCarrito);
                    Session["Carrito"] = listaCarritoCompras;
                }
                else
                {
                    objCarrito.IdProducto = productoAgregado.Pk_eProducto;
                    objCarrito.DescripcionProducto = productoAgregado.cDescripcion;
                    objCarrito.PrecioProducto = productoAgregado.dPrecio;
                    objCarrito.CantProducto = 1;
                    objCarrito.TotalProducto = productoAgregado.dPrecio;
                    objCarrito.Peso = productoAgregado.dPeso;
                    listaCarritoCompras = new List<CarritoCompra>();
                    listaCarritoCompras.Add(objCarrito);
                    Session["Carrito"] = listaCarritoCompras;

                }
            }
            else {
                listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];
            }

            return View(listaCarritoCompras);
           // return View();
        }

        //
        // GET: /CarritoCompras/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

              
        public ActionResult Guardar(FormCollection fc)
        {
            //Guardar el producto seleccionado
            if (fc["btnGuardar"] != null)
            {
                List<CarritoCompra> listaCarritoCompras = null;
                if (Session["Carrito"] != null)
                {
                    listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];
                    string[] Cantidades = Request.Form["txtCantProducto"].Split(char.Parse(","));
                    string[] TotalesProducto = Request.Form["hdTotalProducto"].Split(char.Parse(","));

                    for (int i = 0; i < Cantidades.Length; i++)
                    {
                        listaCarritoCompras[i].CantProducto = int.Parse(Cantidades[i].ToString());
                        listaCarritoCompras[i].TotalProducto = decimal.Parse(TotalesProducto[i].ToString());
                    }

                    Session["Carrito"] = listaCarritoCompras;
                }


            }
                //Realizar la compra
            else if (fc["btnCompra"] != null)
            {
    
                List<CarritoCompra> listaCarritoCompras = null;
                if (Session["Carrito"] != null)
                {
                    listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];
                    string[] Cantidades = Request.Form["txtCantProducto"].Split(char.Parse(","));
                    string[] TotalesProducto = Request.Form["hdTotalProducto"].Split(char.Parse(","));

                    for (int i = 0; i < Cantidades.Length; i++)
                    {
                        listaCarritoCompras[i].CantProducto = int.Parse(Cantidades[i].ToString());
                        listaCarritoCompras[i].TotalProducto = decimal.Parse(TotalesProducto[i].ToString());
                    }

                    Session["Carrito"] = listaCarritoCompras;
                }


                return RedirectToAction("LogOn", "Account");

            }
                //Cancelar la compra
            else if (fc["btnCancelar"] != null) {
                Session["Carrito"] = null;
                //return RedirectToAction("Index/1", "Home");
            
            }
          
            return RedirectToAction("Index/1", "Home");
        }

        //
        // GET: /CarritoCompras/Create

        public ActionResult RealizarCompra()
        {
            List<CarritoCompra> listaCarritoCompras = null;
          
            string rpta = string.Empty;
            
                listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];
             Transaccion objTransaccion = new Transaccion();
             objTransaccion = (Transaccion)Session["Transaccion"];

                Decimal dMonto = listaCarritoCompras.Sum(P => P.TotalProducto);
                //Guardar en base de datos
                WsBanco.NroCuentaServiceClient oWsBancoJava = new WsBanco.NroCuentaServiceClient();
                //rpta = oWsBancoJava.obtenerTransaccion("6958474589632458", "0201", "SOL", 100);
               // rpta = oWsBancoJava.obtenerTransaccion("6958474589632458", "0201", "SOL", (double)dMonto);
                rpta = oWsBancoJava.obtenerTransaccion(objTransaccion.NumeroTarjeta, objTransaccion.CodigoTarjeta, objTransaccion.TipoPago, (double)dMonto);

                if (rpta != "-1")
                {

                    objTransaccion.CodigoTransaccion = rpta;
                    //Procedemos a guardar el documento
                    //Cabecera
                    TB_Pedido newPedido = new TB_Pedido();
                    newPedido.Fk_eCliente = objTransaccion.IdCliente;
                    newPedido.cDestinatario = "";
                    newPedido.mTotal = dMonto;
                    newPedido.cNumTarjeta = objTransaccion.NumeroTarjeta;
                    newPedido.eCodTarjeta = int.Parse(objTransaccion.CodigoTarjeta);
                    newPedido.cTipoPago = objTransaccion.TipoPago;
                    newPedido.cNroTransaccion = rpta;
                    _data.TB_Pedido.InsertOnSubmit(newPedido);
                    _data.SubmitChanges();

                    //Detalle
                    for (int i = 0; i < listaCarritoCompras.Count; i++)
                    {
                        TB_DetallePedido newDetPedido = new TB_DetallePedido();
                        newDetPedido.Fk_ePedido = newPedido.Pk_ePedido;
                        newDetPedido.Fk_eProducto = listaCarritoCompras[i].IdProducto;
                        newDetPedido.eCantidad = listaCarritoCompras[i].CantProducto;
                        newDetPedido.mSuTotal = listaCarritoCompras[i].TotalProducto;
                        _data.TB_DetallePedido.InsertOnSubmit(newDetPedido);
                        _data.SubmitChanges();

                    }


                    //Message QUEUE
                    //Insertar en cola - Message Queue
                    string rutaColaR = @".\private$\Ventas";
                    if (!MessageQueue.Exists(rutaColaR))
                        MessageQueue.Create(rutaColaR);
                    MessageQueue colaR = new MessageQueue(rutaColaR);
                    Message mensajeR = new Message();
                    mensajeR.Label = "Venta001";
                   // mensajeR.Body = new Transaccion() { IdCliente = 1, NombreCliente = "Lucho Cuellar", NumeroTarjeta = "20412222111", TipoPago = "S", MontoTotal = 700 };
                    mensajeR.Body = new Transaccion() { CodigoTarjeta=objTransaccion.CodigoTarjeta, CodigoTransaccion= objTransaccion.CodigoTransaccion, IdCliente= objTransaccion.IdCliente, MontoTotal= objTransaccion.MontoTotal, NombreCliente= objTransaccion.NombreCliente, NumeroTarjeta= objTransaccion.NumeroTarjeta, TipoPago= objTransaccion.TipoPago};
                    colaR.Send(mensajeR);

                    //Leer el objeto insertado en cola
                    string rutaColaL = @".\private$\Ventas";
                    if (!MessageQueue.Exists(rutaColaL))
                        MessageQueue.Create(rutaColaL);
                    MessageQueue colaL = new MessageQueue(rutaColaL);
                    colaL.Formatter = new XmlMessageFormatter(new Type[] { typeof(Transaccion) });
                    Message mensajeL = colaL.Receive(); //new Message();
                    Transaccion otransCola = (Transaccion)mensajeL.Body;
                    //Message QUEUE


                    ////Limpiar
                    //Session["Carrito"] = null;
                    //Session["Transaccion"] = objTransaccion;
                    //ViewData["Cod.Transaccion"] = objTransaccion.CodigoTransaccion;

                    //Limpiar
                    //Session["Carrito"] = null;
                    Session["Transaccion"] = otransCola;
                    ViewData["Cod.Transaccion"] = otransCola.CodigoTransaccion;
                   
                    ViewData["Message"] = string.Format("La compra se realizo correctamente, El Monto total fue de : {0}", String.Format("{0:c}", Session["MontoCarritoTotal"]));
                   
                 
                    //Enviar Correo

                    //MailMessage mailObj = new MailMessage(txtFrom.Text, txtTo.Text, txtSubject.Text, txtBody.Text); SmtpClient SMTPServer = new SmtpClient("localhost"); try { SMTPServer.Send(mailObj); }
                    //catch (Exception ex) { }

                    //MailMessage mailObj = new MailMessage("luiscarlosx@gmail.com", "luiscarlosx@gmail.com", "Compra Articulos Computo", "Buenos dias su compra fue satisfactoria"); SmtpClient SMTPServer = new SmtpClient("smtp.gmail.com"); try { SMTPServer.Send(mailObj); }
                    //catch (Exception ex) { }

                    MailMessage MyMailMessage = new MailMessage();

                    MyMailMessage.From = new MailAddress("luiscarlosx@gmail.com");

                    MyMailMessage.To.Add("luiscarlosx@gmail.com");

                    MyMailMessage.Subject = "Compra Articulos de Computo";

                    MyMailMessage.IsBodyHtml = true;

                    string MensajeCorreo = string.Empty;

                    MensajeCorreo = string.Format( "<table><tr><td> Sr(a) : {0} </td></tr> ",otransCola.NombreCliente);

                    MensajeCorreo += "<tr><td> Los Articulos comprados fueron :  </td></tr>";

                    for (int i = 0; i < listaCarritoCompras.Count; i++)
                    {
                     
                        MensajeCorreo += string.Format("<tr><td> {0} - {1}  </td></tr>", listaCarritoCompras[i].CantProducto, listaCarritoCompras[i].DescripcionProducto);

                    }

                    MensajeCorreo += string.Format("<tr><td>El total es de : {0} </td></tr>", String.Format("{0:c}", Session["MontoCarritoTotal"]));
                    MensajeCorreo += "</table>";


                   // MyMailMessage.Body = "<table><tr><td>" + txtName.Text + txtEmail.Text + txtComments.Text + "</table></tr></td>";
                   // MyMailMessage.Body = "<table><tr><td>Tu compra fue un exito </tr></td></table>";
                    MyMailMessage.Body = MensajeCorreo;

                    SmtpClient SMTPServer = new SmtpClient("smtp.gmail.com");

                    SMTPServer.Port = 587;

                   // SMTPServer.Credentials = new System.Net.NetworkCredential("cadbuaryguy@gmail.com", System.Configuration.ConfigurationSettings.AppSettings["pwd"].ToString());
                    SMTPServer.Credentials = new System.Net.NetworkCredential("luiscarlosx@gmail.com", "esquivel");

                    SMTPServer.EnableSsl = true;

                    try
                    {

                        SMTPServer.Send(MyMailMessage);

                       // Response.Redirect("Thankyou.aspx");

                    }

                    catch (Exception ex)
                    {

                     }

                    //smtp.gmail.com

                    //Limpiar Carrito
                    Session["Carrito"] = null;

                }
                else
                {
                    ViewData["Message"] = "Ocurrió un error en la transacción.";
                }
    
                return View();
                
        } 

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /CarritoCompras/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /CarritoCompras/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /CarritoCompras/Edit/5

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
        // GET: /CarritoCompras/Delete/5
 
        public ActionResult Delete(int id)
        {

            List<CarritoCompra> listaCarritoCompras = null;
            if (Session["Carrito"] != null)
            {
                listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];

                //Buscar un objeto Carrito
                CarritoCompra itemCarrito = listaCarritoCompras.Find(delegate(CarritoCompra c) {return c.IdProducto == id; });
                listaCarritoCompras.Remove(itemCarrito);

                Session["Carrito"] = listaCarritoCompras;
                //Si al eliminar los productos manualmente no hay productos regresamos a la pagina de catalogo de productos
                if (listaCarritoCompras.Count == 0) {
                    return RedirectToAction("Index/1", "Home");
                }
            }

            //return View(listaCarritoCompras);
            return RedirectToAction("Index/0", "CarritoCompras");
           
        }

        //
        // POST: /CarritoCompras/Delete/5

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
