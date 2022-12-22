using Core.DBContext.ClothesStoreDataTable;
using Core.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.IRepositories
{
    public interface IAccountRepository
    {
        Task<(int, Account)> GetAccountByIdAsync(string id, CancellationToken cancellationToken);
        Task<(int, Account)> GetAccountByUsernameAsync(string username, CancellationToken cancellationToken);
        Task<(int, Account)> CreateAccountAsync(AccountViewModel account, CancellationToken cancellationToken);
    }
}
