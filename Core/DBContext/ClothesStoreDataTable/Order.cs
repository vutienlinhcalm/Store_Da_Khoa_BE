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

    public virtual ICollection<OrderDetail> OrderDetails { get; } = new List<OrderDetail>();
}
