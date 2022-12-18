using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.IServices
{
    public interface IProductService
    {
        Task<(int, List<Product>)> GetAllProductAsync(CancellationToken cancellationToken);
        Task<(int, List<Product>)> GetProductByIdAsync(int id, CancellationToken cancellationToken);
        Task<(int, Product)> CreateProductAsync(Product product, CancellationToken cancellationToken);
        Task<(int, List<Product>)> CreateListProductAsync(List<Product> products, CancellationToken cancellationToken);
        Task<(int, Product)> UpdateProductAsync(Product product, CancellationToken cancellationToken);

    }
}
