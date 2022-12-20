using Azure;
using Core.IServices;
using Core.ViewModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Client;

namespace RestAPI.Controllers
{
    [Route("api/Order")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderService _orderService;
        public OrderController(IOrderService orderService)
        {
            _orderService = orderService;
        }

        [HttpGet]
        [Route("GetOrderById/{id}")]
        public async Task<IActionResult> GetOrderByIdAsync([FromRoute] string id, CancellationToken cancellationToken) 
        {
            var (success, _response) = await _orderService.GetOrderByIdAsync(id, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }

        [HttpGet]
        [Route("GetListOrderByAccountId/{id}")]
        public async Task<IActionResult> GetListOrderByAccountIdAsync([FromRoute] string accountId, CancellationToken cancellationToken)
        {
            var (success, _response) = await _orderService.GetListOrderByAccountIdAsync(accountId, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }
        [HttpPost]
        [Route("CreateOrder")]
        public async Task<IActionResult> CreateOrderAsync([FromBody] OrderViewModel order, CancellationToken cancellationToken)
        {
            var (success, _response) = await _orderService.CreateOrderAsync(order, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }
    }
}
