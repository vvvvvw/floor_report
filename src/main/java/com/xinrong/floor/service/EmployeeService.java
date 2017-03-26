package com.xinrong.floor.service;

import com.xinrong.floor.entity.FloorEmployeeEntity;

import java.util.List;

public interface EmployeeService {

    int deleteById(long id);

    int deleteByEmployeeId(long employeeId);

    int insert(FloorEmployeeEntity floorEmployeeEntity);

    public Long getTotalCount();

    FloorEmployeeEntity selectByEmployeeId(long employeeId);

    List<FloorEmployeeEntity> selectAll();

    List<FloorEmployeeEntity> selectByPages(long limits, long offset);

    int updateByEmployeeId(FloorEmployeeEntity floorEmployeeEntity);
}