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
    public class OrderService : IOrderService
    {
        private readonly IOrderRepository _orderRepository;

        public OrderService(IOrderRepository orderRepository)
        {
            _orderRepository = orderRepository;
        }
        public async Task<(int, OrderViewModel)> GetOrderByIdAsync(string id, CancellationToken cancellationToken)
        {
            var (success, response) = await _orderRepository.GetOrderByIdAsync(id, cancellationToken);
            var result = response.GetViewModel();
            return (success, result);
        }
        public async Task<(int, List<OrderViewModel>)> GetListOrderByAccountIdAsync(string accountId, CancellationToken cancellationToken)
        {
            var (success, response) = await _orderRepository.GetListOrderByAccountIdAsync(accountId, cancellationToken);
            var result = response.Select(order => order.GetViewModel()).ToList();
            return (success, result);
        }
        public async Task<(int, OrderViewModel)> CreateOrderAsync(OrderViewModel order, CancellationToken cancellationToken)
        {
            var (success, response) = await _orderRepository.InsertOrderAsync(order, cancellationToken);
            var result = response.GetViewModel();
            return (success, result);
        }
    }
}
