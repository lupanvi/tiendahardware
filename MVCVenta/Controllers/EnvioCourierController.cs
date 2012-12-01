using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MVCVenta.Models;
using MVCVenta.ViewModels;
using System.Net;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace MVCVenta.Controllers
{
    public class EnvioCourierController : Controller
    {

        public readonly VentaDataClassesDataContext _data;

        public EnvioCourierController(VentaDataClassesDataContext data)
        {
            _data = data;
        }

        public EnvioCourierController()
        {
            _data = new VentaDataClassesDataContext();
        }


        //
        // GET: /EnvioCourier/

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /EnvioCourier/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /EnvioCourier/Create

        public ActionResult Create()
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

                //ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

               return View();
           // return View();
        }
 

        [HttpPost]
        public ActionResult ListarCombo(FormCollection fc)
        {

            Session["DptoSeleccionado"] = Request.Form["codDepartamento"].ToString();
            if (Request.Form["codProvincia"] != null)
            {
                Session["ProvSeleccionado"] = Request.Form["codProvincia"].ToString();
            }


            return RedirectToAction("Create", "EnvioCourier");
        }




        //public static String GetHttpPostResponse(HttpWebRequest httpWebRequest, String serializedPayload)
        //{
        //    httpWebRequest.Method = "POST";
        //    httpWebRequest.ContentType = "text/xml";
        //    httpWebRequest.ContentLength = serializedPayload.Length;

        //    StreamWriter streamOut = new StreamWriter(httpWebRequest.GetRequestStream(), Encoding.ASCII);
        //    streamOut.Write(serializedPayload);
        //    streamOut.Close();

        //    StreamReader streamIn = new StreamReader(httpWebRequest.GetResponse().GetResponseStream());

        //    string strResponse = streamIn.ReadToEnd();
        //    streamIn.Close();

        //    return strResponse;
        //}


        //
        // POST: /EnvioCourier/Create

        [HttpPost]
        public ActionResult Create(FormCollection fc)
        {
            try
            {

                if (fc["btnRegistrar"] != null)
                {
                    
                    //Preparar datos para webservice rest
                    List<CarritoCompra> listaCarritoCompras = null;
                    listaCarritoCompras = (List<CarritoCompra>)Session["Carrito"];

                    string strDatos = string.Empty;
                    for (int i = 0; i < listaCarritoCompras.Count; i++)
                    {
                      //  strDatos=string.Format("cantidad[]={0}&peso[]={1}&Pk_eUbigeo={2}&",listaCarritoCompras[i].CantProducto,listaCarritoCompras[i].Peso)
                        strDatos = strDatos + string.Format("cantidad[]={0}&peso[]={1}&", listaCarritoCompras[i].CantProducto, listaCarritoCompras[i].Peso);
                        //listaCarritoCompras[i].CantProducto = int.Parse(Cantidades[i].ToString());
                        //listaCarritoCompras[i].TotalProducto = decimal.Parse(TotalesProducto[i].ToString());
                    }

                    //Obteniendo IdUbigeo
                   // Ubigeo ubigeos = from c in _data.Ubigeo group c by new { c.,c.codDepartamento,  c.codProvincia, c.codDistrito } into grp where grp.Key.codDepartamento == Request.Form["codDepartamento"].ToString() select new { grp.Key.codDepartamento, grp.Key.departamento, grp.Key.codProvincia, grp.Key.provincia };

                    //Agregando ubigeo
                    strDatos = strDatos + string.Format("Pk_eUbigeo={0}&", 1);


                    //Aka llamado a webservice courier PHP
                    // Create a request using a URL that can receive a post. 
                    WebRequest request = WebRequest.Create("http://192.168.108.147/rest/costo");
                    // Set the Method property of the request to POST.
                    request.Method = "POST";
                    // Create POST data and convert it to a byte array.
                    //string postData = "cantidad[]=30,peso[]=20,Pk_eUbigeo=1";
                   // string postData = "cantidad[]=5&cantidad[]=6&peso[]=1&peso[]=1&Pk_eUbigeo=1&";
                    string postData = strDatos;
                    byte[] byteArray = Encoding.UTF8.GetBytes(postData);
                    // Set the ContentType property of the WebRequest.
                    request.ContentType = "application/x-www-form-urlencoded";
                    // Set the ContentLength property of the WebRequest.
                    request.ContentLength = byteArray.Length;
                    // Get the request stream.
                    Stream dataStream = request.GetRequestStream();
                    // Write the data to the request stream.
                    dataStream.Write(byteArray, 0, byteArray.Length);
                    // Close the Stream object.
                    dataStream.Close();
                    // Get the response.
                    WebResponse response = request.GetResponse();
                    // Display the status.
                    Console.WriteLine(((HttpWebResponse)response).StatusDescription);
                    // Get the stream containing content returned by the server.
                    dataStream = response.GetResponseStream();
                    // Open the stream using a StreamReader for easy access.
                    StreamReader reader = new StreamReader(dataStream);
                    // Read the content.
                    string responseFromServer = reader.ReadToEnd();
                    // Display the content.
                    //Console.WriteLine(responseFromServer);
                    // Clean up the streams.
                    reader.Close();
                    dataStream.Close();
                    response.Close();

                    JObject o = JObject.Parse(responseFromServer);
                    string MontoEnvio = o["costo"].ToString();

                    // Insertar en Envio
                    EnvioCourier objEnvCourier = new EnvioCourier();
                    objEnvCourier.IdEnvio = 1;
                    objEnvCourier.codDepartamento = Request.Form["codDepartamento"].ToString();
                    objEnvCourier.codProvincia = Request.Form["codProvincia"].ToString();
                    objEnvCourier.codDistrito = Request.Form["codDistrito"].ToString();
                    objEnvCourier.Direccion = Request.Form["Direccion"].ToString();

                    List<Usuario> listaUsuarios = null;
                    if (Session["UserLogeado"] != null)
                    {
                         listaUsuarios = (List<Usuario>)Session["UserLogeado"];
                         if (listaUsuarios.Count > 0)
                         {
                             objEnvCourier.IdCliente = listaUsuarios[0].IdCliente;
                         }
                    }

                    objEnvCourier.MontoEnvio = decimal.Parse(MontoEnvio);
                    Session["Envio"] = objEnvCourier;

                }
                else if (fc["btnRegistrar"] != null) { 
                
                }


                return RedirectToAction("Index","Compra");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /EnvioCourier/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /EnvioCourier/Edit/5

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
        // GET: /EnvioCourier/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /EnvioCourier/Delete/5

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
