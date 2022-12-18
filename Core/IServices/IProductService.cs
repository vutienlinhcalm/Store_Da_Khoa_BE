using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.IServices
{
    public interface IProductService
    {
        Task<(int, List<ProductViewModel>)> GetAllProductAsync(CancellationToken cancellationToken);
        Task<(int, ProductViewModel)> GetProductByIdAsync(string id, CancellationToken cancellationToken);
        Task<(int, ProductViewModel)> CreateProductAsync(ProductViewModel product, CancellationToken cancellationToken);
        Task<(int, List<ProductViewModel>)> CreateListProductAsync(List<ProductViewModel> products, CancellationToken cancellationToken);
        Task<(int, ProductViewModel)> UpdateProductAsync(ProductViewModel product, CancellationToken cancellationToken);

    }
}
