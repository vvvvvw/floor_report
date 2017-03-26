package com.xinrong.floor.admin;

import com.wordnik.swagger.annotations.Api;
import com.xinrong.floor.entity.FloorAdminEntity;
import com.xinrong.floor.enums.OperatorEnums;
import com.xinrong.floor.service.AdminUserService;
import com.xinrong.floor.util.ConstantUtil;
import com.xinrong.floor.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * Created by root on 17-3-24.
 */

@Api(value = "admin user", description = "管理员个人操作相关API")
@RestController
@RequestMapping(value = "/admin/user")
public class AdminUserController {

        private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);

        @Autowired
        AdminUserService adminUserService;

        /**
         * 展示
         * @param httpSession
         * @return
         */
        @RequestMapping(value = "/show")
        public ModelAndView show(HttpSession httpSession) {
            FloorAdminEntity floorAdminEntity = (FloorAdminEntity) httpSession.getAttribute("adminUser");
            ModelAndView mv = new ModelAndView("/admin/user/user");
            mv.addObject("floorAdminEntity", floorAdminEntity);
            return mv;
        }


        /**
         * 更新
         * @param httpSession
         * @return
         */
        @RequestMapping(value = "/updateInformation", method = RequestMethod.POST)
        public ModelAndView update(FloorAdminEntity floorAdminEntity, HttpSession httpSession) {
            ModelAndView mv = new ModelAndView("forward:/admin/user/show");
            if(null==floorAdminEntity.getEmployeeId()||null == adminUserService.selectByEmployeeId(floorAdminEntity.getEmployeeId())){
                mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
            }else{
                if(!StringUtils.isEmpty(floorAdminEntity.getPassword())){
                    floorAdminEntity.setPassword(StringUtil.getEncryptPassword(ConstantUtil.saltBefore+floorAdminEntity.getPassword()+ ConstantUtil.saltAfter));
                }
                int res = adminUserService.updateByEmployeeId(floorAdminEntity);
                if(res>0){
                    mv.addObject("msg", OperatorEnums.UPDATE_SUCCESS.getMsg());
                }else{
                    mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
                }
                floorAdminEntity = adminUserService.selectByEmployeeId(floorAdminEntity.getEmployeeId());
                httpSession.setAttribute("adminUser",floorAdminEntity);
            }
            return mv;
        }
    }


