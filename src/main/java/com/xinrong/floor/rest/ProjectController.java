package com.xinrong.floor.rest;


import com.wordnik.swagger.annotations.Api;
import com.xinrong.floor.beans.ProjectBean;
import com.xinrong.floor.entity.FloorClientEntity;
import com.xinrong.floor.entity.FloorDesignerEntity;
import com.xinrong.floor.entity.FloorEmployeeEntity;
import com.xinrong.floor.entity.FloorProjectEntity;
import com.xinrong.floor.enums.OperatorEnums;
import com.xinrong.floor.service.ClientService;
import com.xinrong.floor.service.DesignerService;
import com.xinrong.floor.service.EmployeeService;
import com.xinrong.floor.service.ProjectService;
import com.xinrong.floor.util.ConstantUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;


@Api(value = "project", description = "项目操作相关API")
@RestController
@RequestMapping(value = "/project")
public class ProjectController {

    private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);

    private static final String CURRENT_PAGE = "project_currentPage";

    private static final String PAGES = "project_pages";

    private static final String STARTNUM = "project_startnum";


    @Autowired
    ProjectService projectService;
    @Autowired
    EmployeeService employeeService;
    @Autowired
    DesignerService designerService;
    @Autowired
    ClientService clientService;


    /**
     * 查看
     *
     * @param pageNum
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/list/{pageNum}")
    public ModelAndView getEmployeeEntityList(@PathVariable("pageNum") Long pageNum, HttpSession httpSession) {
        FloorEmployeeEntity floorEmployeeEntity = (FloorEmployeeEntity) httpSession.getAttribute("user");
        ModelAndView mv = new ModelAndView("/project/project");
        Long count = projectService.getCountByEmployeeId(floorEmployeeEntity.getEmployeeId());
        long totalPage =  count/ConstantUtil.PAGE_SIZE+(count%ConstantUtil.PAGE_SIZE==0?0:1);
        if(totalPage < pageNum){
            pageNum = totalPage;
        }
        if(pageNum<=0){
            pageNum = 1l;
        }
        List<FloorProjectEntity> floorProjectEntityList = projectService.queryListByEmployeeId(floorEmployeeEntity.getEmployeeId(), ConstantUtil.PAGE_SIZE, (pageNum-1) * ConstantUtil.PAGE_SIZE);
        List<ProjectBean> projectBeanList = constructProjectBean(floorProjectEntityList);
        httpSession.setAttribute(CURRENT_PAGE, pageNum);
        mv.addObject(STARTNUM,(pageNum-1) * ConstantUtil.PAGE_SIZE+1);
        mv.addObject(PAGES,totalPage);
        mv.addObject("projectBeanList", projectBeanList);
        return mv;
    }

    private List<ProjectBean> constructProjectBean(List<FloorProjectEntity> floorProjectEntityList) {
        if (null == floorProjectEntityList || 0 == floorProjectEntityList.size()) {
            return null;
        }
        List<ProjectBean> projectBeanList = new ArrayList<ProjectBean>();
        for (FloorProjectEntity floorProjectEntity : floorProjectEntityList) {
            ProjectBean projectBean = new ProjectBean();
            projectBean.setFloorProjectEntity(floorProjectEntity);
            projectBean.setFloorEmployeeEntity(employeeService.selectByEmployeeId(floorProjectEntity.getEmployeeId()));
            projectBean.setFloorDesignerEntity(designerService.selectById(floorProjectEntity.getDesignerId()));
            projectBean.setFloorClientEntity(clientService.selectById(floorProjectEntity.getClientId()));
            projectBeanList.add(projectBean);
        }
        return projectBeanList;
    }

    /**
     *
     *
     * @param projectBean
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add(ProjectBean projectBean, HttpSession httpSession) {
        FloorEmployeeEntity floorEmployeeEntity = (FloorEmployeeEntity) httpSession.getAttribute("user");
        FloorProjectEntity floorProjectEntity = projectBean.getFloorProjectEntity();
        if(null == floorProjectEntity){
            floorProjectEntity = new FloorProjectEntity();
        }
        floorProjectEntity.setEmployeeId(floorEmployeeEntity.getEmployeeId());
        FloorClientEntity floorClientEntity = projectBean.getFloorClientEntity();
        FloorDesignerEntity floorDesignerEntity = projectBean.getFloorDesignerEntity();
        clientService.insert(floorClientEntity);
        floorProjectEntity.setClientId(floorClientEntity.getId());
        designerService.insert(floorDesignerEntity);
        floorProjectEntity.setDesignerId(floorDesignerEntity.getId());
        projectService.insert(floorProjectEntity);
        Long pageNum = (Long) httpSession.getAttribute(CURRENT_PAGE);
        if (null == pageNum) {
            pageNum = 1l;
        }
        ModelAndView mv = new ModelAndView("forward:/project/list/" + pageNum);
        mv.addObject("msg", OperatorEnums.ADD_SUCCESS.getMsg());
        return mv;
    }

    /**
     * 删除
     *
     * @param projectId
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/delete/{projectId}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable("projectId") Long projectId, HttpSession httpSession) {
        Long pageNum = (Long) httpSession.getAttribute(CURRENT_PAGE);
        if (null == pageNum) {
            pageNum = 1l;
        }
        ModelAndView mv = new ModelAndView("forward:/project/list/" + pageNum);
        FloorEmployeeEntity floorEmployeeEntity = (FloorEmployeeEntity) httpSession.getAttribute("user");
        FloorProjectEntity floorProjectEntity = projectService.queryById(projectId);
        if (null == floorProjectEntity || !floorEmployeeEntity.getEmployeeId().equals(floorProjectEntity.getEmployeeId())) {
            mv.addObject("msg", OperatorEnums.DELETE_FAIL.getMsg());
            return mv;
        }
        int res = projectService.deleteById(projectId);
        if(res>0) {
            mv.addObject("msg", OperatorEnums.DELETE_SUCCESS.getMsg());
            return mv;
        }else{
            mv.addObject("msg", OperatorEnums.DELETE_FAIL.getMsg());
            return mv;

        }
    }

    /**
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(ProjectBean projectBean, HttpSession httpSession) {
        FloorEmployeeEntity floorEmployeeEntity = (FloorEmployeeEntity) httpSession.getAttribute("user");
        Long pageNum = (Long) httpSession.getAttribute(CURRENT_PAGE);
        if (null == pageNum) {
            pageNum = 1l;
        }
        ModelAndView mv = new ModelAndView("forward:/project/list/" + pageNum);
        FloorProjectEntity projectEntityInSQL = null;
        FloorProjectEntity floorProjectEntity = projectBean.getFloorProjectEntity();
        FloorClientEntity floorClientEntity = projectBean.getFloorClientEntity();
        FloorDesignerEntity floorDesignerEntity = projectBean.getFloorDesignerEntity();
        if (null != floorProjectEntity) {
            Long projectId = floorProjectEntity.getId();
            if(null == projectId){
                mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
                return mv;
            }
        }
        projectEntityInSQL = projectService.queryById(floorProjectEntity.getId());
        if(!floorEmployeeEntity.getEmployeeId().equals(projectEntityInSQL.getEmployeeId())){
            mv.addObject("msg", OperatorEnums.UPDATE_FAIL.getMsg());
            return mv;
        }
        projectService.updateById(projectBean.getFloorProjectEntity());
        if (null != floorClientEntity) {
            floorClientEntity.setId(projectEntityInSQL.getClientId());
            clientService.updateById(floorClientEntity);
        }
        if (null != floorDesignerEntity) {
            floorDesignerEntity.setId(projectEntityInSQL.getDesignerId());
            designerService.updateById(floorDesignerEntity);
        }
        mv.addObject("msg", OperatorEnums.UPDATE_SUCCESS.getMsg());
        return mv;
    }
}
