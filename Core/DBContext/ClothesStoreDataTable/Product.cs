using System;
using System.Collections.Generic;
using Core.ViewModel;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Product
{
    public int ProductId { get; set; }

    public string? Brand { get; set; }

    public string? ProductName { get; set; }

    public string? Description { get; set; }

    public string? MainImage { get; set; }

    public string? SubImage1 { get; set; }

    public string? SubImage2 { get; set; }

    public int? Price { get; set; }

    public int? StoreQuantity { get; set; }

    public int? Gender { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; } = new List<OrderDetail>();

    public virtual ICollection<Category> Categories { get; } = new List<Category>();
}
