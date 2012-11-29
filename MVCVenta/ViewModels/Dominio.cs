using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MVCVenta.ViewModels
{
    public class Dominio
    {

        public int ID { get; set; }

        public string Descripcion { get; set; }
  

        public Dominio(int id, string descripcion)
        {
            this.ID = id; this.Descripcion = descripcion; 
        }

        public Dominio()
        {
        }
    }
}