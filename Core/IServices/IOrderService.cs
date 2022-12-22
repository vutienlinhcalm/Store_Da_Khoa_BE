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
        Task<(int, List<OrderViewModel>)> GetListOrderAsync(CancellationToken cancellationToken);
        Task<(int, OrderViewModel)> GetOrderByIdAsync(string id, CancellationToken cancellationToken);
        Task<(int, List<OrderViewModel>)> GetListOrderByAccountIdAsync(string accountId, CancellationToken cancellationToken);
        Task<(int, OrderViewModel)> CreateOrderAsync(OrderViewModel order, CancellationToken cancellationToken);

    }
}
