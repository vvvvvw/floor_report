package com.xinrong.floor.service.Impl;

import com.xinrong.floor.entity.FloorClientEntity;
import com.xinrong.floor.repository.FloorClientRepository;
import com.xinrong.floor.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by root on 17-3-20.
 */
@Service
public class ClientServiceImpl implements ClientService {
    @Autowired
    FloorClientRepository floorClientRepository;

    public int deleteById(long id) {
        return floorClientRepository.deleteById(id);
    }

    public int insert(FloorClientEntity floorClientEntity) {
        return floorClientRepository.insert(floorClientEntity);
    }

    public List<FloorClientEntity> selectAll() {
        return floorClientRepository.queryAll();
    }

    public List<FloorClientEntity> selectByPages(long limits, long offset) {
        return floorClientRepository.queryByPage(limits,offset);
    }

    public FloorClientEntity selectById(long id) {
        return floorClientRepository.queryById(id);
    }

    public int updateById(FloorClientEntity floorClientEntity) {
        return floorClientRepository.updateByPrimaryKeySelective(floorClientEntity);
    }
}
