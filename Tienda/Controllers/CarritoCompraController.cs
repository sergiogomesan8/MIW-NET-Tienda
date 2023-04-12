using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
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
            Pedido pedido = new Pedido();
            foreach (Producto producto in cc)
            {
                if (producto.Cantidad > 0)
                {
                    pedido.Id = producto.Id;
                    // TODO cantidad
                    pedido.NombreCliente = User.Identity.Name;
                    pedido.FechaCompra = DateTime.Now;
                    pedido.Importe = pedido.Importe + (producto.Cantidad * producto.Precio);

                    Producto produdctoDb = db.Productos.Find(producto.Id);
                    produdctoDb.Cantidad -= producto.Cantidad;
                    if (produdctoDb.Cantidad <= 2)
                    {
                        Stock stock = new Stock();
                        //stock.Producto = produdctoDb;
                        stock.ReStock = false;
                        db.Stocks.Add(stock);
                    }
                }
            }

            db.Pedidos.Add(pedido);
            db.SaveChanges();

            cc.Clear();
            return RedirectToAction("Index", "Productos");
        }

        public ActionResult Remove(int id, CarritoCompra cc)
        {
            Producto producto = new Producto();
            foreach (var p in cc)
            {
                if (p.Id == id)
                    producto = p;
            }
            producto.Cantidad--;
            if(producto.Cantidad <= 0)
            {
                cc.Remove(producto);
            }
            return RedirectToAction("Index");
        }
        public ActionResult RemoveAll(int id, CarritoCompra cc)
        {
            List<Producto> productos = new List<Producto>();
            foreach (var p in cc)
            {
                if (p.Id == id)
                    productos.Add(p);
            }
            foreach (Producto p in productos)
                cc.Remove(p);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}