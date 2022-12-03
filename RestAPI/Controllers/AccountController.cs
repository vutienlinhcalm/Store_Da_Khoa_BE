using Microsoft.AspNetCore.Mvc;
using Core.ViewModel;
using Core.DBContext;

namespace RestAPI.Controllers
{
    [Route("api/Product")]
    [ApiController]
    public class AccountController : Controller
    {
        private readonly ClothesStoreDbContext _clothesStoreDbContext;

        public AccountController(ClothesStoreDbContext clothesStoreDbContext)
        {
            _clothesStoreDbContext = clothesStoreDbContext;
        }

        [HttpPost]
        [Route("CheckLogin")]
        public IActionResult GetListProduct([FromBody] LogInViewModel body, CancellationToken cancellationToken)
        {
            var _accountId = _clothesStoreDbContext.Customer
                .Where(x => x.Cusname == body.username && x.Password == body.password)
                .Select(x => x.Customerid).Take(1).ToList();

            if (_accountId.Count > 0)
            {
                return Ok("Log in successfully");
            }
            else
            {
                return Ok("No Information, Login failed");
            }
        }
    }
}
