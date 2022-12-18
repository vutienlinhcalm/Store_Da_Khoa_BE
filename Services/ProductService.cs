using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Azure;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.IServices;
using Core.ViewModel;
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
        public async Task<(int, List<ProductViewModel>)> GetAllProductAsync(CancellationToken cancellationToken)
        {
            var (success, response) = await _productRepository.GetAllProductAsync(cancellationToken);
            var result = response.Select(p => p.GetViewModel()).ToList();
            return (success, result);
        }
        public async Task<(int, ProductViewModel)> GetProductByIdAsync(string id, CancellationToken cancellationToken)
        {
            var (success, response) = await _productRepository.GetProductByIdAsync(id, cancellationToken);
            var result = response.GetViewModel();
            return (success, result);
        }
        public async Task<(int, ProductViewModel)> CreateProductAsync(ProductViewModel product, CancellationToken cancellationToken)
        {
            var (success, response) = await _productRepository.InsertProductAsync(product, cancellationToken);
            var result = response.GetViewModel();
            return (success, result);
        }
        public async Task<(int, List<ProductViewModel>)> CreateListProductAsync(List<ProductViewModel> products, CancellationToken cancellationToken)
        {
            var (success, response) = await _productRepository.InsertBulkProductAsync(products, cancellationToken);
            var result = response.Select(p => p.GetViewModel()).ToList();
            return (success, result);
        }
        public async Task<(int, ProductViewModel)> UpdateProductAsync(ProductViewModel product, CancellationToken cancellationToken)
        {
            var (success, response) = await _productRepository.UpdateProductAsync(product, cancellationToken);
            var result = response.GetViewModel();
            return (success, result);
        }
    }
}
