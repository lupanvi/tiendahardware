using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MVCVenta.ViewModels
{
    public class Transaccion
    {
        public int IdCliente { get; set; }
        public string NombreCliente { get; set; }
        public string CodigoTarjeta { get; set; }
        public string NumeroTarjeta { get; set; }
        public string TipoPago { get; set; }
        public decimal MontoTotal { get; set; }

        public string CodigoTransaccion { get; set; }



        public Transaccion(int idcliente,string nombrecliente, string codigotarjeta, string numerotarjeta, string tipopago, decimal montototal,string codigotransaccion)
        {
            this.IdCliente = idcliente;
            this.NombreCliente = nombrecliente; this.CodigoTarjeta = codigotarjeta; this.NumeroTarjeta = numerotarjeta;
            this.TipoPago = tipopago; this.MontoTotal = montototal;
            this.CodigoTransaccion = codigotransaccion;
        }

        public Transaccion()
        {
        }
    }
}