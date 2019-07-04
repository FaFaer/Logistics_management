package model.mapping;

import model.China;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface SiteMappingDAO {

    @Select("SELECT COUNT(*) FROM LOG_ORDER WHERE ORDER_STATUS = '0'")
    public int searchorderforIndex();

    @Select("select * from china where CHINA_PID=#{pid}")
    public List<China> SitP(@Param("pid") String pid);
    // 会返回该月份和该表的注册数量
    @SelectProvider(type = SiteDaoProvider.class, method = "queryUser")
    public int queryUser(String table,String date);

    class SiteDaoProvider {
        public String queryUser(String table,  String date){
            String sql ="SELECT COUNT(*) FROM "+table+" WHERE DATE_FORMAT(CREATE_TIME,'%Y%c') = "+date;
            return sql;
        }
    }
}
