using Microsoft.AspNetCore.Mvc;

namespace RestAPI.Controllers
{
    [Route("api/Demo")]
    [ApiController]
    public class Demo : Controller
    {
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


    }
}
