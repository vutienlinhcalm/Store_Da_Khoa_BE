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
    public interface IOrderService
    {
        Task<(int, List<ProductViewModel>)> GetOrderDetailByOrderIdAsync(string id, CancellationToken cancellationToken);

    }
}
