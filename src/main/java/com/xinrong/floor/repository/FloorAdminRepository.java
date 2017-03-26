package com.xinrong.floor.repository;

import com.xinrong.floor.entity.FloorAdminEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FloorAdminRepository {

    public Integer insert(FloorAdminEntity floorAdminEntity);

    public Integer deleteByEmployeeId(@Param("employeeId") Long employeeId);

    public Integer updateByPrimaryKeySelective(FloorAdminEntity floorAdminEntity);

    public List<FloorAdminEntity> queryAll();

    public List<FloorAdminEntity> queryByPage(@Param("limits") Long limits, @Param("offset") Long offset);

    public FloorAdminEntity queryByEmployeeId(@Param("employeeId") Long employeeId);

    public FloorAdminEntity queryByEmployeeIdAndPassword(@Param("employeeId") Long employeeId, @Param("password") String password);

    public List<FloorAdminEntity> queryListByName(@Param("name") String name);

}