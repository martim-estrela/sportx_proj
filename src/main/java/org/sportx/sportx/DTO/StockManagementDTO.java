package org.sportx.sportx.DTO;

import org.sportx.sportx.model.Product;
import org.sportx.sportx.model.ProductItem;
import org.sportx.sportx.model.Variation;
import org.sportx.sportx.model.VariationOption;

public class StockManagementDTO {
    private int productItemID;
    private int qtyInStock;
    private String optionType;
    private String optionValue;



    public StockManagementDTO(int product_item_id, int qty_in_stock, String variation, String variation_option) {
        this.productItemID = product_item_id;
        this.qtyInStock = qty_in_stock;
        this.optionType = variation;
        this.optionValue = variation_option;

    }

    // Getters e Setters

    public String getOptionType() {
        return optionType;
    }

    public void setOptionType(String optionType) {
        this.optionType = optionType;
    }

    public String getOptionValue() {
        return optionValue;
    }

    public void setOptionValue(String optionValue) {
        this.optionValue = optionValue;
    }

    public int getProductItemID() {
        return productItemID;
    }
    public void setProductItemID(int productItemID) {
        this.productItemID = productItemID;
    }

    public int getQtyInStock() {
        return qtyInStock;
    }

    public void setQtyInStock(int qtyInStock) {
        this.qtyInStock = qtyInStock;
    }

}
