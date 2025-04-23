package org.sportx.sportx.model;

/**
 * Representa um produto na base de dados
 */
public class Product {
    private int productId;
    private String name;
    private String description;
    private double price;
    private String imageUrl;

    // Construtor vazio
    public Product() {
    }

    // Construtor com todos os campos
    public Product(int productId, String name, String description, double price, String imageUrl) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    // Getters e Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}