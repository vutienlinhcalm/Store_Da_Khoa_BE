using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.ViewModel;
using Microsoft.CodeAnalysis;
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
            var result = await _clothesStoreDbContext.Products
                .ToListAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, Product)> GetProductByIdAsync(string id, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Products
                .Where(p => p.ProductId == id)
                .FirstAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, List<Product>)> GetListProductByCategoryAsync(string category, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Products
                .Where(p => p.Category == category)
                .ToListAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, Product)> InsertProductAsync(ProductViewModel product, CancellationToken cancellationToken)
        {
            var p = product.GetInsertModel();

            await _clothesStoreDbContext.Products.AddAsync(p, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, p);
        }
        public async Task<(int, List<Product>)> InsertBulkProductAsync(List<ProductViewModel> products, CancellationToken cancellationToken)
        {
            var p = products.Select(_p => _p.GetInsertModel()).ToList();

            await _clothesStoreDbContext.Products.AddRangeAsync(p, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, p);
        }
        public async Task<(int, Product)> UpdateProductAsync(ProductViewModel product, CancellationToken cancellationToken)
        {
            var p = product.GetUpdateModel();

            _clothesStoreDbContext.Update(p);
            await _clothesStoreDbContext.SaveChangesAsync(cancellationToken);
            return (1, p);
        }
        

    }
}
