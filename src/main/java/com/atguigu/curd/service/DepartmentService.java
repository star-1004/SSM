package com.atguigu.curd.service;

import com.atguigu.curd.bean.Department;
import com.atguigu.curd.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        List<Department> departments = departmentMapper.selectAll();
        return departments;
    }

    
}
