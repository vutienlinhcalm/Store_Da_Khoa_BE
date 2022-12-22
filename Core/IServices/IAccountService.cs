using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.IServices
{
    public interface IAccountService
    {
        Task<(int, AccountViewModel)> GetAccountByIdAsync(string id, CancellationToken cancellationToken);
        Task<(int, AccountViewModel, string)> LogInAsync(string username, string password, CancellationToken cancellationToken);
        Task<(int, AccountViewModel, string)> CreateAccountAsync(AccountViewModel account, CancellationToken cancellationToken);
    }
}
