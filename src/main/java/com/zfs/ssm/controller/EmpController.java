package com.zfs.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zfs.ssm.pojo.Emp;
import com.zfs.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author 张福生
 * @version 1.0
 */
@Controller
public class EmpController {
    @Autowired
    EmpService empService;
    @RequestMapping("/emps")
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
    }
}
