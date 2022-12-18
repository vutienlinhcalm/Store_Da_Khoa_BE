using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.IServices;
using Repositories;

namespace Services
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;

        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }
        public async Task<(int, List<Product>)> GetAllProductAsync(CancellationToken cancellationToken)
        {
            var (success, result) = await _productRepository.GetAllProductAsync(cancellationToken);
            return (success, result);
        }
        public async Task<(int, List<Product>)> GetProductByIdAsync(int id, CancellationToken cancellationToken)
        {
            var (success, result) = await _productRepository.GetProductByIdAsync(id, cancellationToken);
            return (success, result);
        }
        public async Task<(int, Product)> CreateProductAsync(Product product, CancellationToken cancellationToken)
        {
            var (success, result) = await _productRepository.InsertProductAsync(product, cancellationToken);
            return (success, result);
        }
        public async Task<(int, List<Product>)> CreateListProductAsync(List<Product> products, CancellationToken cancellationToken)
        {
            var (success, result) = await _productRepository.InsertBulkProductAsync(products, cancellationToken);
            return (success, result);
        }
        public async Task<(int, Product)> UpdateProductAsync(Product product, CancellationToken cancellationToken)
        {
            var (success, result) = await _productRepository.UpdateProductAsync(product, cancellationToken);
            return (success, result);
        }
    }
}
