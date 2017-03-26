package com.xinrong.floor.service;

import com.xinrong.floor.entity.FloorDesignerEntity;

import java.util.List;

/**
 * Created by root on 17-3-20.
 */
public interface DesignerService {

    int deleteById(long id);

    int insert(FloorDesignerEntity floorDesignerEntity);

    List<FloorDesignerEntity> selectAll();

    List<FloorDesignerEntity> selectByPages(long limits, long offset);

    FloorDesignerEntity selectById(long id);

    int updateById(FloorDesignerEntity floorDesignerEntity);
}
