package org.sportx.sportx.model;

public class ProductItem {
    private int productItemId;
    private int qtyInStock;
    private String SKU;
    private String imageUrl;

    // Getters, Setters, Construtor
    public ProductItem(int productItemId, int qtyInStock, String SKU, String imageUrl) {
        this.productItemId = productItemId;
        this.qtyInStock = qtyInStock;
        this.SKU = SKU;
        this.imageUrl = imageUrl;
    }

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

    public boolean isInStock() {
        return qtyInStock > 0;
    }

    public void reduceStock(int quantity) {
        if (qtyInStock >= quantity) {
            qtyInStock -= quantity;
        }
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
