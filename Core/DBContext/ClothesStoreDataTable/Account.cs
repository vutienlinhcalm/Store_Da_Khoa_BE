using System;
using System.Collections.Generic;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Account
{
    public string AccountId { get; set; } = null!;

    public string? Name { get; set; }

    public string? UserName { get; set; }

    public string? Password { get; set; }

    public bool? IsAdmin { get; set; }

    public string? Email { get; set; }

    public string? Phone { get; set; }

    public virtual ICollection<Order> Orders { get; } = new List<Order>();
}
