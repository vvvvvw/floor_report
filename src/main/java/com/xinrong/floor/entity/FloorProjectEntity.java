package com.xinrong.floor.entity;

import java.io.Serializable;

/**
 * Created by root on 17-3-19.
 */
public class FloorProjectEntity implements Serializable {

    private Long id;

    private Long employeeId;

    private Long clientId;

    private Long designerId;

    private Integer floorHeating;

    private String progress;

    private String floorType;

    private String communicationProgress;

    private Long visitTime;

    private Long createTime;

    private Long updateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Long employeeId) {
        this.employeeId = employeeId;
    }

    public Long getClientId() {
        return clientId;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public Long getDesignerId() {
        return designerId;
    }

    public void setDesignerId(Long designerId) {
        this.designerId = designerId;
    }

    public Integer getFloorHeating() {
        return floorHeating;
    }

    public void setFloorHeating(Integer floorHeating) {
        this.floorHeating = floorHeating;
    }

    public String getProgress() {
        return progress;
    }

    public void setProgress(String progress) {
        this.progress = progress;
    }

    public String getFloorType() {
        return floorType;
    }

    public void setFloorType(String floorType) {
        this.floorType = floorType;
    }

    public String getCommunicationProgress() {
        return communicationProgress;
    }

    public void setCommunicationProgress(String communicationProgress) {
        this.communicationProgress = communicationProgress;
    }

    public Long getVisitTime() {
        return visitTime;
    }

    public void setVisitTime(Long visitTime) {
        this.visitTime = visitTime;
    }

    public Long getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Long createTime) {
        this.createTime = createTime;
    }

    public Long getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Long updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "FloorProjectEntity{" +
                "id=" + id +
                ", employeeId=" + employeeId +
                ", clientId=" + clientId +
                ", designerId=" + designerId +
                ", floorHeating=" + floorHeating +
                ", progress='" + progress + '\'' +
                ", floorType='" + floorType + '\'' +
                ", communicationProgress=" + communicationProgress +
                ", visitTime=" + visitTime +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
