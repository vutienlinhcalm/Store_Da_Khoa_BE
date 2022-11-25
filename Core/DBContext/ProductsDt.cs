using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Core.DBContext
{
    public class ProductsDt
    {
        [Key, Required]
        public int ProductID { get; set; }
        [Required]
        public string ProductName { get; set; }
        public int SupplierID { get; set; }
        public int CategoryID { get; set; }
        public string QuantityPerUnit { get; set; }
	    public int UnitPrice { get; set; }
	    public int UnitsInStock { get; set; }
	    public int UnitsOnOrder { get; set; }
	    public int ReorderLevel { get; set; }
	    public byte Discontinued { get; set; }
    }
}
