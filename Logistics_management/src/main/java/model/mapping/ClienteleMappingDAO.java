package model.mapping;

import model.Clientele;
import model.Warehouse;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface ClienteleMappingDAO {

    @Insert("insert into CLIENTELE(CLIENTELE_CODE,CLIENTELE_NAME,PROVINCE,CITY,DISTRICT,CLIENTELE_ADDRESS,CLIENTELE_WAREHOUSE,CLIENTELE_PRINCIPAL,CLIENTELE_TEL,CREATE_TIME,UPDATE_TIME,CLIENTELE_STATUS,USER_ID) " +
            "values (#{Clientele_Code},#{Clientele_Name},#{Province},#{City},#{District},#{Clientele_Address},#{Clientele_Warehouse},#{Clientele_Principal},#{Clientele_Tel},now(),now(),#{Clientele_Status},#{User_Id})")
    public boolean savecliente(Clientele clientele);

    //客户信息分页,查询所有符合条件的记录
    @SelectProvider(type = ClienteleDaoProvider.class, method = "queryC")
    public List<Clientele> queryclientele(Clientele clientele);

    //查询仓库
    @Select("select * from WAREHOUSE")
    public List<Warehouse> querywharehouse();

    @Select("SELECT * FROM CLIENTELE")
    public List<Clientele> searchCForOrder();

    //客户信息分页，查询符合条件记录的数量
    @SelectProvider(type = ClienteleDaoProvider.class, method = "queryCN")
    public int queryclientelenumber(Clientele clientele);

    @SelectProvider(type = ClienteleDaoProvider.class, method = "queryupdate")
    public Clientele querycli(Clientele clientele);

    // 删除用户前查订单是否有该用户
    @Select("SELECT COUNT(*) FROM LOG_ORDER WHERE CLIENTELE_ID = (SELECT CLIENTELE_ID FROM CLIENTELE WHERE CLIENTELE_CODE = #{Clientele_Code})")
    public int queryForDelclientele(Clientele clientele);

    // 删除用户
    @Delete("delete from CLIENTELE where CLIENTELE_CODE =#{Clientele_Code}")
    public int delete(Clientele clientele);

    @UpdateProvider(type = ClienteleDaoProvider.class, method = "updatec")
    public int editclientele(Clientele clientele);

    class ClienteleDaoProvider {
        public String queryupdate(Clientele clientele) {
            String sql = "select CLIENTELE_CODE,CLIENTELE_NAME,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID=C.PROVINCE) AS PROVINCE," +
                    "(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID=C.CITY) AS CITY,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID=C.DISTRICT) AS DISTRICT, ";
            sql += "CLIENTELE_ADDRESS,(SELECT WAREHOUSE_NAME FROM WAREHOUSE WHERE WAREHOUSE_ID=C.CLIENTELE_WAREHOUSE) AS CLIENTELE_WAREHOUSE,CLIENTELE_PRINCIPAL,CLIENTELE_TEL,CREATE_TIME,UPDATE_TIME from CLIENTELE C";
            sql += " where CLIENTELE_CODE="+clientele.getClientele_Code();
            return sql;
        }

        public String updatec(Clientele clientele) {
            String sql = "update CLIENTELE set CLIENTELE_NAME=#{Clientele_Name},UPDATE_TIME = now()";
            if (clientele.getProvince() == "null" || "null".equals(clientele.getProvince())) {
            } else sql += ",PROVINCE =#{Province}";
            if (clientele.getCity() == "null" || "null".equals(clientele.getCity())) {
            } else sql += ",CITY =#{City}";
            if (clientele.getDistrict() == "null" || "null".equals(clientele.getDistrict())) {
            } else sql += ",DISTRICT =#{District}";
            if (clientele.getClientele_Warehouse() == "null" || "null".equals(clientele.getClientele_Warehouse())) {
            } else sql += ",CLIENTELE_WAREHOUSE =#{Clientele_Warehouse}";
            sql += ",CLIENTELE_ADDRESS =#{Clientele_Address},CLIENTELE_PRINCIPAL = #{Clientele_Principal},CLIENTELE_TEL=#{Clientele_Tel} where CLIENTELE_CODE=#{Clientele_Code}";
            return sql;
        }


        public String queryC(Clientele clientele) {
            String sql = "select CLIENTELE_ID, CLIENTELE_CODE,CLIENTELE_NAME,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID=C.PROVINCE) AS PROVINCE,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID=C.CITY) AS CITY,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID=C.DISTRICT) AS DISTRICT, " +
                    "CLIENTELE_ADDRESS,(SELECT WAREHOUSE_NAME FROM WAREHOUSE WHERE WAREHOUSE_ID=C.CLIENTELE_WAREHOUSE) AS CLIENTELE_WAREHOUSE,CLIENTELE_PRINCIPAL,CLIENTELE_TEL,CREATE_TIME,UPDATE_TIME from CLIENTELE C ";
            clientele.setClientele_Name("%" + clientele.getClientele_Name() + "%");
            clientele.setClientele_Address("%" + clientele.getClientele_Address() + "%");
            sql += "where CLIENTELE_NAME like #{Clientele_Name} and CLIENTELE_ADDRESS like #{Clientele_Address}";

            if (clientele.getProvince() == "" || "".equals(clientele.getProvince())) {
            } else {
                sql += "and PROVINCE=#{Province}";
            }
            if (clientele.getCity() == "" || "".equals(clientele.getCity())) {
            } else {
                sql += "and CITY=#{City}";
            }
            if (clientele.getDistrict() == "" || "".equals(clientele.getDistrict())) {
            } else {
                sql += "and District=#{District} ";
            }
            sql += "limit #{Clientele_Id},10;";
            return sql;
        }

        public String queryCN(Clientele clientele) {
            String sql = "select COUNT(*) from CLIENTELE C ";
            clientele.setClientele_Name("%" + clientele.getClientele_Name() + "%");
            clientele.setClientele_Address("%" + clientele.getClientele_Address() + "%");
            sql += "where CLIENTELE_NAME like #{Clientele_Name} and CLIENTELE_ADDRESS like #{Clientele_Address}";

            if (clientele.getProvince() == "" || "".equals(clientele.getProvince())) {
            } else {
                sql += " and PROVINCE=#{Province}";
            }
            if (clientele.getCity() == "" || "".equals(clientele.getCity())) {
            } else {
                sql += " and CITY=#{City}";
            }
            if (clientele.getDistrict() == "" || "".equals(clientele.getDistrict())) {
            } else {
                sql += " and District=#{District} ";
            }
            return sql;
        }
    }
}
