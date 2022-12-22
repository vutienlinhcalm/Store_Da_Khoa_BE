using Microsoft.AspNetCore.Mvc;
using Core.IRepositories;
using Core.DBContext;
using Microsoft.EntityFrameworkCore;
using Core.DBContext.ClothesStoreDataTable;
using Core.ViewModel;

namespace RestAPI.Controllers
{
    [Route("api/demo")]
    [ApiController]
    public class DemoController : ControllerBase
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
                .ToListAsync();
            var result_ = result.Select(p => p.GetViewModel()).ToList();
            return Ok(result_);
        }
        [HttpPost]
        [Route("CreateProduct")]
        public async Task<IActionResult> GetListProductAsync([FromBody] string id, CancellationToken cancellationToken)
        {
            var result = _clothesStoreDbContext.Products.Update(new Product() { ProductId = id});
            await _clothesStoreDbContext.SaveChangesAsync();
            return Ok(new Product() { ProductId = id });
        }
        [HttpGet]
        [Route("GetListOrder")]
        public async Task<IActionResult> GetListOrder(CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Orders
                .Include(o => o.Account)
                .Include(o => o.OrderDetails).ThenInclude(orderDetail => orderDetail.Product)
                .ToListAsync();
            var result_ = result.Select(o => o.GetViewModel()).ToList();
            return Ok(result_);
        }
        [HttpPost]
        [Route("CreateOrder")]
        public async Task<IActionResult> GetListProductAsync([FromBody] OrderDetailViewModel model, CancellationToken cancellationToken)
        {
            var product = await _clothesStoreDbContext.Products.SingleAsync(p => p.ProductId == model.ProductId);
            if (_clothesStoreDbContext.OrderDetails.Any(order => order.ProductId == model.ProductId && order.OrderId == model.OrderId))
            {
                var result = _clothesStoreDbContext.OrderDetails.Update(model.GetInsertModel(product));
                await _clothesStoreDbContext.SaveChangesAsync(cancellationToken);
                return Ok(model.GetInsertModel(product).GetViewModel());
            }
            else
            {
                var result = await _clothesStoreDbContext.OrderDetails.AddAsync(model.GetInsertModel(product), cancellationToken);
                _clothesStoreDbContext.SaveChanges();
                return Ok(model.GetInsertModel(product).GetViewModel());
            }
            
        }
        [HttpGet]
        [Route("GetEmptyTest")]
        public async Task<IActionResult> GetEmptyTest(CancellationToken cancellationToken)
        {
            var result = await _clothesStoreDbContext.Products
                .Where(p => p.ProductId == "xxx")
                .FirstAsync();
            var result_ = result.GetViewModel();
            return Ok(result_);
        }
    }
}
