using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class OrderViewModel
    {
        public string OrderId { get; set; } = Guid.Empty.ToString();

        public string? AccountId { get; set; }

        public DateTime? OrderTime { get; set; }

        public string? PaymentMethod { get; set; }

        public string? Address { get; set; }

        public int? Status { get; set; }

        public int? TotalPrice { get; set; }

        public AccountViewModel? Account { get; set; }

        public List<OrderDetailViewModel> OrderDetails { get; set; } = new List<OrderDetailViewModel>();

        public Order GetInsertModel(Account account)
        {
            var id = new Guid().ToString();
            var o = new Order()
            {
                OrderId = id,
                AccountId = AccountId,
                OrderTime = OrderTime,
                PaymentMethod = PaymentMethod,
                Address = Address,
                Status = 0,
                TotalPrice = 0,
                Account = account,
                OrderDetails = OrderDetails.Select(orederDetail => orederDetail.GetInsertModel()).ToList(),
            };

            return o;
        }
    }
}
