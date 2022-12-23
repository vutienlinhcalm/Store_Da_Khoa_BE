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
        public string ProductId { get; set; }

        public string? Brand { get; set; }

        public string? ProductName { get; set; }

        public string? Description { get; set; }

        public string? MainImage { get; set; }

        public string? SubImage1 { get; set; }

        public string? SubImage2 { get; set; }

        public int? Price { get; set; }

        public int? StoreQuantity { get; set; }

        public int? Gender { get; set; }

        public string? Category { get; set; }

        public Product GetInsertModel()
        {
            var p = new Product()
            {
                ProductId = Guid.NewGuid().ToString(),
                Brand = Brand,
                ProductName = ProductName,
                Description = Description,
                MainImage = MainImage,
                SubImage1 = SubImage1,
                SubImage2 = SubImage2,
                Price = Price,
                StoreQuantity = StoreQuantity,
                Gender = Gender,
                Category = Category
            };
            return p;
        }
        public Product GetUpdateModel()
        {
            var p = new Product()
            {
                ProductId = ProductId,
                Brand = Brand,
                ProductName = ProductName,
                Description = Description,
                MainImage = MainImage,
                SubImage1 = SubImage1,
                SubImage2 = SubImage2,
                Price = Price,
                StoreQuantity = StoreQuantity,
                Gender = Gender,
                Category = Category
            };
            return p;
        }
    }
}
