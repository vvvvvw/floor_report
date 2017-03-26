package com.xinrong.floor.service.Impl;

import com.xinrong.floor.entity.FloorEmployeeEntity;
import com.xinrong.floor.repository.FloorEmployeeRepository;
import com.xinrong.floor.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by jxxia on 2016/7/8 0008.
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    FloorEmployeeRepository floorEmployeeRepository;

    public int deleteById(long id) {
        return floorEmployeeRepository.deleteById(id);
    }

    public int deleteByEmployeeId(long employeeId) {
        return floorEmployeeRepository.deleteByEmployeeId(employeeId);
    }

    public int insert(FloorEmployeeEntity floorEmployeeEntity) {
        return floorEmployeeRepository.insert(floorEmployeeEntity);
    }

    public Long getTotalCount() {
        return floorEmployeeRepository.queryTotalCount();
    }

    public FloorEmployeeEntity selectByEmployeeId(long employeeId) {
        return floorEmployeeRepository.queryByEmployeeId(employeeId);
    }

    public List<FloorEmployeeEntity> selectAll() {
        return floorEmployeeRepository.queryAll();
    }

    public List<FloorEmployeeEntity> selectByPages(long limits, long offset) {
        return floorEmployeeRepository.queryByPage(limits,offset);
    }


    public int updateByEmployeeId(FloorEmployeeEntity floorEmployeeEntity) {
        return floorEmployeeRepository.updateByEmployeeId(floorEmployeeEntity);
    }
}
