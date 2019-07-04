package model;

public class Order_goods {
    private int Order_Goods_Id;
    private String Order_Code;
    private String Order_Goods_Code;
    private int Oder_Goods_Amount;

    public Order_goods() {

    }

    public Order_goods(String order_Code, String order_Goods_Code, int oder_Goods_Amount) {
        Order_Code = order_Code;
        Order_Goods_Code = order_Goods_Code;
        Oder_Goods_Amount = oder_Goods_Amount;
    }

    public int getOrder_Goods_Id() {
        return Order_Goods_Id;
    }

    public void setOrder_Goods_Id(int order_Goods_Id) {
        Order_Goods_Id = order_Goods_Id;
    }

    public String getOrder_Code() {
        return Order_Code;
    }

    public void setOrder_Code(String order_Code) {
        Order_Code = order_Code;
    }

    public String getOrder_Goods_Code() {
        return Order_Goods_Code;
    }

    public void setOrder_Goods_Code(String order_Goods_Code) {
        Order_Goods_Code = order_Goods_Code;
    }


    public int getOder_Goods_Amount() {
        return Oder_Goods_Amount;
    }

    public void setOder_Goods_Amount(int oder_Goods_Amount) {
        Oder_Goods_Amount = oder_Goods_Amount;
    }
}