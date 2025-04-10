package model;

public class ProductCategoryChild {
    private int subCategoryId;
    private String name;

    // Getters, Setters, Construtor
    public ProductCategoryChild(int subCategoryId, String name) {
        this.subCategoryId = subCategoryId;
        this.name = name;
    }

    public int getSubCategoryId() {
        return subCategoryId;
    }

    public void setSubCategoryId(int subCategoryId) {
        this.subCategoryId = subCategoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
