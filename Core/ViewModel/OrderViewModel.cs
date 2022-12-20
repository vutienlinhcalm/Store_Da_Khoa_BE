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
        public string OrderId { get; set; }

        public string? AccountId { get; set; }

        public DateTime? OrderTime { get; set; }

        public string? PaymentMethod { get; set; }

        public string? Address { get; set; }

        public int? Status { get; set; }

        public int? TotalPrice { get; set; }

        public List<OrderDetailViewModel> OrderDetails { get; set; } = new List<OrderDetailViewModel>();
    }
}
