package com.atguigu.curd.test;

import com.atguigu.curd.bean.Department;
import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.dao.DepartmentMapper;
import com.atguigu.curd.dao.EmployeeMapper;
import org.apache.ibatis.jdbc.SQL;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层
 * 使用Spring的测试单元
 * 导入springTest模块
 * 使用ContextConfiguration指定spring配置文件的位置
 * 直接autowire
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;


    @Test
    public void testInsertDept()
    {

//        System.out.println(departmentMapper);
        //1.创建SpringIOC容器
//        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("mapper.txt");
        //2.从容器中获得mapper
        // 1.插入几个部门
        Department department = new Department(null,"开发部");
        departmentMapper.insert(department);
        departmentMapper.insert(new Department(null,"测试部"));
        //2生成员工数据，测试员工插入


    }
    @Autowired
    EmployeeMapper employeeMapper;
    @Test
    public void testInsertEmp()
    {
        Employee employee=new Employee();
        employee.setEmpId(null);
        employee.setEmpName("李宁");
        employee.setGender("男");
        employee.setdId(1);
        employee.setEmail("lining@qq.com");
        //employeeMapper.insert(employee);
    }
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testBatchInsert()
    {
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 10; i++) {
            String substring = UUID.randomUUID().toString().substring(0, 5);
            //employeeMapper.insert(new Employee(null,substring,"男",substring+"@atguigu.com",1));
            
        }
    }


}
