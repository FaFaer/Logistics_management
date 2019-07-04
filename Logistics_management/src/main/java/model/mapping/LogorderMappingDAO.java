package model.mapping;

import model.*;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface LogorderMappingDAO {

    // 修改状态时查询某张订单
    @Select("SELECT * FROM LOG_ORDER WHERE ORDER_CODE=#{Order_Code}")
    public Log_order queryOnlyOrder(Log_order log_order);

    // 订单操作轨迹
    @Insert("INSERT INTO ORDER_TRACK(ORDER_CODE,PRE_STATUS,AFT_STATUS,OPERATION_TIME,USER_ID) VALUES(#{Order_Code},#{Pre_Status},#{Aft_Status},now(),#{User_Id})")
    public int addOrderTrack(Order_track orderTrack);

    // 修改状态
    @Update("UPDATE LOG_ORDER SET ORDER_STATUS=#{Order_Status} WHERE ORDER_CODE = #{Order_Code}")
    public int updateorderStatus(Log_order log_order);

    // 修改库存：导入的时候直接减少库存
    @Update(value = "UPDATE INVENTORY SET INVENTORY_AMOUNT = INVENTORY_AMOUNT-#{Oder_Goods_Amount} WHERE INVENTORY_GOODS_CODE = #{Order_Goods_Code}")
    public boolean updateInventory(Order_goods order_goods);

    // 修改库存：删除订单时，添加库存
    @Update(value = "UPDATE INVENTORY SET INVENTORY_AMOUNT = INVENTORY_AMOUNT+#{Oder_Goods_Amount} WHERE INVENTORY_GOODS_CODE = #{Order_Goods_Code}")
    public boolean updateInventoryForDown(Order_goods order_goods);

    // 出库订单添加车辆ID
    @Update("UPDATE LOG_ORDER SET VEHICLE_ID = #{Vehicle_Id},ORDER_STATUS='1' WHERE ORDER_CODE = #{Order_Code}")
    public boolean addvehicleforOrder(Log_order log_order);

    // 按订单编号查询车辆
    @Select("SELECT * FROM VEHICLE WHERE VEHICLE_WAREHOUSE = (SELECT WAREHOUSE_ID FROM LOG_ORDER WHERE ORDER_CODE = #{Order_Code}) AND Vehicle_Status = '0'")
    public List<Vehicle> searchVForOrder(Log_order log_order);

    // 删除订单
    @Delete("DELETE FROM LOG_ORDER WHERE ORDER_CODE = #{Order_Code}")
    public int deleteOrder(Log_order log_order);

    // 删除订单相关的订单商品表里的记录
    @Delete("DELETE FROM ORDER_GOODS WHERE ORDER_CODE = #{Order_Code}")
    public int deleteOrderGoods(Log_order log_order);

    // 根据客户编号查询客户详细信息
    @Select("SELECT CLIENTELE_NAME,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = C.PROVINCE) AS PROVINCE,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = C.CITY) AS CITY," +
            "(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = C.DISTRICT) AS DISTRICT,CLIENTELE_ADDRESS,CLIENTELE_PRINCIPAL,CLIENTELE_TEL,CREATE_TIME,UPDATE_TIME FROM CLIENTELE C WHERE CLIENTELE_CODE = #{Clientele_Code}")
    public Clientele orderClientele(Clientele clientele);

    // 根据订单号查询订单商品(商品名)
    @Select("SELECT ORDER_GOODS_CODE,(SELECT GOODS_NAME FROM GOODS WHERE GOODS_CODE = ORDER_GOODS_CODE) AS ORDER_CODE,ODER_GOODS_AMOUNT FROM ORDER_GOODS WHERE ORDER_CODE = #{Order_Code}")
    public List<Order_goods> orderGoodList(Order_goods order_goods);

    // 根据订单号操作轨迹表
    @Select("SELECT ORDER_CODE,PRE_STATUS,AFT_STATUS,OPERATION_TIME,(SELECT USER_NAME FROM USERS WHERE USER_ID = O.USER_ID) AS USER_ID FROM ORDER_TRACK O WHERE ORDER_CODE = #{Order_Code}")
    public List<Order_track> orderTrackList(Order_goods order_goods);

    // 根据订单号查询订单商品
    @Select("SELECT * FROM ORDER_GOODS WHERE ORDER_CODE = #{Order_Code}")
    public List<Order_goods> orderGoodList1(Log_order log_order);

    @Select("SELECT INVENTORY_GOODS_NAME,INVENTORY_GOODS_CODE,INVENTORY_AMOUNT FROM INVENTORY WHERE INVENTORY_GOODS_CODE = #{Order_Goods_Code} AND INVENTORY_WAREHOUSE_ID = #{Order_Code} AND INVENTORY_AMOUNT > 0")
    public Inventory queryInventory(Order_goods goods);

    // 查询客户是否存在
    @Select("SELECT * FROM CLIENTELE WHERE CLIENTELE_CODE = #{clienteleCode}")
    public Clientele queryId(String clienteleCode);

    // 插入订单表，先不选车
    @Insert("INSERT INTO lOG_ORDER(ORDER_CODE,CLIENTELE_ID,WAREHOUSE_ID,ORDER_STATUS,USER_ID,CREATE_TIME,UPDATE_TIME) VALUES(#{Order_Code},#{Clientele_Id},#{Warehouse_Id},#{Order_Status},#{User_Id},now(),now())")
    public int AddOrder(Log_order log_order);

    // 插入订单商品
    @InsertProvider(type = LogorderMappingDAO.LogOrderDaoProvider.class, method = "AddOrderGoods")
    public int AddOrderGoods(Order_goods order_goods);

    // 插入
    @Insert("insert into WAREHOUSE(WAREHOUSE_CODE,WAREHOUSE_NAME,PROVINCE,CITY,DISTRICT,WAREHOUSE_ADDRESS,WAREHOUSE_KEEPER,WAREHOUSE_TEL,CREATE_USER_ID,CREATE_TIME,UPDATE_TIME) " +
            "values (#{Warehouse_Code},#{Warehouse_Name},#{Province},#{City},#{District},#{Warehouse_Address},#{Warehouse_Keeper},#{Warehouse_Tel},#{Create_User_Id},now(),now())")
    public boolean savewarehouse(Warehouse warehouse);

    // 库存信息分页,查询所有符合条件的记录
    @SelectProvider(type = LogorderMappingDAO.LogOrderDaoProvider.class, method = "queryL")
    public List<Log_order> queryLogOrder(Log_order logOrder);

    // 库存信息分页，查询符合条件记录的数量
    @SelectProvider(type = LogorderMappingDAO.LogOrderDaoProvider.class, method = "queryLN")
    public int queryLogOrderN(Log_order logOrder);


    class LogOrderDaoProvider {
        public String AddOrderGoods(Order_goods order_goods) {
            String sql = "INSERT INTO ORDER_GOODS(ORDER_CODE,ORDER_GOODS_CODE,ODER_GOODS_AMOUNT) VALUES (#{Order_Code},#{Order_Goods_Code},#{Oder_Goods_Amount})";
            return sql;
        }

        public String queryL(Log_order logOrder) {
            String sql = "SELECT ORDER_CODE,(SELECT CLIENTELE_CODE FROM CLIENTELE WHERE CLIENTELE_ID = L.CLIENTELE_ID) AS CLIENTELE_ID" +
                    ",(SELECT WAREHOUSE_NAME FROM WAREHOUSE WHERE WAREHOUSE_ID = L.WAREHOUSE_ID) AS WAREHOUSE_ID" +
                    ",(SELECT VEHICLE_CODE FROM VEHICLE WHERE VEHICLE_Id = L.VEHICLE_ID) AS VEHICLE_ID,(SELECT USER_NAME FROM USERS WHERE USER_ID = L.USER_ID) AS USER_ID" +
                    ",ORDER_STATUS,CREATE_TIME,UPDATE_TIME" +
                    " FROM LOG_ORDER  L WHERE ORDER_CODE LIKE #{Order_Code} ";
            if (!"".equals(logOrder.getClientele_Id())) {
                sql += " AND CLIENTELE_ID = #{Clientele_Id}";
            }
            if (!"".equals(logOrder.getWarehouse_Id())) {
                sql += " AND WAREHOUSE_ID = #{Warehouse_Id}";
            }
            if (!"".equals(logOrder.getOrder_Status())) {
                sql += " AND ORDER_STATUS = #{Order_Status}";
            }
            sql += " ORDER BY CREATE_TIME DESC limit #{Order_Id},10;";
            return sql;
        }

        public String queryLN(Log_order logOrder) {
            String sql = "SELECT COUNT(*) FROM LOG_ORDER WHERE ORDER_CODE LIKE #{Order_Code} ";
            if (!"".equals(logOrder.getClientele_Id())) {
                sql += " AND CLIENTELE_ID = #{Clientele_Id}";
            }
            if (!"".equals(logOrder.getWarehouse_Id())) {
                sql += " AND WAREHOUSE_ID = #{Warehouse_Id}";
            }
            if (!"".equals(logOrder.getOrder_Status())) {
                sql += " AND ORDER_STATUS = #{Order_Status}";
            }
            return sql;
        }
    }
}
