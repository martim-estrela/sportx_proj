package org.sportx.sportx.DTO;

import java.util.HashMap;
import java.util.Map;

public class ProductItemDTO {
    private int productItemId;

    private double price;
    private int qtyInStock;
    private String productImage;
    private Map<String, String> variations; // Ex: "cor" -> "azul", "tamanho" -> "M"

    public ProductItemDTO(int productItemId, double price, int qtyInStock, String productImage) {
        this.productItemId = productItemId;
        this.price = price;
        this.qtyInStock = qtyInStock;
        this.productImage = productImage;
        this.variations = new HashMap<>();
    }

    public void addVariation(String variationType, String variationValue) {
        this.variations.put(variationType, variationValue);
    }

    // Getters e setters
    public int getProductItemId() { return productItemId; }
    public double getPrice() { return price; }
    public int getQtyInStock() { return qtyInStock; }
    public String getProductImage() { return productImage; }
    public Map<String, String> getVariations() { return variations; }

}

