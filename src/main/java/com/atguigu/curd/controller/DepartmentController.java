package com.atguigu.curd.controller;


import com.atguigu.curd.bean.Department;
import com.atguigu.curd.bean.Msg;
import com.atguigu.curd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

//处理和部门有关的信息
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    //返回所有的部门信息
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts()
    {
//        查出的所有部门
        List<Department> departmentList=departmentService.getDepts();
        return Msg.success().add("depts",departmentList);
    }



}
