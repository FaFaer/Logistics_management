package model;

public class Goods_type {
    private int Goods_Id;
    private String Goods_Code;
    private String Goods_Name;

    public Goods_type() {

    }

    public int getGoods_Id() {
        return Goods_Id;
    }

    public void setGoods_Id(int goods_Id) {
        Goods_Id = goods_Id;
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
}