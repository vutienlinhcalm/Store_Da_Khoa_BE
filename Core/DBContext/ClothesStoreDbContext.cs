using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DBContext.ClothesStoreDataTable;
using Microsoft.EntityFrameworkCore;

namespace Core.DBContext
{
    public class ClothesStoreDbContext : DbContext
    {
        public ClothesStoreDbContext(DbContextOptions<ClothesStoreDbContext> options) : base(options)
        {
        }

        public virtual DbSet<Account> Accounts { get; set; }

        public virtual DbSet<Category> Categories { get; set; }

        public virtual DbSet<Order> Orders { get; set; }

        public virtual DbSet<OrderDetail> OrderDetails { get; set; }

        public virtual DbSet<Product> Products { get; set; }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //    => optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=ClothesStore;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");

        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Account>(entity =>
        //    {
        //        entity.HasKey(e => e.AccountId).HasName("PK__Account__349DA5A62E8C32DC");

        //        entity.ToTable("Account");

        //        entity.Property(e => e.AccountId).HasMaxLength(1);
        //        entity.Property(e => e.Email).HasMaxLength(1);
        //        entity.Property(e => e.Name)
        //            .HasMaxLength(1)
        //            .IsUnicode(false);
        //        entity.Property(e => e.Password).HasMaxLength(1);
        //        entity.Property(e => e.Phone).HasMaxLength(1);
        //        entity.Property(e => e.UserName).HasMaxLength(1);
        //    });

        //    modelBuilder.Entity<Category>(entity =>
        //    {
        //        entity.HasKey(e => e.CategoryId).HasName("PK__Category__19093A0B38C9DF75");

        //        entity.ToTable("Category");

        //        entity.Property(e => e.CategoryId).ValueGeneratedNever();
        //        entity.Property(e => e.CategoryName)
        //            .HasMaxLength(1)
        //            .IsUnicode(false);
        //        entity.Property(e => e.Description)
        //            .HasMaxLength(1)
        //            .IsUnicode(false);
        //    });

        //    modelBuilder.Entity<Order>(entity =>
        //    {
        //        entity.HasKey(e => e.OrderId).HasName("PK__Order__C3905BCFD96295CD");

        //        entity.ToTable("Order");

        //        entity.Property(e => e.OrderId).ValueGeneratedNever();
        //        entity.Property(e => e.AccountId).HasMaxLength(1);
        //        entity.Property(e => e.Address).HasMaxLength(1);
        //        entity.Property(e => e.OrderTime).HasColumnType("datetime");
        //        entity.Property(e => e.PaymentMethod).HasMaxLength(1);

        //        entity.HasOne(d => d.Account).WithMany(p => p.Orders)
        //            .HasForeignKey(d => d.AccountId)
        //            .HasConstraintName("FK_Order_Account");
        //    });

        //    modelBuilder.Entity<OrderDetail>(entity =>
        //    {
        //        entity.HasKey(e => new { e.OrderId, e.ProductId });

        //        entity.ToTable("OrderDetail");

        //        entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
        //            .HasForeignKey(d => d.OrderId)
        //            .OnDelete(DeleteBehavior.ClientSetNull)
        //            .HasConstraintName("FK_OrderDetail_Order");

        //        entity.HasOne(d => d.Product).WithMany(p => p.OrderDetails)
        //            .HasForeignKey(d => d.ProductId)
        //            .OnDelete(DeleteBehavior.ClientSetNull)
        //            .HasConstraintName("FK_OrderDetail_Product");
        //    });

        //    modelBuilder.Entity<Product>(entity =>
        //    {
        //        entity.HasKey(e => e.ProductId).HasName("PK__Product__B40CC6CDDFF8F1AB");

        //        entity.ToTable("Product");

        //        entity.Property(e => e.ProductId).ValueGeneratedNever();
        //        entity.Property(e => e.Brand).HasMaxLength(1);
        //        entity.Property(e => e.Description).HasMaxLength(1);
        //        entity.Property(e => e.MainImage).HasMaxLength(1);
        //        entity.Property(e => e.ProductName).HasMaxLength(1);
        //        entity.Property(e => e.SubImage1).HasMaxLength(1);
        //        entity.Property(e => e.SubImage2).HasMaxLength(1);

        //        entity.HasMany(d => d.Categories).WithMany(p => p.Products)
        //            .UsingEntity<Dictionary<string, object>>(
        //                "ProductCateglory",
        //                r => r.HasOne<Category>().WithMany()
        //                    .HasForeignKey("CategoryId")
        //                    .OnDelete(DeleteBehavior.ClientSetNull)
        //                    .HasConstraintName("FK_ProductCateglory_Category"),
        //                l => l.HasOne<Product>().WithMany()
        //                    .HasForeignKey("ProductId")
        //                    .OnDelete(DeleteBehavior.ClientSetNull)
        //                    .HasConstraintName("FK_ProductCateglory_Product"),
        //                j =>
        //                {
        //                    j.HasKey("ProductId", "CategoryId");
        //                    j.ToTable("ProductCateglory");
        //                });
        //    });

        //    OnModelCreatingPartial(modelBuilder);
        //}

        //partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
