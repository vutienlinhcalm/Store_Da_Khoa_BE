using System;
using System.Collections.Generic;
using Core.ViewModel;
using Microsoft.CodeAnalysis;

namespace Core.DBContext.ClothesStoreDataTable;

public partial class Product
{
    public Product()
    {
        this.Categories = new HashSet<Category>();
    }
    public string ProductId { get; set; }

    public string? Brand { get; set; }

    public string? ProductName { get; set; }

    public string? Description { get; set; }

    public string? MainImage { get; set; }

    public string? SubImage1 { get; set; }

    public string? SubImage2 { get; set; }

    public int? Price { get; set; }

    public int? StoreQuantity { get; set; }

    public int? Gender { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; } = new List<OrderDetail>();

    public virtual ICollection<Category> Categories { get; set; } = new List<Category>();
    public ProductViewModel GetViewModel()
    {
        var p = new ProductViewModel();
        p.ProductId = ProductId;
        p.Brand = Brand;
        p.ProductName = ProductName;
        p.Description = Description;
        p.MainImage = MainImage;
        p.SubImage1 = SubImage1;
        p.SubImage2 = SubImage2;
        p.Price = Price;
        p.StoreQuantity = StoreQuantity;
        p.Gender = Gender;
        p.Categories = Categories.Select(c => new CategoryViewModel
        {
            CategoryId = c.CategoryId,
            CategoryName = c.CategoryName,
            Description = c.Description
        }).ToList();

        return p;
    }
}
