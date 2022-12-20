using System;
using System.Collections.Generic;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Category
{
    public Category() {
        this.Products = new HashSet<Product>();
    }
    public string CategoryId { get; set; }

    public string? CategoryName { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<Product> Products { get; } = new List<Product>();
}
