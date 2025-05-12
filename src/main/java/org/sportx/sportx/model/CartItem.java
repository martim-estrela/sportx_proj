package org.sportx.sportx.model;

import java.util.Map;
import java.util.HashMap;

public class CartItem {
    private int productId;
    private int productItemId;
    private String productName;
    private double price;
    private int quantity;
    private Map<String, String> variations;
    private String imageUrl;
    private int stock;

    // Updated constructor
    public CartItem(int productId, int productItemId, String productName,
                    double price, int quantity, Map<String, String> variations,
                    String imageUrl, int stock) {
        this.productId = productId;
        this.productItemId = productItemId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.variations = variations != null ? new HashMap<>(variations) : new HashMap<>();
        this.imageUrl = imageUrl;
        this.stock = stock;
    }

    // Getters e Setters
    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductItemId() {
        return productItemId;
    }

    public void setProductItemId(int productItemId) {
        this.productItemId = productItemId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Map<String, String> getVariations() {
        return new HashMap<>(variations);
    }

    public void setVariations(Map<String, String> variations) {
        this.variations = variations != null ? new HashMap<>(variations) : new HashMap<>();
    }

    public String getVariation(String key) {
        return variations.get(key);
    }

    public void addVariation(String key, String value) {
        this.variations.put(key, value);
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    // Método para obter o subtotal
    public double getSubtotal() {
        return price * quantity;
    }

    // Método para verificar se é o mesmo item (usado para comparação no carrinho)
    public boolean isSameItem(CartItem other) {
        if (this.productItemId != other.productItemId) return false;
        return this.variations.equals(other.variations);
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "productId=" + productId +
                ", productItemId=" + productItemId +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", variations=" + variations +
                ", imageUrl='" + imageUrl + '\'' +
                '}';
    }
}