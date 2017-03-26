package com.xinrong.floor.service.Impl;

import com.xinrong.floor.entity.FloorAdminEntity;
import com.xinrong.floor.repository.FloorAdminRepository;
import com.xinrong.floor.service.AdminUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by jxxia on 2016/7/8 0008.
 */
@Service
public class AdminUserServiceImpl implements AdminUserService {

    @Autowired
    FloorAdminRepository floorAdminRepository;


    public int deleteByEmployeeId(long employeeId) {
        return floorAdminRepository.deleteByEmployeeId(employeeId);
    }

    public int insert(FloorAdminEntity floorAdminEntity) {
        return floorAdminRepository.insert(floorAdminEntity);
    }

    public FloorAdminEntity selectByEmployeeId(long employeeId) {
        return floorAdminRepository.queryByEmployeeId(employeeId);
    }

    public List<FloorAdminEntity> selectAll() {
        return floorAdminRepository.queryAll();
    }

    public List<FloorAdminEntity> selectByPages(long limits, long offset) {
        return floorAdminRepository.queryByPage(limits,offset);
    }

    public int updateByEmployeeId(FloorAdminEntity floorAdminEntity) {
        return floorAdminRepository.updateByPrimaryKeySelective(floorAdminEntity);
    }
}
