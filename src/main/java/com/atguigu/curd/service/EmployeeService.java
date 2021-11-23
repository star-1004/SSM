package com.atguigu.curd.service;

import com.atguigu.curd.bean.EmployeeExample;
import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工返回list数组
     * @return
     */
    public List<Employee> getAll()
    {
        return employeeMapper.selectAllWithDept();
    }

//    public void saveEmp(Employee employee) {
//        employeeMapper.insert(employee);
//    }
    public void saveEmp2(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public Employee getEmployee(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
        int delete = employeeMapper.deleteByExample(example);
        System.out.println("删除的行数:"+delete);
    }

    //public void deleteBatch2(List<Integer> ids)
//    {
//        employeeMapper.deleteBatch(ids);
//    }


    //校验员工用户名是否可用,返回true代表可用 否则代表数据库有记录不可用
    public boolean checkUser(String empName) {

        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count=employeeMapper.countByExample(employeeExample);
        return count==0;
    }
}
