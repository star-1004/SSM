package com.atguigu.curd.test;

import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.controller.EmployeeController;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的准确性
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:application.xml","classpath:springMVC.xml"})
@AutoConfigureMockMvc
public class


    MVCTest {
    //传入SpringMVC的IOC

    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取处理结果
    @Autowired
    MockMvc mockMvc;
    @Before
    public void initMockMvc()
    {
        MockMvcBuilders.webAppContextSetup(context).build();
    }
    //编写测试分页的方法
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).
                andReturn();
        //请求成功后，请求域中会有pageInfo，我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:"+pageInfo.getPageNum());
        System.out.println("总页码:"+pageInfo.getPages());
        System.out.println("总记录数:"+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码:");
        for (int i: pageInfo.getNavigatepageNums()
             ) {
            System.out.println("::"+i);
        }
        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee emp:list
             ) {
            System.out.println("ID:"+emp.getEmpId()+"==>"+emp.getEmpName());//打印的到的员工id和姓名
        }
        
    }
}
