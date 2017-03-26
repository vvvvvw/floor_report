package com.xinrong.floor.admin;


import com.xinrong.floor.entity.FloorAdminEntity;
import com.xinrong.floor.enums.LoginEnums;
import com.xinrong.floor.service.AdminUserService;
import com.xinrong.floor.util.ConstantUtil;
import com.xinrong.floor.util.StringUtil;
import com.wordnik.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Api(value = "admin login", description = "管理员操作相关API")
@RestController
@RequestMapping(value = "/admin/login")
public class AdminLoginController {

    private static final Logger logger = LoggerFactory.getLogger(AdminLoginController.class);

    @Autowired
    AdminUserService adminUserService;


    /**
     * 登录
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam(value="employeeId") Long employeeId, @RequestParam(value="password") String password, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        FloorAdminEntity floorAdminEntity = adminUserService.selectByEmployeeId(employeeId);
        if(null == floorAdminEntity || !StringUtil.getEncryptPassword(ConstantUtil.saltBefore+password+ ConstantUtil.saltAfter).equals(floorAdminEntity.getPassword())){
            request.setAttribute("errorMsg","用户名或密码错误");
            return new ModelAndView(LoginEnums.ADMIN_LOGIN_HOME.getMsg());
        }
        request.getSession().setAttribute("adminUser",floorAdminEntity);
        return new ModelAndView("admin/index");
    }

    /**
     * 登录
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login() {
        return new ModelAndView(LoginEnums.ADMIN_LOGIN_HOME.getMsg());
    }

    /**
     * 退出登录
     * @param request
     * @return
     */
    @RequestMapping(value = "/logout")
    public ModelAndView logout(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView(LoginEnums.ADMIN_LOGIN_HOME.getMsg());
        request.getSession().setAttribute("adminUser",null);
        return modelAndView;
    }

}