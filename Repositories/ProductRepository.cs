using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Microsoft.EntityFrameworkCore;

namespace Repositories
{
    public class ProductRepository : IProductRepository
    {
        private readonly ClothesStoreDbContext _clothesStoreDbContext;
        public ProductRepository(ClothesStoreDbContext clothesStoreDbContext)
        {
            _clothesStoreDbContext = clothesStoreDbContext;
        }

        public async Task<(int, List<Product>)> GetAllProductAsync(CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Product.ToListAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, List<Product>)> GetProductByIdAsync(int id, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Product.Where(p => p.Productid == id).ToListAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, Product)> InsertProductAsync(Product product, CancellationToken cancellationToken)
        {
            await _clothesStoreDbContext.Product.AddAsync(product, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, product);
        }
        public async Task<(int, List<Product>)> InsertBulkProductAsync(List<Product> products, CancellationToken cancellationToken)
        {
            await _clothesStoreDbContext.Product.AddRangeAsync(products, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, products);
        }
        public async Task<(int, Product)> UpdateProductAsync(Product product, CancellationToken cancellationToken)
        {
            _clothesStoreDbContext.Update(product);
            await _clothesStoreDbContext.SaveChangesAsync(cancellationToken);
            return (1, product);
        }
    }
}
