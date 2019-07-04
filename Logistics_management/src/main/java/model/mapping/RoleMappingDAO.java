package model.mapping;

import model.Clientele;
import model.Role;
import model.Users;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RoleMappingDAO {

    @Insert("INSERT INTO ROLE(ROLE_CODE,ROLE_NAME,ROLE_USER_PERMISSION,ROLE_RESOURCE_PERMISSION,ROLE_DESCRIBE,ROLE_STATUS,CREATE_USER_ID,CREATE_TIME,UPDATE_TIME)" +
            " VALUES(#{Role_Code},#{Role_Name},#{Role_User_Permission},#{Role_Resource_Permission},#{Role_Describe},#{Role_Status},#{Create_User_Id},now(),now())")
    public boolean saveRole(Role role);

    @Delete("DELETE FROM ROLE WHERE ROLE_CODE = #{Role_Code}")
    public int deleteRole(Role role);

    @Select("select * from ROLE WHERE ROLE_STATUS = 'A'")
    public List<Role> roleList();

    //管理员信息分页,查询所有符合条件的记录
    @SelectProvider(type = RoleDaoProvider.class, method = "queryR")
    public List<Role> queryRole(Role role);

    //管理员信息分页，查询符合条件记录的数量
    @SelectProvider(type = RoleDaoProvider.class, method = "queryRN")
    public int queryRenumbers(Role role);

    // 修改状态：启用或停用
    @Update("UPDATE ROLE SET ROLE_STATUS = #{Role_Status},UPDATE_TIME = now() WHERE ROLE_CODE = #{Role_Code}")
    public int updateStatus(Role role);

    @Select("select count(*) from USERS WHERE USER_PERMISSION = #{Role_Code}")
    public int queryUser(Role role);

    class RoleDaoProvider {
        public String queryR(Role role) {
            String sql = "SELECT R.ROLE_Id, R.ROLE_Code,R.ROLE_NAME,R.ROLE_DESCRIBE,R.ROLE_STATUS,R.CREATE_TIME,R.UPDATE_TIME FROM ROLE R WHERE R.ROLE_NAME LIKE #{Role_Name}";
            if (!"N".equals(role.getRole_Status())) {
                sql += " AND R.ROLE_STATUS = #{Role_Status}";
            }
            if (!"".equals(role.getCreate_Time())) {
                sql += " AND R.CREATE_TIME BETWEEN #{Create_Time} ";
                if ("".equals(role.getUpdate_Time())) {
                    sql += " AND now()";
                } else sql += " AND #{Update_Time}";
            }
            sql += "limit #{Role_Id},10;";
            return sql;
        }

        public String queryRN(Role role) {
            String sql = "SELECT COUNT(*) FROM ROLE R WHERE R.ROLE_NAME LIKE #{Role_Name}";
            if (!"N".equals(role.getRole_Status())) {
                sql += " AND R.ROLE_STATUS = #{Role_Status}";
            }
            if (!"".equals(role.getCreate_Time())) {
                sql += " AND R.CREATE_TIME BETWEEN #{Create_Time} ";
                if ("".equals(role.getUpdate_Time())) {
                    sql += " AND now()";
                } else sql += " AND #{Update_Time}";
            }
            return sql;
        }
    }
}
