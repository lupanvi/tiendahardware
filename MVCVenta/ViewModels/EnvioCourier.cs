using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MVCVenta.ViewModels
{
    public class EnvioCourier
    {

        public int IdEnvio { get; set; }

        public int IdCliente { get; set; }

        public string codDepartamento { get; set; }

        public string codProvincia { get; set; }

        public string codDistrito { get; set; }

        public string Direccion { get; set; }

        public decimal MontoEnvio { get; set; }



        public EnvioCourier(int idenvio, string coddepartamento, string codprovincia, string coddistrito,string direccion,int idcliente,decimal montoenvio)
        {
            this.IdEnvio = idenvio; this.codDistrito = coddistrito;
            this.codDepartamento = coddepartamento; this.Direccion = direccion;
            this.codProvincia = codprovincia; this.IdCliente = idcliente;
            this.MontoEnvio = montoenvio;
        }

        public EnvioCourier()
        {
        }

    }
}