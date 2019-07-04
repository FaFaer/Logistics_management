package model;

public class Goods {
    private int Goods_Id;
    private String Goods_Code;
    private String Goods_Price;
    private String Goods_Name;
    private String Goods_Type_Id;

    public Goods() {

    }

    public int getGoods_Id() {
        return Goods_Id;
    }

    public void setGoods_Id(int goods_Id) {
        Goods_Id = goods_Id;
    }

    public String getGoods_Price() {
        return Goods_Price;
    }

    public void setGoods_Price(String goods_Price) {
        Goods_Price = goods_Price;
    }

    public String getGoods_Code() {
        return Goods_Code;
    }

    public void setGoods_Code(String goods_Code) {
        Goods_Code = goods_Code;
    }

    public String getGoods_Name() {
        return Goods_Name;
    }

    public void setGoods_Name(String goods_Name) {
        Goods_Name = goods_Name;
    }

    public String getGoods_Type_Id() {
        return Goods_Type_Id;
    }

    public void setGoods_Type_Id(String goods_Type_Id) {
        Goods_Type_Id = goods_Type_Id;
    }
}