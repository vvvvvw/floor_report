package com.xinrong.floor.repository;

import com.xinrong.floor.entity.FloorDesignerEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FloorDesignerRepository {

    public Integer insert(FloorDesignerEntity floorDesignerEntity);

    public Integer deleteById(@Param("id") Long id);

    public Integer updateByPrimaryKeySelective(FloorDesignerEntity floorDesignerEntity);

    public List<FloorDesignerEntity> queryAll();

    public List<FloorDesignerEntity> queryByPage(@Param("limits") Long limits, @Param("offset") Long offset);

    public FloorDesignerEntity queryById(@Param("id") Long id);

    public List<FloorDesignerEntity> queryListByName(@Param("name") String name);

    public List<FloorDesignerEntity> queryListByAddress(@Param("address") String address);

}