using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class ProductViewModel
    {
        public int ProductId { get; set; }

        public string? Brand { get; set; }

        public string? ProductName { get; set; }

        public string? Description { get; set; }

        public string? MainImage { get; set; }

        public string? SubImage1 { get; set; }

        public string? SubImage2 { get; set; }

        public int? Price { get; set; }

        public int? StoreQuantity { get; set; }

        public int? Gender { get; set; }

        public List<string> OrderDetailIds { get; set; } = new List<string>();

        public List<string> CategoryIds { get; set; } = new List<string>();
    }
}
