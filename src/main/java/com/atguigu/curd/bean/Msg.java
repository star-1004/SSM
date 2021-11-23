package com.atguigu.curd.bean;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

//通用的返回类，返回json数据
public class Msg {
    private int code; //状态码
    private String msg;//提示信息
//    用户返回给浏览器的数据
    private Map<String,Object> extend=new HashMap<>();

    public static Msg success()
    {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理成功");
        return msg;
    }
    public static Msg failure()
    {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理失败");
        return msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public Msg add(String pageInfo, Object value) {
        this.getExtend().put(pageInfo,value);
        return this;
    }
}
