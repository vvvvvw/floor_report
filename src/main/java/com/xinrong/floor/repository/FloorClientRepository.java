package com.xinrong.floor.repository;

import com.xinrong.floor.entity.FloorClientEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FloorClientRepository {

    public Integer insert(FloorClientEntity floorClientEntity);

    public Integer deleteById(@Param("id") Long id);

    public Integer updateByPrimaryKeySelective(FloorClientEntity floorClientEntity);

    public List<FloorClientEntity> queryAll();

    public List<FloorClientEntity> queryByPage(@Param("limits") Long limits, @Param("offset") Long offset);

    public FloorClientEntity queryById(@Param("id") Long id);

    public FloorClientEntity queryByNameAndPassword(@Param("name") String name, @Param("password") String password);

    public List<FloorClientEntity> queryListByName(@Param("name") String name);

    public List<FloorClientEntity> queryListByAddress(@Param("address") String address);
}
