package shoes;

public class StockItem {
    private String shoesId;
    private String stock;

    public StockItem(String shoesId, String stock) {
        this.shoesId = shoesId;
        this.stock = stock;
    }

    public String getShoesId() {
        return shoesId;
    }

    public void setShoesId(String shoesId) {
        this.shoesId = shoesId;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }
}
