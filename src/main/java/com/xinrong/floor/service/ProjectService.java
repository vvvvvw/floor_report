package com.xinrong.floor.service;

import com.xinrong.floor.entity.FloorProjectEntity;

import java.util.List;

/**
 * Created by root on 17-3-21.
 */
public interface ProjectService {

    int insert(FloorProjectEntity floorProjectEntity);

    int deleteById(long id);

    int updateById(FloorProjectEntity floorProjectEntity);

    public Long getTotalCount();

    public Long getCountByEmployeeId(Long employeeId);

    List<FloorProjectEntity> selectAll();

    List<FloorProjectEntity> selectByPages(long limits, long offset);

    FloorProjectEntity queryById(long id);

    List<FloorProjectEntity> queryListByEmployeeId(long employeeId,long limits, long offset);

    List<FloorProjectEntity> queryListByDesignerId(long designerId,long limits, long offset);

    List<FloorProjectEntity> queryListBeforeTime(long beforeTime,long limits, long offset);
}
