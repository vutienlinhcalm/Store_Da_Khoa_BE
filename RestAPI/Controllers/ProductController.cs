using Core.DBContext.ClothesStoreDataTable;
using Core.IServices;
using Core.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Services;

namespace RestAPI.Controllers
{
    [Route("api/Product")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;
        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        [Route("GetListProduct")]
        public async Task<IActionResult> GetListProductAsync(CancellationToken cancellationToken)
        {
            var (success, _response) = await _productService.GetAllProductAsync(cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpGet]
        [Route("GetProductById/{id}")]
        public async Task<IActionResult> GetProductByIdAsync([FromRoute] string id, CancellationToken cancellationToken)
        {
            var (success, _response) = await _productService.GetProductByIdAsync(id, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpGet]
        [Route("GetProductByListCategory")]
        public async Task<IActionResult> GetProductByListCategoryAsync([FromQuery] List<string> category, CancellationToken cancellationToken)
        {
            var (success, _response) = await _productService.GetProductByListCategoryAsync(category, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpPost]
        [Route("CreateProduct")]
        public async Task<IActionResult> CreateProductAsync([FromBody] ProductViewModel product, CancellationToken cancellationToken)
        {
            var (success, _response) = await _productService.CreateProductAsync(product, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpPost]
        [Route("CreateListProduct")]
        public async Task<IActionResult> CreateListProductAsync([FromBody] List<ProductViewModel> products, CancellationToken cancellationToken)
        {
            var (success, _response) = await _productService.CreateListProductAsync(products, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpPut]
        [Route("UpdateProduct/{id}")]
        public async Task<IActionResult> UpdateProductAsync([FromRoute] string id,[FromBody] ProductViewModel product, CancellationToken cancellationToken)
        {
            product.ProductId = id;
            var (success, _response) = await _productService.UpdateProductAsync(product, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }
    }
}
