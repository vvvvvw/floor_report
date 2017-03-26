package com.xinrong.floor.service;

import com.xinrong.floor.entity.FloorClientEntity;

import java.util.List;


public interface ClientService {

    int deleteById(long id);

    int insert(FloorClientEntity floorClientEntity);

    List<FloorClientEntity> selectAll();

    List<FloorClientEntity> selectByPages(long limits, long offset);

    FloorClientEntity selectById(long id);

    int updateById(FloorClientEntity floorClientEntity);
}