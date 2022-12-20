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
                .Include(p => p.Categories)
                .ToListAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, Product)> GetProductByIdAsync(string id, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Products
                .Where(p => p.ProductId == id)
                .Include(p => p.Categories)
                .FirstAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, List<Product>)> GetProductByListCategoryAsync(List<string> category, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Products
                .Include(p => p.Categories)
                .Where(p => p.Categories
                    .Select(pp => pp.CategoryName)
                    .Intersect(category)
                    .Any())
                .ToListAsync(cancellationToken);
            return (1, result);
        }
        public async Task<(int, Product)> InsertProductAsync(ProductViewModel product, CancellationToken cancellationToken)
        {
            var p = GetInsertProductModel(product);

            await _clothesStoreDbContext.Products.AddAsync(p, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, p);
        }
        public async Task<(int, List<Product>)> InsertBulkProductAsync(List<ProductViewModel> products, CancellationToken cancellationToken)
        {
            var p = products.Select(_p => GetInsertProductModel(_p)).ToList();

            await _clothesStoreDbContext.Products.AddRangeAsync(p, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, p);
        }
        public async Task<(int, Product)> UpdateProductAsync(ProductViewModel product, CancellationToken cancellationToken)
        {
            var p = GetUpdateProductModel(product);

            _clothesStoreDbContext.Update(p);
            await _clothesStoreDbContext.SaveChangesAsync(cancellationToken);
            return (1, p);
        }
        public Product GetInsertProductModel(ProductViewModel product)
        {
            var p = new Product()
            {
                ProductId = product.ProductId,
                Brand = product.Brand,
                ProductName = product.ProductName,
                Description = product.Description,
                MainImage = product.MainImage,
                SubImage1 = product.SubImage1,
                SubImage2 = product.SubImage2,
                Price = product.Price,
                StoreQuantity = product.StoreQuantity,
                Gender = product.Gender,
                Categories = GetCategoryByListName(product.CategoryNames)
            };
            return p;
        }
        public Product GetUpdateProductModel(ProductViewModel product)
        {
            var p = new Product()
            {
                ProductId = product.ProductId,
                Brand = product.Brand,
                ProductName = product.ProductName,
                Description = product.Description,
                MainImage = product.MainImage,
                SubImage1 = product.SubImage1,
                SubImage2 = product.SubImage2,
                Price = product.Price,
                StoreQuantity = product.StoreQuantity,
                Gender = product.Gender,
                Categories = GetCategoryByListName(product.CategoryNames)
            };
            return p;
        }
        public List<Category> GetCategoryByListName(List<string> names)
        {
            return _clothesStoreDbContext.Categories.Where(c => names.Contains(c.CategoryName)).ToList();
        }

    }
}
