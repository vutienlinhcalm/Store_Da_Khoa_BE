using Core.DBContext;
using Services;
using Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.Sql;
using Core.IRepositories;
using Core.IServices;
using System.Text.Json.Serialization;

namespace RestAPI
{
    public class Program
    {

        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Connect DB
            var ConnectionString = builder.Configuration.GetConnectionString("ClothesStore");

            //Entity Framework  
            builder.Services.AddDbContext<ClothesStoreDbContext>(options => options.UseSqlServer(ConnectionString));

            // Add services to the container.
            builder.Services.AddControllers().AddJsonOptions(x =>
                x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);

            // Register Types
            builder.Services.AddScoped<IProductService, ProductService>();
            builder.Services.AddScoped<IProductRepository, ProductRepository>();

            builder.Services.AddScoped<IOrderService, OrderService>();
            builder.Services.AddScoped<IOrderRepository, OrderRepository>();

            builder.Services.AddScoped<IAccountService, AccountService>();
            builder.Services.AddScoped<IAccountRepository, AccountRepository>();

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            // Add Cors
            var MyAllowAnyOrigins = "_myAllowAnyOrigins";
            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: MyAllowAnyOrigins,
                                  policy =>
                                  {
                                      policy.AllowAnyMethod()
                                      .AllowAnyHeader()
                                      .AllowAnyOrigin();
                                  });
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors(MyAllowAnyOrigins);

            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }
    }
}