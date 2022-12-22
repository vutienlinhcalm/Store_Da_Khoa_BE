using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class AddProductToCartViewModel
    {
        public string OrderId { get; set; }

        public string ProductId { get; set; }

        public int? Quantity { get; set; }

        public string AccountId { get; set; }

        public OrderDetail GetInsertModel(Order order, Product product)
        {
            var orderDetail = new OrderDetail()
            {
                OrderId = OrderId,
                ProductId = product.ProductId,
                Quantity = Quantity,
                Price = product.Price * Quantity,
                Product = product,
                Order = order
            };

            return orderDetail;
        }
    }
}
