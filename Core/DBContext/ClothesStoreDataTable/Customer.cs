using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DBContext.ClothesStoreDataTable
{
    [Table("Customer")]
    public class Customer
    {
        [Key]
        public int Customerid { get; set; }
        public string Cusname { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
    }
}
