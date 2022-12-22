using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.ViewModel;
using Microsoft.CodeAnalysis;
using Microsoft.EntityFrameworkCore;

namespace Repositories
{
    public class AccountRepository : IAccountRepository
    {
        private readonly ClothesStoreDbContext _clothesStoreDbContext;
        public AccountRepository(ClothesStoreDbContext clothesStoreDbContext)
        {
            _clothesStoreDbContext = clothesStoreDbContext;
        }

        public async Task<(int, Account)> GetAccountByIdAsync(string id, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Accounts
                .Where(acc => acc.AccountId == id)
                .FirstOrDefaultAsync(cancellationToken);
            if (result == null)
            {
                return (0, new Account());
            }
            return (1, result);
        }

        public async Task<(int, Account)> GetAccountByUsernameAsync(string username, CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Accounts
                .Where(acc => acc.UserName == username)
                .FirstOrDefaultAsync(cancellationToken);

            if (result != null) return (1, result);
            else return (0, new Account());
        }

        public async Task<(int, Account)> CreateAccountAsync(AccountViewModel account, CancellationToken cancellationToken)
        {
            if (_clothesStoreDbContext.Accounts.Any(acc => acc.UserName == account.UserName))
            {
                return(1, new Account());
            }

            var acc = account.GetInsertModel();

            await _clothesStoreDbContext.Accounts.AddAsync(acc, cancellationToken);
            _clothesStoreDbContext.SaveChanges();
            return (1, acc);
        }
    }
}
