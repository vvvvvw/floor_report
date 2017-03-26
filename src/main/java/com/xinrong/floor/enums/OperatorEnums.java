package com.xinrong.floor.enums;

/**
 * Created by root on 17-3-23.
 */
public enum OperatorEnums {
    UPDATE_SUCCESS(1, "更新成功"),

    UPDATE_FAIL(2, "更新失败"),
    ADD_SUCCESS(3, "添加成功"),
    ADD_FAIL(4, "添加失败"),
    DELETE_SUCCESS(5, "删除成功"),
    DELETE_FAIL(6, "删除失败");

    private int code;

    private String msg;

    OperatorEnums(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
