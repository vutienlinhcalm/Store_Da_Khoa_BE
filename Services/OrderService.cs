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
        public async Task<(int, List<OrderDetail>)> GetOrderDetailByOrderIdAsync(string id, CancellationToken cancellationToken)
        {
            var (success, response) = await _orderRepository.GetListOrderDetailByOrderIdAsync(cancellationToken);
            var result = response.Select(p => p.GetViewModel()).ToList();
            return (success, result);
        }
    }
}
