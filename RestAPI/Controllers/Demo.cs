using Core.DBContext;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace RestAPI.Controllers
{
    [Route("api/Demo")]
    [ApiController]
    public class Demo : Controller
    {
        public readonly NorthwindDbContext _northwindDbContext;

        public Demo(NorthwindDbContext northwindDbContext)
        {
            _northwindDbContext = northwindDbContext;
        }

        [HttpGet]
        [Route("Success")]
        public IActionResult GetSuccessResult()
        {
            var resultSuccess = "Success";

            return Ok(resultSuccess);
        }

        [HttpGet]
        [Route("SuccessAsync")]
        public async Task<IActionResult> GetSuccessResultAsync()
        {
            var resultSuccess = "Success";
            await Task.Delay(5000);
            return Ok(resultSuccess);
        }

        [HttpGet]
        [Route("Demo_all_items")]
        public async Task<IActionResult> DemoAllItems()
        {
            var result = await _northwindDbContext.Products.LongCountAsync();
            return Ok(result);
        }
    }
}
