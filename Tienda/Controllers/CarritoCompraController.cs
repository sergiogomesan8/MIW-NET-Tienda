using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tienda.Models;

namespace Tienda.Controllers
{
    [Authorize]
    public class CarritoCompraController : Controller
    {
        private TiendaEntities db = new TiendaEntities();

        // GET: CarritoCompra
        public ActionResult Index(CarritoCompra cc)
        {
            return View(cc);
        }

        public ActionResult VolcarCarrito(CarritoCompra cc)
        {

            foreach (Producto producto in cc)
            {
                if (producto.Cantidad > 0)
                {
                    Pedido pedido = new Pedido();
                    pedido.Id = producto.Id;
                    // TODO cantidad
                    pedido.NombreCliente = User.Identity.Name;
                    pedido.FechaCompra = DateTime.Now;

                    db.Pedidos.Add(pedido);
                    Producto prod = db.Productos.Find(producto.Id);
                    prod.Cantidad--;
                }
            }

            cc.Clear();
            db.SaveChanges();

            return RedirectToAction("Index", "Productos");
        }
    }
}