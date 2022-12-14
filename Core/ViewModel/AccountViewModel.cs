using Core.DBContext.ClothesStoreDataTable;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.ViewModel
{
    public class AccountViewModel
    {
        public string AccountId { get; set; } = null!;

        public string? Name { get; set; }

        public string? UserName { get; set; }

        public string? Password { get; set; }

        public bool? IsAdmin { get; set; }

        public string? Email { get; set; }

        public string? Phone { get; set; }

        public Account GetInsertModel()
        {
            var account = new Account()
            {
                AccountId = Guid.NewGuid().ToString(),
                Name = Name,
                UserName = UserName,
                Password = Password,
                IsAdmin = IsAdmin,
                Email = Email,
                Phone = Phone
            };

            return account;
        }
    }
}
