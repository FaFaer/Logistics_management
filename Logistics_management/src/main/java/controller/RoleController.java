package controller;

import model.Role;
import model.Users;
import model.mapping.RoleMappingDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class RoleController {
    @Autowired
    private RoleMappingDAO roleMappingDAO;
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");

    /**
     * 删除角色
     *
     * @return
     */
    @RequestMapping(value = "/deleteRole", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteRole(Role role) {
        JSONObject jsonObject = new JSONObject();
        int j = roleMappingDAO.deleteRole(role);
        jsonObject.put("j", j);
        return jsonObject.toString();
    }

    /**
     * 添加角色
     *
     * @param role
     * @param request
     * @return
     */
    @RequestMapping(value = "/addrole", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String addrole(Role role, HttpServletRequest request) {
        role.setRole_Status("A");
        if (role.getRole_User_Permission() != null) {
            String[] userPermi = role.getRole_User_Permission().split(",");
            char[] userpremission = {'0', '0', '0', '0'};
            for (int i = 0; i < userPermi.length; i++) {
                userpremission[Integer.parseInt(userPermi[i])] = '1';
                role.setRole_User_Permission(String.valueOf(userpremission));
            }
        } else role.setRole_User_Permission("0000");
        if (role.getRole_Resource_Permission() != null) {
            String[] resourcepre = role.getRole_Resource_Permission().split(",");
            char[] resourcepremission = {'0', '0', '0', '0'};
            for (int i = 0; i < resourcepre.length; i++) {
                resourcepremission[Integer.parseInt(resourcepre[i])] = '1';
            }
            role.setRole_Resource_Permission(String.valueOf(resourcepremission));
        }

        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        role.setRole_Code(timer.format(new Date()) + s);
        Users users = (Users) request.getSession().getAttribute("user");
        role.setCreate_User_Id(String.valueOf(users.getUser_Id()));
        boolean b = roleMappingDAO.saveRole(role);
        if (b) {
            return SUCCESS;
        }
        return ERROR;
    }


    /**
     * 查询所有角色
     *
     * @return
     */
    @RequestMapping(value = "/selectRole", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String roleListController() {
        List<Role> roleList = roleMappingDAO.roleList();
        JSONArray jsonArray = JSONArray.fromObject(roleList);
        return jsonArray.toString();
    }

    /**
     * 查角色列表
     *
     * @param role
     * @return
     */
    @RequestMapping(value = "/listR", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listR(Role role) {
        role.setRole_Name("%" + role.getRole_Name().trim() + "%");
        int j = role.getRole_Id();
        role.setRole_Id(j * 10);
        List<Role> clienteles = roleMappingDAO.queryRole(role);
        JSONArray jsonArray = JSONArray.fromObject(clienteles);
        return jsonArray.toString();
    }


    /**
     * 分页查数量
     *
     * @param role
     * @return
     */
    @RequestMapping(value = "/listRnumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String querynumber(Role role) {
        role.setRole_Name("%" + role.getRole_Name().trim() + "%");
        int i = roleMappingDAO.queryRenumbers(role);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 修改状态
     *
     * @param role
     * @return
     */
    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateStatus(Role role) {
        int i = 0;
        JSONObject jsonObject = new JSONObject();
        // 如果是停用用户角色，需要先查询用户表确定该角色下没有启用的用户
        if ("X".equals(role.getRole_Status())) {
            i = roleMappingDAO.queryUser(role);

        }
        jsonObject.put("i", i);
        int j = 0;
        if (i == 0) {
            j = roleMappingDAO.updateStatus(role);
        }
        jsonObject.put("j", j);
        return jsonObject.toString();
    }

}
