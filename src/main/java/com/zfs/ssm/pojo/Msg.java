package com.zfs.ssm.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 张福生
 * @version 1.0
 */
public class Msg {
    //设置响应状态码100失败，200成功
    private Integer code;
    //响应状态类
    private String name;
    //存储查询到的数据，封装到map集合中
    private Map<String,Object> extend = new HashMap<>();
    //响应成功函数
    public static Msg success(){
        Msg result = new Msg();
        result.setCode(200);
        result.setName("成功");
        return result;
    }
    //响应失败函数
    public static Msg file(){
        Msg result = new Msg();
        result.setCode(100);
        result.setName("失败");
        return result;
    }
    //map赋值函数
    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;
    }
    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
