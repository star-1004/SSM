<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 23377
  Date: 2021/11/19
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <%--    不已斜线开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
    以/开始的相对路径，找资源，以服务器的路径为标准；需要加上项目名
    http://localhost:3302/crud
    --%>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--    <link href="static/bootstrap-3.4.1-dist/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jQuert-min-3.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>
<%--员工修改--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabelUpdate">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@guigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@guigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
<%--                            部门提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<%--搭建显示页面--%>
<div class="container">
    <%--    标题--%>
    <div class="row"></div>
    <div class="col-md-12">
        <h1>SSM-CRUD</h1>
    </div>
    <%--    按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_button">新增</button>
            <button class="btn btn-danger" id="emp_delete_All_button">删除</button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-lg-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>


                </tbody>
            </table>
        </div>
    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--        分页信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--    分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function(){
        //去首页
        to_Page(1);
    });

    function to_Page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"get",
            success:function (msg){
                //console.log(msg)
                //    1.解析并显示员工数据
                build_emps_table(msg);
                //     2.解析并显示分页信息
                build_page_Info(msg);
                //    解析显示分页条数据
                bulid_page_nav(msg);
            }
        });
    }
    function build_emps_table(msg){
        //清空table表格
        $("#emps_table tbody").empty();
        var emps=msg.extend.pageInfo.list;
        $.each(emps,function (index,item){
            //alert(item.empName);
            var checkBoxTd=$("<td><input type='checkbox' class='check_item' /></td>");
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var empGenderTd=$("<td></td>").append(item.gender);
            var empEmailTD=$("<td></td>").append(item.email);
            var empDeptName=$("<td></td>").append(item.department.deptName);
            var editBt=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").
            addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工的id
            editBt.attr("edit-id",item.empId);
            var deleteBt=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").
            addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性，来表示当前员工的id
            deleteBt.attr("delete-id",item.empId);
            var btnTd=$("<td></td>").append(editBt).append(" ").append(deleteBt);
            //append方法执行完成后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(empGenderTd).append(empEmailTD).append(empDeptName).
            append(btnTd).appendTo("#emps_table tbody");

        });
    }
    //解析显示分页信息
    function build_page_Info(msg){
        $("#page_info_area").empty();
        $("#page_info_area").append(" 当前"+msg.extend.pageInfo.pageNum+"页,总共"+msg.extend.pageInfo.pages+"页," +
            "总共"+msg.extend.pageInfo.total+"条记录");
        totalRecord=msg.extend.pageInfo.total;
        currentPage=msg.extend.pageInfo.pageNum;
    }
    //解析显示分页条,点击分页要能去下一页等等。
    function bulid_page_nav(msg){
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if (msg.extend.pageInfo.hasPreviousPage==false)
        {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加点击事件
            firstPageLi.click(function (){
                to_Page(1);
            });
            prePageLi.click(function (){
                to_Page(msg.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if (msg.extend.pageInfo.hasNextPage==false)
        {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function (){
                to_Page(msg.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function (){
                to_Page(msg.extend.pageInfo.pages);
            });
        }


        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul添加页码提示
        $.each(msg.extend.pageInfo.navigatepageNums,function (index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if (msg.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
                numLi.click(function (){
                    to_Page(item);
                });
            ul.append(numLi);
        });
        //添加下一页和尾页的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav里面
        var nav=$("<nav></nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }

    function reset_form (ele){
        //表单完整重置
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //清空表单内容
        $(ele).find(".help-block").text("");

    }
    //新增模态框，点击新增按钮弹出模态框
    $("#emp_add_model_button").click(function (){
        //清除表单数据（表单完整重置（表单的数据，表单的样式)
        reset_form("#empAddModel form");
        // $("#empAddModel form")[0].reset();
        //发送Ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });
    //查出所有的部门信息
    function getDepts (ele){
        //清空下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result){
               // console.log(msg);
                //显示部门信息在下拉列表中
                // $("#dept_add_select").append("")
                $.each(result.extend.depts,function (){
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //前端校验,校验表单数据
    function validate_add_form(){
        //1.拿到校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        }
        //校验邮箱
        var email=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }
    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status)
        {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
    $("#empName_add_input").change(function (){
        //发送Ajax请求，校验员工数据用户名是否可用
        var empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result){
                if (result.code==100)
                {

                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else
                {

                    show_validate_msg("empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

//    保存按钮,点击保存，保存员工
    $("#emp_save_btn").click(function (){
        //点击按钮后，表单数据提交服务器保存
        //先对要提交的数据进行校验
        // if(!validate_add_form())
        // {
        //     //alert("用户名");
        //     return false;
        // }
        //判断之前的ajax用户名校验是否成功，如果成功。往下走
         if ($(this).attr("ajax-va")=="error") {
             if(!validate_add_form())
             {
                 //alert("用户名");
                 return false;
             }
             //alert("用户名已存在");
             show_validate_msg("#empName_add_input","error","用户名重复");
             return false;
        }
        //发送ajax保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function (result){
                 //alert(result.msg);
                if (result.code==100){
                    $("#empAddModel").modal('hide');//    1.关闭模态框
                    to_Page(totalRecord);//蒋总记录数当作页码,返回最后一页
                }else {
                    //显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的
                    if (undefined!=result.extend.errorFields.email)
                    {
                        //显示邮箱信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined!=result.extend.errorFields.empName){
                        //显示员工的错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
                    }
                }
            }
        });
    });
    //按钮创建之前就绑定了事件click，所以绑定不上
    //可以在创建按钮时绑定 2.绑定单击事件。live()
    //jquery新版本没有live使用on进行替代
    $(document).on("click",".edit_btn",function (){
        // alert("hello");
        //查出员工信息，显示员工信息

        //1.查出部门信息，并显示部门列表
        getDepts("#empUpdateModel select ");
        getEmp($(this).attr("edit-id"));
        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModel").modal({
            backdrop:"static"
        });
    });

    //得到员工数据
    function  getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result){
                //console.log(result);
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModel input[name=gender]").val([empData.gender]);
                $("#empUpdateModel select").val([empData.dId]);
            }
        });
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function (){
       //验证邮箱是否合法
        var email=$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_update_input","success","");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("")
        }
        //发送ajax请求到保存更新的员工数据
        /**
         * 我们要能支持直接发送Put之类的请求还要封装请求体中的数据
         * 配置上FormContentFilter
         * 他的作用将请求体中的数据解析包装成一个map
         * request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
         */
        $.ajax({
           url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (result){
               //alert(result.msg);
                //关闭模态框
                $("#empUpdateModel").modal('hide');
                //回到本页面
                to_Page(currentPage);
            }
        });
    });


    //员工点击删除
    $(document).on("click",".delete_btn",function (){
        //1.弹出是否删除对话框
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        var empId=$(this).attr("delete-id");
        if (confirm("确认删除["+empName+"]吗?")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result){
                    alert(result.msg);
                    to_Page(currentPage);
                }

            })
        }
        //alert($(this).parents("tr").find("td:eq(1)").text());
    });
    //完成全选与全不选功能
    $("#check_all").click(function (){
        //attr获取checked时undefined;
        //我们这些dom原生的属性：推荐用prop,attr用来获取自定义的值
        //prop修改和读取dom原生属性的值
       var checkEd=$(this).prop("checked");
       $(".check_item").prop("checked",checkEd);
    });

    //为每一个单选添加点击选中事件
    $(document).on("click",".check_item",function (){
       //判断当前选中的元素是否为5个
       var flag=$(".check_item:checked").length==$(".check_item").length;
       //alert(flag);
       $("#check_all").prop("checked",flag);
    });
//点击全部删除就批量删除
    $("#emp_delete_All_button").click(function (){
        var empNames="";
        var del_idstr="";
       $.each($(".check_item:checked"),function (){
         empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
         del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
       });
       if ($(".check_item:checked").length==0)
       {
           alert("您没有选中任何数据");
       }
       else {
           //去除empNames多余的逗号
           empNames = empNames.substring(0,empNames.length-1);
           del_idstr=del_idstr.substring(0,del_idstr.length-1);
           if (confirm("确认删除【"+empNames+"】吗？")){
               //发送ajax请求删除
               $.ajax({
                   url:"${APP_PATH}/emp/"+del_idstr,
                   type:"DELETE",
                   success:function (result){
                       alert(result.msg);
                       //回到当前页面
                       to_Page(currentPage);
                   }
               });
           }
       }

    });

</script>
</body>
</html>
