package org.sportx.sportx.model;

import java.time.LocalDate;

public class Product {
    private int id;
    private String name;
    private String description;
    private String brand;
    private double price;
    private String imageUrl;
    private Promotion promotion;

    // Constructors
    public Product() {
    }

    public Product(int id, String name, String description, String brand, Promotion promotion, double price, String imageUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.brand = brand;
        this.price = price;
        this.imageUrl = imageUrl;
        this.promotion = promotion;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
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

    public Promotion getPromotion() {
        return promotion;
    }

    public void setPromotion(Promotion promotion) {
        this.promotion = promotion;
    }

    // Métodos úteis para promoções
    public boolean hasActivePromotion() {
        if (promotion == null) return false;
        LocalDate today = LocalDate.now();
        return promotion.getDiscountRate() > 0 &&
                !today.isBefore(promotion.getStartDate()) &&
                !today.isAfter(promotion.getEndDate());
    }

    public double getDiscountedPrice() { // correto
        if (!hasActivePromotion()) return price;
        return price * ((100.00 - promotion.getDiscountRate())/100.0);
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", brand='" + brand + '\'' +
                ", price=" + price +
                '}';
    }

}