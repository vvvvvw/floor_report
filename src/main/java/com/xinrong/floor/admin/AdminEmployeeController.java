package com.xinrong.floor.admin;


import com.xinrong.floor.entity.FloorEmployeeEntity;
import com.xinrong.floor.enums.OperatorEnums;
import com.xinrong.floor.service.EmployeeService;
import com.xinrong.floor.util.ConstantUtil;
import com.wordnik.swagger.annotations.Api;
import com.xinrong.floor.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Api(value = "admin employee", description = "雇员操作相关API")
@RestController
@RequestMapping(value = "/admin/employee")
public class AdminEmployeeController {

    private static final Logger logger = LoggerFactory.getLogger(AdminEmployeeController.class);

    private static final String CURRENT_PAGE ="admin_employee_currentPage";

    private static final String PAGES = "admin_employee_pages";

    @Autowired
    EmployeeService employeeService;

    /**
     * 查看
     * @param pageNum
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/list/{pageNum}")
    public ModelAndView getEmployeeEntityList(@PathVariable("pageNum") Long pageNum,HttpSession httpSession) {
        ModelAndView mv = new ModelAndView("/admin/employee/employee");
        Long count = employeeService.getTotalCount();
        long totalPage =  count/ConstantUtil.PAGE_SIZE+(count%ConstantUtil.PAGE_SIZE==0?0:1);
        if(totalPage < pageNum){
            pageNum = totalPage;
        }
        if(pageNum<=0){
            pageNum = 1l;
        }
        List<FloorEmployeeEntity> floorEmployeeEntityList = employeeService.selectByPages(ConstantUtil.PAGE_SIZE, (pageNum-1)*ConstantUtil.PAGE_SIZE);
        httpSession.setAttribute(CURRENT_PAGE,pageNum);
        mv.addObject(PAGES, totalPage);
        mv.addObject("floorEmployeeEntityList", floorEmployeeEntityList);
        return mv;
    }
    /**
     *
     * @param
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add(FloorEmployeeEntity floorEmployeeEntity,HttpSession httpSession) {
        Long pageNum = (Long)httpSession.getAttribute(CURRENT_PAGE);
        if(null==pageNum){
            pageNum=1l;
        }
        ModelAndView mv = new ModelAndView("forward:/admin/employee/list/"+pageNum);
        if(null == floorEmployeeEntity.getEmployeeId() || null != employeeService.selectByEmployeeId(floorEmployeeEntity.getEmployeeId())){
            mv.addObject("msg", OperatorEnums.ADD_FAIL.getMsg());
        }else {
            employeeService.insert(floorEmployeeEntity);
            mv.addObject("msg", OperatorEnums.ADD_SUCCESS.getMsg());
        }
        return mv;
    }

    /**
     * 删除
     * @param employeeId
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/delete/{employeeId}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable("employeeId") Long employeeId,HttpSession httpSession) {
        employeeService.deleteByEmployeeId(employeeId);
        Long pageNum = (Long)httpSession.getAttribute(CURRENT_PAGE);
        if(null==pageNum){
            pageNum=1l;
        }
        ModelAndView mv = new ModelAndView("forward:/admin/employee/list/"+pageNum);
        mv.addObject("msg", OperatorEnums.DELETE_SUCCESS.getMsg());
        return mv;
    }

    /**
     * 删除
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(FloorEmployeeEntity floorEmployeeEntity,HttpSession httpSession) {
        Long pageNum = (Long)httpSession.getAttribute(CURRENT_PAGE);
        if(null==pageNum){
            pageNum=1l;
        }
        ModelAndView mv = new ModelAndView("forward:/admin/employee/list/"+pageNum);
        if(null == floorEmployeeEntity || null == floorEmployeeEntity.getEmployeeId() || null == employeeService.selectByEmployeeId(floorEmployeeEntity.getEmployeeId())){
            mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
        }else {
            employeeService.updateByEmployeeId(floorEmployeeEntity);
            mv.addObject("msg", OperatorEnums.UPDATE_SUCCESS.getMsg());
        }
        return mv;
    }

    @RequestMapping(value = "/resetPassword/{employeeId}", method = RequestMethod.GET)
    public ModelAndView resetPassword(@PathVariable("employeeId") Long employeeId,HttpSession httpSession) {
        Long pageNum = (Long)httpSession.getAttribute(CURRENT_PAGE);
        if(null==pageNum){
            pageNum=1l;
        }
        ModelAndView mv = new ModelAndView("forward:/admin/employee/list/"+pageNum);
        if(null == employeeId || null == employeeService.selectByEmployeeId(employeeId)){
            mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
        }else {
            FloorEmployeeEntity floorEmployeeEntity = new FloorEmployeeEntity();
            floorEmployeeEntity.setEmployeeId(employeeId);
            String initPasswordAfterEnc = StringUtil.getEncryptPassword(ConstantUtil.saltBefore+ConstantUtil.initPassword+ ConstantUtil.saltAfter);
            floorEmployeeEntity.setPassword(initPasswordAfterEnc);
            employeeService.updateByEmployeeId(floorEmployeeEntity);
            mv.addObject("msg", OperatorEnums.UPDATE_SUCCESS.getMsg());
        }
        return mv;
    }
}
