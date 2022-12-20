using Azure;
using Core.IServices;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

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
        [Route("GetOrderDetailByOrderId/{id}")]
        public async Task<IActionResult> GetOrderDetailByOrderIdAsync([FromRoute] string id, CancellationToken cancellationToken) 
        {
            var (success, _response) = await _orderService.GetOrderDetailByOrderIdAsync(id, cancellationToken);
            var _result = new
            {
                Success = success,
                Data = _response
            };
            return Ok(_result);
        }
    }
}
