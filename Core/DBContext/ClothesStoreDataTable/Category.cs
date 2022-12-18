﻿using System;
using System.Collections.Generic;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Category
{
    public int CategoryId { get; set; }

    public string? CategoryName { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<Product> Products { get; } = new List<Product>();
}
