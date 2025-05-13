package org.sportx.sportx.model;

public class ProductItem {
    private int productItemId;
    private int qtyInStock;
    private String SKU;
    private Double price;
    private String imageUrl;
    private int productId;

    // Construtor padrão público
    public ProductItem() {
    }

    // Construtor completo
    public ProductItem(int productItemId, int qtyInStock, String SKU, String imageUrl, Double price, int productId) {
        this.productItemId = productItemId;
        this.qtyInStock = qtyInStock;
        this.SKU = SKU;
        this.imageUrl = imageUrl;
        this.price = price;
        this.productId = productId;
    }

    // Getters e Setters
    public int getProductItemId() {
        return productItemId;
    }

    public void setProductItemId(int productItemId) {
        this.productItemId = productItemId;
    }

    public int getQtyInStock() {
        return qtyInStock;
    }

    public void setQtyInStock(int qtyInStock) {
        this.qtyInStock = qtyInStock;
    }

    public String getSKU() {
        return SKU;
    }

    public void setSKU(String SKU) {
        this.SKU = SKU;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }
    public Double getPrice() {
        return price;
    }
    public void setPrice(Double price) {
        this.price = price;
    }

    // Métodos auxiliares
    public boolean isInStock() {
        return qtyInStock > 0;
    }

    public void reduceStock(int quantity) {
        if (quantity > 0 && qtyInStock >= quantity) {
            qtyInStock -= quantity;
        }
    }
}