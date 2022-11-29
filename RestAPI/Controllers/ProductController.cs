using Microsoft.AspNetCore.Mvc;
using Core.DBContext;
using Microsoft.EntityFrameworkCore;

namespace RestAPI.Controllers
{
    [Route("api/Product")]
    [ApiController]
    public class ProductController : Controller
    {
        private readonly ClothesStoreDbContext _clothesStoreDbContext;

        public ProductController(ClothesStoreDbContext clothesStoreDbContext)
        {
            _clothesStoreDbContext = clothesStoreDbContext;
        }

        [HttpGet]
        [Route("GetListProduct")]
        public IActionResult GetListProduct(CancellationToken cancellationToken)
        {
            var _result = _clothesStoreDbContext.Product.ToList();
            return Ok(_result);
        }
    }
}
