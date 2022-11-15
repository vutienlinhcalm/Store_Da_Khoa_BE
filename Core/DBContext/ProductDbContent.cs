using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Core.Model;

namespace Core.DBContext
{
    public class ProductDbContent : DbContext
    {
        public ProductDbContent(DbContextOptions options) : base(options)
        {
        }
        public DbSet<ProductModel> Products { get; set; }

    }
}
