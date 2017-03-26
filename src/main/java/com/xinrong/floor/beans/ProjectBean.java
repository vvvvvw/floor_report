package com.xinrong.floor.beans;

import com.xinrong.floor.entity.FloorClientEntity;
import com.xinrong.floor.entity.FloorDesignerEntity;
import com.xinrong.floor.entity.FloorEmployeeEntity;
import com.xinrong.floor.entity.FloorProjectEntity;
import com.xinrong.floor.repository.FloorClientRepository;

/**
 * Created by root on 17-3-21.
 */
public class ProjectBean {
    private FloorEmployeeEntity floorEmployeeEntity;
    private FloorProjectEntity floorProjectEntity;
    private FloorDesignerEntity floorDesignerEntity;
    private FloorClientEntity floorClientEntity;

    public FloorEmployeeEntity getFloorEmployeeEntity() {
        return floorEmployeeEntity;
    }

    public void setFloorEmployeeEntity(FloorEmployeeEntity floorEmployeeEntity) {
        this.floorEmployeeEntity = floorEmployeeEntity;
    }

    public FloorProjectEntity getFloorProjectEntity() {
        return floorProjectEntity;
    }

    public void setFloorProjectEntity(FloorProjectEntity floorProjectEntity) {
        this.floorProjectEntity = floorProjectEntity;
    }

    public FloorDesignerEntity getFloorDesignerEntity() {
        return floorDesignerEntity;
    }

    public void setFloorDesignerEntity(FloorDesignerEntity floorDesignerEntity) {
        this.floorDesignerEntity = floorDesignerEntity;
    }

    public FloorClientEntity getFloorClientEntity() {
        return floorClientEntity;
    }

    public void setFloorClientEntity(FloorClientEntity floorClientEntity) {
        this.floorClientEntity = floorClientEntity;
    }

    @Override
    public String toString() {
        return "ProjectBean{" +
                "floorEmployeeEntity=" + floorEmployeeEntity +
                ", floorProjectEntity=" + floorProjectEntity +
                ", floorDesignerEntity=" + floorDesignerEntity +
                ", floorClientEntity=" + floorClientEntity +
                '}';
    }
}
