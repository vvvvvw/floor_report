package com.xinrong.floor.repository;

import com.xinrong.floor.entity.FloorEmployeeEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FloorEmployeeRepository {

    public Integer insert(FloorEmployeeEntity floorEmployeeEntity);

    public Integer deleteById(@Param("id") Long id);

    public Integer deleteByEmployeeId(@Param("employeeId") Long employeeId);

    public Integer updateByEmployeeId(FloorEmployeeEntity floorEmployeeEntity);

    public Long queryTotalCount();

    public List<FloorEmployeeEntity> queryAll();

    public List<FloorEmployeeEntity> queryByPage(@Param("limits") Long limits, @Param("offset") Long offset);

    public FloorEmployeeEntity queryByEmployeeId(@Param("employeeId") Long employeeId);

    public FloorEmployeeEntity queryByEmployeeIdAndPassword(@Param("employeeId") Long employeeId, @Param("password") String password);

    public List<FloorEmployeeEntity> queryListByName(@Param("name") String name);
}