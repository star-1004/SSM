package com.atguigu.curd.dao;

import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.EmployeeExample;

import java.util.List;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);
    Employee selectByPrimaryKey(Integer empId);
    Employee selectByPrimaryKeyWithDept(Integer empId);

    List<Employee> selectAll();
    List<Employee> selectAllWithDept();

    int updateByPrimaryKey(Employee record);
    int updateByPrimaryKeySelective(Employee record);

    //void deleteByExample(com.atguigu.crud.bean.EmployeeExample example);

    int deleteByExample(EmployeeExample example);
    int deleteBatch(List<Integer> ids);

    long countByExample(EmployeeExample employeeExample);

    int insertSelective(Employee employee);
}