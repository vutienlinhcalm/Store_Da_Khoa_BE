using Microsoft.EntityFrameworkCore;
using Core.DBContext;

namespace RestAPI
{
    public class Program
    {

        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Connect DB
            var connectionString = builder.Configuration.GetConnectionString("connectionString");
            builder.Services.AddDbContext<ProductDbContent>(x => x.UseSqlServer(connectionString));

            // Add services to the container.
            builder.Services.AddControllers();

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            // Add Cors
            var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: MyAllowSpecificOrigins,
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

            //app.UseCors(
            //    policy => policy.WithOrigins("https://localhost:44304")
            //                    .AllowAnyMethod()
            //                    .AllowAnyHeader()
            //);

            app.UseCors(MyAllowSpecificOrigins);

            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }
    }
}