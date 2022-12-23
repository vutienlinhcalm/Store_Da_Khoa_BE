using Core.DBContext.ClothesStoreDataTable;
using Microsoft.CodeAnalysis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class CreateOrderViewModel
    {
        public string OrderId { get; set; } = new Guid().ToString();

        public string AccountId { get; set; } = new Guid().ToString();

        public string? PaymentMethod { get; set; }

        public string? Address { get; set; }

        public int? TotalPrice { get; set; }

        public List<OrderProduct> OrderProducts { get; set; } = new List<OrderProduct>();

        public Order GetInsertModel(Account account, List<Product> product)
        {
            var id = Guid.NewGuid().ToString();
            var order = new Order()
            {
                OrderId = id,
                AccountId = AccountId,
                OrderTime = DateTime.Now,
                PaymentMethod = PaymentMethod,
                Address = Address,
                Status = 1,
                TotalPrice = TotalPrice,
                Account = account,
                OrderDetails = OrderProducts.Select(p => new OrderDetail()
                {
                    OrderId = id,
                    ProductId = p.ProductId,
                    Quantity = p.Quantity,
                    Price = p.Price,
                    Product = product.Single(product => product.ProductId == p.ProductId),
                }).ToList()
            };

            return order;
        }
    }
    public struct OrderProduct
    {
        public string ProductId { get; set; }
        public int Quantity { get; set; }
        public int Price { get; set; }
    }
}
