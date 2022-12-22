using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.ViewModel;
using Microsoft.CodeAnalysis;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace Repositories
{
    public class OrderRepository : IOrderRepository
    {
        private readonly ClothesStoreDbContext _clothesStoreDbContext;
        public OrderRepository(ClothesStoreDbContext clothesStoreDbContext)
        {
            _clothesStoreDbContext = clothesStoreDbContext;
        }

        public async Task<(int, List<Order>)> GetListOrderAsync(CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Orders
                .Include(o => o.Account)
                .Include(o => o.OrderDetails).ThenInclude(orderDetail => orderDetail.Product)
                .ToListAsync(cancellationToken);
            return (1, result);
        }

        public async Task<(int, Order)> GetOrderByIdAsync(string id, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Orders
                .Where(or => or.OrderId == id)
                .Include(o => o.OrderDetails).ThenInclude(orderDetail => orderDetail.Product)
                .FirstOrDefaultAsync(cancellationToken);
            if (result == null)
            {
                return (0, new Order());
            }
            return (1, result);
        }

        public async Task<(int, List<Order>)> GetListOrderByAccountIdAsync(string accountId, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Orders
                .Where(or => or.AccountId == accountId)
                .Include(o => o.OrderDetails).ThenInclude(orderDetail => orderDetail.Product)
                .ToListAsync(cancellationToken);
            return (1, result);
        }

        public async Task<(int, Order)> InsertOrderAsync(Order order, CancellationToken cancellationToken)
        {
            await _clothesStoreDbContext.Orders.AddAsync(order, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, order);
        }

        public async Task<(int, OrderDetail)> UpsertOrderDetailAsync(OrderDetail orderDetail, CancellationToken cancellationToken)
        {
            if (_clothesStoreDbContext.OrderDetails.Any(_orderDetail => _orderDetail.OrderId == orderDetail.OrderId && _orderDetail.ProductId == orderDetail.ProductId))
            {
                _clothesStoreDbContext.Update(orderDetail);
                await _clothesStoreDbContext.SaveChangesAsync(cancellationToken);
                return (1, orderDetail);
            }
            else
            {
                await _clothesStoreDbContext.AddAsync(orderDetail, cancellationToken);
                _clothesStoreDbContext.SaveChanges();
                return (1, orderDetail);
            }
        }
    }
}
