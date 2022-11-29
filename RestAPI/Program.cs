using Core.DBContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.Sql;

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
            builder.Services.AddDbContext<ClothesStoreDbContext>(options => options.UseSqlServer(ConnectionString,
                b => b.MigrationsAssembly("RestAPI")));

            // Add services to the container.
            builder.Services.AddControllers();

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