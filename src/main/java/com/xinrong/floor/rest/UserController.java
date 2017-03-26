package com.xinrong.floor.rest;

import com.wordnik.swagger.annotations.Api;
import com.xinrong.floor.entity.FloorEmployeeEntity;
import com.xinrong.floor.enums.OperatorEnums;
import com.xinrong.floor.service.EmployeeService;
import com.xinrong.floor.util.ConstantUtil;
import com.xinrong.floor.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * Created by root on 17-3-24.
 */

@Api(value = "user", description = "用户个人操作相关API")
@RestController
@RequestMapping(value = "/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    EmployeeService employeeService;

    /**
     * 展示
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/show")
    public ModelAndView show(HttpSession httpSession) {
        FloorEmployeeEntity floorEmployeeEntity = (FloorEmployeeEntity) httpSession.getAttribute("user");
        ModelAndView mv = new ModelAndView("/user/user");
        mv.addObject("floorEmployeeEntity", floorEmployeeEntity);
        return mv;
    }

    /**
     * 更新
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/updateInformation", method = RequestMethod.POST)
    public ModelAndView update(FloorEmployeeEntity floorEmployeeEntity, HttpSession httpSession) {
        FloorEmployeeEntity floorEmployeeEntityInSession = (FloorEmployeeEntity) httpSession.getAttribute("user");
        ModelAndView mv = new ModelAndView("forward:/user/show");
        if(null == floorEmployeeEntity || null == floorEmployeeEntity.getEmployeeId() || null == employeeService.selectByEmployeeId(floorEmployeeEntity.getEmployeeId())||!floorEmployeeEntity.getEmployeeId().equals(floorEmployeeEntityInSession.getEmployeeId())){
            mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
        }else{
            if(!StringUtils.isEmpty(floorEmployeeEntity.getPassword())){
                floorEmployeeEntity.setPassword(StringUtil.getEncryptPassword(ConstantUtil.saltBefore+floorEmployeeEntity.getPassword()+ ConstantUtil.saltAfter));
            }
            int res = employeeService.updateByEmployeeId(floorEmployeeEntity);
            if(res>0){
                mv.addObject("msg", OperatorEnums.UPDATE_SUCCESS.getMsg());
            }else{
                mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
            }
            floorEmployeeEntity = employeeService.selectByEmployeeId(floorEmployeeEntity.getEmployeeId());
            httpSession.setAttribute("user",floorEmployeeEntity);
        }
        return mv;
    }
}
