package org.sportx.sportx.DTO;

import java.util.*;

public class ProductDTO {
    private int productId;
    private int productItemId;
    private String name;
    private String description;
    private String brand;
    private double price;
    private String image;
    private int stock;
    private Set<String> colors = new HashSet<>();
    private Set<String> sizes = new HashSet<>();


    public ProductDTO() {

    }




    // Getters e setters (podes gerar com IDE se quiseres)
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getProductItemId() { return productItemId; }
    public void setProductItemId(int productItemId) { this.productItemId = productItemId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    public Set<String> getColors() { return colors; }
    public void setColors(Set<String> colors) { this.colors = colors; }
    public Set<String> getSizes() { return sizes; }
    public void setSizes(Set<String> sizes) { this.sizes = sizes; }




}
