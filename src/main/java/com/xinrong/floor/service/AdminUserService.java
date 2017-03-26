package com.xinrong.floor.service;

import com.xinrong.floor.entity.FloorAdminEntity;

import java.util.List;

public interface AdminUserService {

    int deleteByEmployeeId(long employeeId);

    int insert(FloorAdminEntity floorAdminEntity);

    FloorAdminEntity selectByEmployeeId(long employeeId);

    List<FloorAdminEntity> selectAll();

    List<FloorAdminEntity> selectByPages(long limits, long offset);

    int updateByEmployeeId(FloorAdminEntity floorAdminEntity);
}