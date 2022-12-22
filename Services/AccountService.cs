using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Azure;
using Core.DBContext;
using Core.DBContext.ClothesStoreDataTable;
using Core.IRepositories;
using Core.IServices;
using Core.ViewModel;
using Repositories;

namespace Services
{
    public class AccountService : IAccountService
    {
        private readonly IAccountRepository _accountRepository;

        public AccountService(IAccountRepository accountRepository)
        {
            _accountRepository = accountRepository;
        }

        public async Task<(int, AccountViewModel)> GetAccountByIdAsync (string id, CancellationToken cancellationToken)
        {
            var (success, response) = await _accountRepository.GetAccountByIdAsync(id, cancellationToken);
            var result = response.GetViewModel();
            return (success, result);
        }

        public async Task<(int, AccountViewModel, string)> LogInAsync(string username, string password, CancellationToken cancellationToken)
        {
            var (success, response) = await _accountRepository.GetAccountByUsernameAsync(username, cancellationToken);

            var result = response.GetViewModel();
            if (success == 1)
            {
                if (response.Password == password)
                {
                    return (1, result, "Logged in successfully");
                }
                else
                {
                    return (-1, result, "Wrong password");
                }
            }
            else
            {
                return (0, result, "Account does not exist");
            }
        }

        public async Task<(int, AccountViewModel, string)> CreateAccountAsync(AccountViewModel account, CancellationToken cancellationToken)
        {
            var (success, response) = await _accountRepository.CreateAccountAsync(account, cancellationToken);
            var result = response.GetViewModel();
            if (success == 1) return (success, result, "Account created");
            else return (success, result, "Username is already in use");
        }
    }
}
