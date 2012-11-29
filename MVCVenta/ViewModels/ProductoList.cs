using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using MVCVenta.Models;

namespace MVCVenta.ViewModels
{
    public class ProductoList
    {
        public int ID { get; set; }

        [DisplayName("Linea")]
        public string Dominio  { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public string Especificacion { get; set; }
        public string Imagen { get; set; }

        public ProductoList(int id, string dominio, string descripcion, decimal precio, string especificacion, string imagen)
        {
            this.ID = id; this.Dominio = dominio; this.Descripcion = descripcion; this.Precio = precio; this.Especificacion = especificacion; this.Imagen=imagen;
        }

        public ProductoList()
        {
        }
    }

  
}