using System;
using System.Collections.Generic;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class OrderDetail
{
    public string OrderId { get; set; }

    public string ProductId { get; set; }

    public int? Quantity { get; set; }

    public int? Price { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
