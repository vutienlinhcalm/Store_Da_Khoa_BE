using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class CategoryViewModel
    {
        public string CategoryId { get; set; }

        public string? CategoryName { get; set; }

        public string? Description { get; set; }
    }
}
