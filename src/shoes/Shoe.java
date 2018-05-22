package shoes;

public class Shoe {
    private int shoesId;
    private String name;
    private String brand;
    private String type;
    private String color;
    private long price;
    private String sex;
    private int size;
    private int stock;

    public Shoe() {
    }

    public Shoe(int shoesId, String name, String brand, String type, String color, long price, String sex, int size, int stock) {
        this.shoesId = shoesId;
        this.name = name;
        this.brand = brand;
        this.type = type;
        this.color = color;
        this.price = price;
        this.sex = sex;
        this.size = size;
        this.stock = stock;
    }

    public int getShoesId() {
        return shoesId;
    }

    public void setShoesId(int shoesId) {
        this.shoesId = shoesId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}
