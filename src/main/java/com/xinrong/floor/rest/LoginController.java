package com.xinrong.floor.rest;

import com.xinrong.floor.entity.FloorEmployeeEntity;
import com.xinrong.floor.enums.LoginEnums;
import com.xinrong.floor.service.EmployeeService;
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


@Api(value = "login", description = "投票操作相关API")
@RestController
@RequestMapping(value = "/login")
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    EmployeeService employeeService;


    /**
     * 登录
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam(value = "employeeId") Long employeeId, @RequestParam(value = "password") String password, HttpServletRequest request, HttpServletResponse response) {
        FloorEmployeeEntity floorEmployeeEntity = employeeService.selectByEmployeeId(employeeId);
        if (null == floorEmployeeEntity || !StringUtil.getEncryptPassword(ConstantUtil.saltBefore+password+ ConstantUtil.saltAfter).equals(floorEmployeeEntity.getPassword())) {
            request.setAttribute("errorMsg", "用户名或密码错误");
            return new ModelAndView(LoginEnums.LOGIN_HOME.getMsg());
        }
        request.getSession().setAttribute("user", floorEmployeeEntity);
//        String redirect = "redirect:" + LoginEnums.REDIRECT_HOME.getMsg();
//        if(redirect.contains("login")){
//            redirect = "redirect:/vote/topic/1/page/1";
//        }
        String redirect = "redirect:/project/list/1";
        return new ModelAndView(redirect);
    }

    /**
     * 登录
     *
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login() {
        return new ModelAndView(LoginEnums.LOGIN_HOME.getMsg());
    }

    /**
     * 退出登录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/logout")
    public ModelAndView logout(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView(LoginEnums.LOGIN_HOME.getMsg());
        request.getSession().setAttribute("user", null);
        return modelAndView;
    }

}