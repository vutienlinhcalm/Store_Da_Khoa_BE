using Core.ViewModel;
using System;
using System.Collections.Generic;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Account
{
    public string AccountId { get; set; } = new Guid().ToString();

    public string? Name { get; set; }

    public string? UserName { get; set; }

    public string? Password { get; set; }

    public bool? IsAdmin { get; set; }

    public string? Email { get; set; }

    public string? Phone { get; set; }

    public virtual ICollection<Order> Orders { get; } = new List<Order>();
    public AccountViewModel GetViewModel()
    {
        var acc = new AccountViewModel()
        {
            AccountId = AccountId,
            Name = Name,
            UserName = UserName,
            Password = Password,
            IsAdmin = IsAdmin,
            Email = Email,
            Phone = Phone
        };

        return acc;
    }
}
