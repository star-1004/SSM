package com.atguigu.curd.controller;

import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.Msg;
import com.atguigu.curd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工crud,支持JSR303校验
 * 导入Hibernate-Validator
 */
@Controller
public class EmployeeController {

    /**
     * 查询员工数据（分页查询）
     * @return
     */

    @Autowired
    EmployeeService employeeService;
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model)
    {
        PageHelper.startPage(pn,5);
        List<Employee> employees=employeeService.getAll();
        PageInfo<Employee> pageInfo=new PageInfo(employees,5);
        return Msg.success().add("pageInfo",pageInfo);
    }
//    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model)
//    {
//        //这不是一个分页查询
//        //引入分页插件
//        //在查询之前，只需要调用pageHelper.startPage()
//        PageHelper.startPage(pn,5);
//        //startPage紧跟的查询就是分页查询
//        List<Employee> employees =employeeService.getAll();
//        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行
//        //封装了详细的分页信息，包括查询出来的信息
//        PageInfo<Employee> pageInfo = new PageInfo<Employee>(employees,5);//连续显示的5页数
//        model.addAttribute("pageInfo",pageInfo);
//
//        return "list";
//    }


    //    保存提交信息,员工Rest风格,后端检验JSR303
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败应该返回失败，在模态框中显示失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors
                 ) {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.failure().add("errorFields",map);
        }else {
            employeeService.saveEmp2(employee);
            return Msg.success();
        }
    }
//校验用户名是否可用数据库
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam("empName") String empName)
    {
        //先判断用户名是否是合法表达式；
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        boolean matche = empName.matches(regx);
        if (!matche){
            return Msg.failure().add("va_msg","用户名必须是6-16位英文和数字的组合或者2-5位中文");
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
       if (b)
       {
           return Msg.success();
       }else {
           return Msg.failure().add("va_msg","用户名不可用");
       }
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmployee(id);
        return Msg.success().add("emp",employee);
    }

    //员工更新方法
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp2(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 单个批量二合1的方法
     * 批量删除1-2-3
     * 单个删除：1
     * @param
     * @return
     */
    //员工删除方法
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids)
    {
        if (ids.contains("-"))
        {
            List<Integer> del_ids=new ArrayList<>();
            String[] strings = ids.split("-");

            for (String id:strings
                 ) {
                Integer i = Integer.parseInt(id);
                del_ids.add(i);
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id= Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

}
