using System.Text;
using System.Threading.Tasks;
using Azure;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.IServices;
using Core.ViewModel;
using Microsoft.Identity.Client;
using Repositories;

namespace Services
{
    public class OrderService : IOrderService
    {
        private readonly IOrderRepository _orderRepository;
        private readonly IProductRepository _productRepository;
        private readonly IAccountRepository _accountRepository;

        public OrderService(IOrderRepository orderRepository, IProductRepository productRepository, IAccountRepository accountRepository)
        {
            _orderRepository = orderRepository;
            _productRepository = productRepository;
            _accountRepository = accountRepository;
        }
        public async Task<(int, List<OrderViewModel>)> GetListOrderAsync(CancellationToken cancellationToken)
        {
            var (success, response) = await _orderRepository.GetListOrderAsync(cancellationToken);
            var result = response.Select(order => order.GetViewModel()).ToList();
            return (success, result);
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

        public async Task<(int, OrderDetailViewModel)> AddProductToCartAsync(AddProductToCartViewModel model, CancellationToken cancellationToken)
        {
            var (success1, order) = await _orderRepository.GetOrderByIdAsync(model.OrderId, cancellationToken);
            var (success2, product) = await _productRepository.GetProductByIdAsync(model.ProductId, cancellationToken);
            if (success1 == 0)
            {
                var (_, account) = await _accountRepository.GetAccountByIdAsync(model.AccountId, cancellationToken);
                order = new Order(account);
                (_, order) = await _orderRepository.InsertOrderAsync(order, cancellationToken);
            }
            var orderDetail = model.GetInsertModel(order, product);

            var (success3, response) = await _orderRepository.UpsertOrderDetailAsync(orderDetail, cancellationToken);
            var result = response.GetViewModel();
            return (success3, result);
        }
    }
}
