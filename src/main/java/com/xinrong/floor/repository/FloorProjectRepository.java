package com.xinrong.floor.repository;

import com.xinrong.floor.entity.FloorProjectEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FloorProjectRepository {

    public Integer insert(FloorProjectEntity floorProjectEntity);

    public Integer deleteById(@Param("id") Long id);

    public Integer updateByPrimaryKeySelective(FloorProjectEntity floorProjectEntity);

    public Long queryTotalCount();

    public Long queryCountByEmployeeId(@Param("employeeId") Long employeeId);

    public List<FloorProjectEntity> queryAll();

    public List<FloorProjectEntity> queryByPage(@Param("limits") Long limits, @Param("offset") Long offset);

    public FloorProjectEntity queryById(@Param("id") Long id);

    public List<FloorProjectEntity> queryListByEmployeeId(@Param("employeeId") Long employeeId,@Param("limits") Long limits, @Param("offset") Long offset);

    public List<FloorProjectEntity> queryListByDesignerId(@Param("designerId") Long designerId,@Param("limits") Long limits, @Param("offset") Long offset);

    public List<FloorProjectEntity> queryListBeforeTime(@Param("beforeTime") Long beforeTime,@Param("limits") Long limits, @Param("offset") Long offset);

}