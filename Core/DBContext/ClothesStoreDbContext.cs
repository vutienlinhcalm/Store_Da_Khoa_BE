using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Core.DBContext
{
    public class ClothesStoreDbContext : DbContext
    {
        public ClothesStoreDbContext(DbContextOptions<ClothesStoreDbContext> options) : base(options)
        {

        }
    }
}
