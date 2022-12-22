using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class OrderDetailViewModel
    {
        public string OrderId { get; set; }

        public string ProductId { get; set; }

        public int? Quantity { get; set; }

        public int? Price { get; set; }

        public ProductViewModel Product { get; set; } = null!;

        public OrderDetail GetInsertModel()
        {
            var orderDetail = new OrderDetail()
            {
                OrderId = OrderId,
                ProductId = ProductId,
                Quantity= Quantity,
                Price = Price,
                Product = new Product() { ProductId = ProductId },
            };

            return orderDetail;
        }
        public OrderDetail GetInsertModel(Product product)
        {
            var orderDetail = new OrderDetail()
            {
                OrderId = OrderId,
                ProductId = ProductId,
                Quantity = Quantity,
                Price = Price,
                Product = product,
            };

            return orderDetail;
        }
    }
}
