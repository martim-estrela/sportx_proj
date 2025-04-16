package org.sportx.sportx.DTO;

import java.util.ArrayList;
import java.util.List;

public class ProductDTO {
    private int productId;
    private String name;
    private String description;
    private List<ProductItemDTO> items;

    public ProductDTO(int productId, String name, String description) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.items = new ArrayList<>();
    }

    public void addItem(ProductItemDTO item) {
        this.items.add(item);
    }

    public ProductItemDTO getItemById(int productItemId) {
        for (ProductItemDTO item : items) {
            if (item.getProductItemId() == productItemId) {
                return item;
            }
        }
        return null;
    }

    // Getters e setters (podes gerar com IDE se quiseres)
    public int getProductId() { return productId; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public List<ProductItemDTO> getItems() { return items; }
    public void setItems(List<ProductItemDTO> items) { this.items = items; }
}
