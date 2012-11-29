using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MVCVenta.ViewModels
{
    public class CarritoCompra
    {

        public int IdProducto { get; set; }

        public string DescripcionProducto { get; set; }

        public decimal PrecioProducto { get; set; }

        public int CantProducto { get; set; }

        public decimal TotalProducto { get; set; }

        public CarritoCompra(int idproducto, string descripcionproducto, decimal precioproducto, int cantproducto, decimal totalproducto)
        {
            this.IdProducto = idproducto; this.DescripcionProducto = descripcionproducto;
            this.PrecioProducto = precioproducto; this.CantProducto = cantproducto;
            this.TotalProducto = totalproducto;
        }

        public CarritoCompra()
        {
        }

    }
}