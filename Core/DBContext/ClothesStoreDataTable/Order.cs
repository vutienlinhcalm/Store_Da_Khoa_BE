using Core.ViewModel;
using System;
using System.Collections.Generic;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Order
{
    public string OrderId { get; set; }

    public string? AccountId { get; set; }

    public DateTime? OrderTime { get; set; }

    public string? PaymentMethod { get; set; }

    public string? Address { get; set; }

    public int? Status { get; set; }

    public int? TotalPrice { get; set; }

    public virtual Account? Account { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public OrderViewModel GetViewModel()
    {
        var order = new OrderViewModel()
        {
            OrderId = OrderId,
            AccountId = AccountId,
            OrderTime = OrderTime,
            PaymentMethod = PaymentMethod,
            Address = Address,
            Status = Status,
            TotalPrice = TotalPrice,
            Account = Account.GetViewModel(),
            OrderDetails = OrderDetails.Select(orderDetail => orderDetail.GetViewModel()).ToList(),
        };

        return order;
    }
}
