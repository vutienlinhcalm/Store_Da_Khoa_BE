using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DBContext.ClothesStoreDataTable
{
    [Table("Product")]
    public class Product
    {
        [Key]
        public int Productid { get; set; }
        public int Category_id { get; set; }
        public int Brand_id { get; set; }
        public string ProductName { get; set; }
        public string Description { get; set; }
        public string Productimage { get; set; }
        public decimal Price { get; set; }
        public byte Quantity { get; set; }
        public int Gender { get; set; }
        public string size { get; set; }
    }
}
