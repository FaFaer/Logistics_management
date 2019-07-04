package model.mapping;

import model.Vehicle;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface VehicleMappingDAO {

    @Insert("insert into VEHICLE(VEHICLE_CODE,VEHICLE_STATUS,VEHICLE_WAREHOUSE,VEHICLE_KEEPER,USER_ID,CREATE_TIME,UPDATE_TIME)" +
            " VALUES(#{Vehicle_Code},#{Vehicle_Status},#{Vehicle_Warehouse},#{Vehicle_Keeper},#{User_Id},now(),now())")
    public boolean saveVehicle(Vehicle vehicle);

    //车辆信息分页,查询所有符合条件的记录
    @SelectProvider(type = VehicleMappingDAO.VehicleDaoProvider.class, method = "queryV")
    public List<Vehicle> queryvehicle(Vehicle vehicle);

    @Select("SELECT * FROM VEHICLE WHERE VEHICLE_WAREHOUSE = #{Vehicle_Warehouse}")
    public List<Vehicle> listVForOrder(Vehicle vehicle);

    @Delete("delete from VEHICLE WHERE VEHICLE_ID = #{Vehicle_Id}")
    public int deleteVehicle(Vehicle vehicle);

    // 查询全部车辆的记录
    @SelectProvider(type = VehicleMappingDAO.VehicleDaoProvider.class, method = "queryVN")
    public int queryvehiclenumber(Vehicle vehicle);

    @Select("select VEHICLE_CODE,VEHICLE_STATUS," +
            "(select WAREHOUSE_NAME FROM WAREHOUSE WHERE WAREHOUSE_ID = v.VEHICLE_WAREHOUSE) AS VEHICLE_WAREHOUSE," +
            "(select USER_NAME FROM USERS WHERE USER_ID = v.VEHICLE_KEEPER) AS VEHICLE_KEEPER " +
            "from VEHICLE v where v.VEHICLE_ID = #{Vehicle_Id}")
    public Vehicle queryveh(Vehicle vehicle);

    // 修改车辆状态
    @Update("UPDATE VEHICLE SET VEHICLE_STATUS = #{Vehicle_Code} , UPDATE_TIME = now() WHERE VEHICLE_ID = #{Vehicle_Id}")
    public int updatevhiclestatus(Vehicle vehicle);

    // 查询需要修改的车辆信息
    @Update("UPDATE VEHICLE SET VEHICLE_CODE=#{Vehicle_Code}")
    public int editvehicle(Vehicle vehicle);

    // 修改车辆信息
    @UpdateProvider(type = VehicleMappingDAO.VehicleDaoProvider.class, method = "editvehicle")
    public int editcehicle1(Vehicle vehicle);

    class VehicleDaoProvider {
        public String editvehicle(Vehicle vehicle){
            String sql = "update VEHICLE SET VEHICLE_CODE=#{Vehicle_Code} , UPDATE_TIME = now()";
            if (vehicle.getVehicle_Warehouse()=="null" || "null".equals(vehicle.getVehicle_Warehouse())){
            }else sql+=",VEHICLE_WAREHOUSE=#{Vehicle_Warehouse}";
            if(vehicle.getVehicle_Keeper()=="null" || "null".equals(vehicle.getVehicle_Keeper())){
            }else  sql+=",VEHICLE_KEEPER=#{Vehicle_Keeper}";
            sql+=" WHERE VEHICLE_ID=#{Vehicle_Id}";
            return sql;
        }

        public String queryV(Vehicle vehicle) {
            String sql = "select VEHICLE_ID,VEHICLE_CODE,VEHICLE_STATUS," +
                    "(select WAREHOUSE_NAME FROM WAREHOUSE WHERE WAREHOUSE_ID = v.VEHICLE_WAREHOUSE) AS VEHICLE_WAREHOUSE," +
                    "(select USER_NAME FROM USERS WHERE USER_ID = v.VEHICLE_KEEPER) AS VEHICLE_KEEPER, " +
                    "(select USER_NAME FROM USERS WHERE USER_ID = v.USER_ID) AS USER_ID," +
                    "CREATE_TIME,UPDATE_TIME from VEHICLE v ";
            if (vehicle.getVehicle_Code() == null) {
                vehicle.setVehicle_Code("");
            } else vehicle.setVehicle_Code(vehicle.getVehicle_Code().trim());
            vehicle.setVehicle_Code("%" + vehicle.getVehicle_Code() + "%");
            sql += " where VEHICLE_CODE like #{Vehicle_Code}";
            if (vehicle.getVehicle_Status() == " " || " ".equals(vehicle.getVehicle_Status())) {
            } else sql += "and VEHICLE_STATUS = #{Vehicle_Status}";
            if (vehicle.getVehicle_Warehouse() == " " || " ".equals(vehicle.getVehicle_Warehouse())) {
            } else {
                sql += "and VEHICLE_WAREHOUSE = #{Vehicle_Warehouse}";
            }
            sql += " limit #{Vehicle_Id},10;";
            return sql;
        }

        public String queryVN(Vehicle vehicle) {
            String sql = "select COUNT(*) from VEHICLE";
            if (vehicle.getVehicle_Code() == null) {
                vehicle.setVehicle_Code(" ");
            } else vehicle.setVehicle_Code(vehicle.getVehicle_Code().trim());
            vehicle.setVehicle_Code("%" + vehicle.getVehicle_Code() + "%");
            sql += " where VEHICLE_CODE like #{Vehicle_Code}";
            if (vehicle.getVehicle_Status() == " " || " ".equals(vehicle.getVehicle_Status())) {
            } else sql += "and VEHICLE_STATUS = #{Vehicle_Status}";
            if (vehicle.getVehicle_Warehouse() == " " || " ".equals(vehicle.getVehicle_Warehouse())) {
            } else {
                sql += "and VEHICLE_WAREHOUSE = #{Vehicle_Warehouse}";
            }
            return sql;
        }


    }
}

