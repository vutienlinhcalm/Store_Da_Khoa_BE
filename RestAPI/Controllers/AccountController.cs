using Core.DBContext.ClothesStoreDataTable;
using Core.IServices;
using Core.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Services;
using System.Diagnostics.Metrics;
using System.Threading;

namespace RestAPI.Controllers
{
    [Route("api/Account")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _accountService;

        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        [HttpGet]
        [Route("GetAccountById/{id}")]
        public async Task<IActionResult> GetAccountByIdAsync([FromRoute] string id, CancellationToken cancellationToken)
        {
            var (success, _response) = await _accountService.GetAccountByIdAsync(id, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpPost]
        [Route("LogIn")]
        public async Task<IActionResult> LogInAsync([FromBody] LogInViewModel model, CancellationToken cancellationToken)
        {
            if (model.username == "" || model.password == "")
            {
                return Ok(new { Success = 0, Data = "", Message = "Username and password cannot be empty" });
            }
            var (success, _response, message) = await _accountService.LogInAsync(model.username, model.password, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response,
                Message = message
            };
            return Ok(_result);
        }

        [HttpPost]
        [Route("CreateAccount")]
        public async Task<IActionResult> CreateAccountAsync([FromBody] AccountViewModel account, CancellationToken cancellationToken)
        {
            var (success, _response, message) = await _accountService.CreateAccountAsync(account, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response,
                Message = message
            };
            return Ok(_result);
        }
    }
}
