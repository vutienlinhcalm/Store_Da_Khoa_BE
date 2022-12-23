using Core.DBContext.ClothesStoreDataTable;
using Core.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.IRepositories
{
    public interface IProductRepository
    {
        Task<(int, List<Product>)> GetAllProductAsync(CancellationToken cancellationToken);
        Task<(int, Product)> GetProductByIdAsync(string id, CancellationToken cancellationToken);
        Task<(int, List<Product>)> GetListProductByListIdAsync(List<string> ids, CancellationToken cancellationToken);
        Task<(int, List<Product>)> GetListProductByCategoryAsync(string category, CancellationToken cancellationToken);
        Task<(int, Product)> InsertProductAsync(ProductViewModel product, CancellationToken cancellationToken);
        Task<(int, List<Product>)> InsertBulkProductAsync(List<ProductViewModel> products, CancellationToken cancellationToken);
        Task<(int, Product)> UpdateProductAsync(ProductViewModel product, CancellationToken cancellationToken);
    }
}
