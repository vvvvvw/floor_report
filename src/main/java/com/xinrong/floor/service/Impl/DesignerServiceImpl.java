package com.xinrong.floor.service.Impl;

import com.xinrong.floor.entity.FloorDesignerEntity;
import com.xinrong.floor.repository.FloorDesignerRepository;
import com.xinrong.floor.service.DesignerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by root on 17-3-20.
 */
@Service
public class DesignerServiceImpl implements DesignerService{

    @Autowired
    FloorDesignerRepository floorDesignerRepository;

    public int deleteById(long id) {
        return floorDesignerRepository.deleteById(id);
    }

    public int insert(FloorDesignerEntity floorDesignerEntity) {
        return floorDesignerRepository.insert(floorDesignerEntity);
    }

    public List<FloorDesignerEntity> selectAll() {
        return floorDesignerRepository.queryAll();
    }

    public List<FloorDesignerEntity> selectByPages(long limits, long offset) {
        return floorDesignerRepository.queryByPage(limits,offset);
    }

    public FloorDesignerEntity selectById(long id) {
        return floorDesignerRepository.queryById(id);
    }

    public int updateById(FloorDesignerEntity floorDesignerEntity) {
        return floorDesignerRepository.updateByPrimaryKeySelective(floorDesignerEntity);
    }
}
