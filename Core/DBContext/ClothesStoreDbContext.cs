using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Core.DBContext.ClothesStoreDataTable;

namespace Core.DBContext
{
    public class ClothesStoreDbContext : DbContext
    {
        public ClothesStoreDbContext(DbContextOptions<ClothesStoreDbContext> options) : base(options)
        {

        }

        public DbSet<Product> Product { get; set; }
    }
}
