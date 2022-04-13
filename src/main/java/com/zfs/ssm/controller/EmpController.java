package com.zfs.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zfs.ssm.pojo.Emp;
import com.zfs.ssm.pojo.Msg;
import com.zfs.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author 张福生
 * @version 1.0
 */
@ResponseBody

@Controller
public class EmpController {
    @Autowired
    EmpService empService;
    //以json的方式进行数据返回，将数据封装到msg对象中
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn,5);
        //startPage紧跟的查询就是一个分页查询了
        List<Emp> emps = empService.getAll();
        // 用PageInfo来包装最后查询的结果
        //在pageInfo中封账了详细的分页数据
        //传入连续显示的页数5
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }
    /*@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){

        PageHelper.startPage(pn,5);
        //startPage紧跟的查询就是一个分页查询了
        List<Emp> emps = empService.getAll();
        // 用PageInfo来包装最后查询的结果
        //在pageInfo中封账了详细的分页数据
        //传入连续显示的页数5
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }*/
}
