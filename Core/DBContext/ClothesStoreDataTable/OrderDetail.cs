using Core.ViewModel;
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

    public OrderDetailViewModel GetViewModel()
    {
        var orderDetail = new OrderDetailViewModel()
        {
            OrderId = OrderId,
            ProductId = ProductId,
            Quantity = Quantity,
            Price = Price,
            Product = Product.GetViewModel()
        };

        return orderDetail;
    }
}
