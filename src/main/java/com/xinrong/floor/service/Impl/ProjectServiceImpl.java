package com.xinrong.floor.service.Impl;

import com.xinrong.floor.entity.FloorProjectEntity;
import com.xinrong.floor.repository.FloorProjectRepository;
import com.xinrong.floor.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by root on 17-3-21.
 */
@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    FloorProjectRepository floorProjectRepository;

    public int insert(FloorProjectEntity floorProjectEntity) {
        return floorProjectRepository.insert(floorProjectEntity);
    }

    public int deleteById(long id) {
        return floorProjectRepository.deleteById(id);
    }

    public int updateById(FloorProjectEntity floorProjectEntity) {
        return floorProjectRepository.updateByPrimaryKeySelective(floorProjectEntity);
    }

    public Long getTotalCount() {
        return floorProjectRepository.queryTotalCount();
    }

    public Long getCountByEmployeeId(Long employeeId) {
        return floorProjectRepository.queryCountByEmployeeId(employeeId);
    }

    public List<FloorProjectEntity> selectAll() {
        return floorProjectRepository.queryAll();
    }

    public List<FloorProjectEntity> selectByPages(long limits, long offset) {
        return floorProjectRepository.queryByPage(limits,offset);
    }

    public FloorProjectEntity queryById(long id) {
        return floorProjectRepository.queryById(id);
    }

    public List<FloorProjectEntity> queryListByEmployeeId(long employeeId, long limits, long offset) {
        return floorProjectRepository.queryListByEmployeeId(employeeId,limits,offset);
    }

    public List<FloorProjectEntity> queryListByDesignerId(long designerId, long limits, long offset) {
        return floorProjectRepository.queryListByDesignerId(designerId,limits,offset);
    }

    public List<FloorProjectEntity> queryListBeforeTime(long beforeTime, long limits, long offset) {
        return floorProjectRepository.queryListBeforeTime(beforeTime, limits, offset);
    }
}
