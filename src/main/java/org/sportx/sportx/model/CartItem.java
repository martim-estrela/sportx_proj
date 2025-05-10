package org.sportx.sportx.model;

public class CartItem {
    private int productItemId;
    private String productName;
    private double price;
    private int quantity;
    private String color;
    private String size;
    private String imageUrl;

    // Construtor
    public CartItem(int productItemId, String productName, double price, int quantity, String color, String size, String imageUrl) {
        this.productItemId = productItemId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
        this.size = size;
        this.imageUrl = imageUrl;  // Inicialize isso
    }

    // Getters e Setters
    public int getProductItemId() { return productItemId; }
    public void setProductItemId(int productItemId) { this.productItemId = productItemId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getImageUrl() { return imageUrl; }  // Adicione isso
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }  // Adicione isso

    // Método útil para calcular o subtotal
    public double getSubtotal() {
        return price * quantity;
    }
}