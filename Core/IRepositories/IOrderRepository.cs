using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.ViewModel;

namespace Core.IRepositories
{
    public interface IOrderRepository
    {
        Task<(int, List<Order>)> GetListOrderAsync(CancellationToken cancellationToken);
        Task<(int, Order)> GetOrderByIdAsync(string id, CancellationToken cancellationToken);
        Task<(int, List<Order>)> GetListOrderByAccountIdAsync(string accountId, CancellationToken cancellationToken);
        Task<(int, Order)> InsertOrderAsync(OrderViewModel model, CancellationToken cancellationToken);
    }
}
