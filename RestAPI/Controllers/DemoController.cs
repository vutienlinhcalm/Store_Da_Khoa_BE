using Microsoft.AspNetCore.Mvc;
using Core.IRepositories;
using Core.DBContext;
using Microsoft.EntityFrameworkCore;

namespace RestAPI.Controllers
{
    [Route("api/demo/Product")]
    [ApiController]
    public class DemoController : Controller
    {
        private readonly ClothesStoreDbContext _clothesStoreDbContext;
        public DemoController(ClothesStoreDbContext clothesStoreDbContext)
        {
            _clothesStoreDbContext = clothesStoreDbContext;
        }
        [HttpGet]
        [Route("GetListProduct")]
        public async Task<IActionResult> GetListProductAsync(CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Products
                .Include(p => p.Categories)
                .ToListAsync();
            var result_ = result.Select(p => p.GetViewModel()).ToList();
            return Ok(result_);
        }
    }
}
