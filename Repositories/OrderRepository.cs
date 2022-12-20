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

        public async Task<(int, Order)> GetOrderByIdAsync(string id, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Orders
                .Where(or => or.OrderId == id)
                .Include(p => p.OrderDetails)
                .FirstAsync(cancellationToken);
            return (1, result);
        }

        public async Task<(int, List<Order>)> GetListOrderByAccountIdAsync(string accountId, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Orders
                .Where(or => or.AccountId == accountId)
                .Include(p => p.OrderDetails)
                .ToListAsync(cancellationToken);
            return (1, result);
        }

        public async Task<(int, Order)> InsertOrderAsync(OrderViewModel order, CancellationToken cancellationToken)
        {
            var o = GetInsertOrderModel(order);

            var result = await _clothesStoreDbContext.AddAsync(o, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, o);
        }

        public Order GetInsertOrderModel(OrderViewModel order)
        {
            var o = new Order()
            {
                OrderId = order.OrderId,
                AccountId = order.AccountId,
                OrderTime = order.OrderTime,
                PaymentMethod = order.PaymentMethod,
                Address = order.Address,
                Status = order.Status,
                TotalPrice = order.TotalPrice,
                Account = _clothesStoreDbContext.Accounts.Where(a => a.AccountId == order.AccountId).First(),
            };

            return o;
        }


    }
}
