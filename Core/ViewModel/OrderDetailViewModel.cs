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
    }
}
