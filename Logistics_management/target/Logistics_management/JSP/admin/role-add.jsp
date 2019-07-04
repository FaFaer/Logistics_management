<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>深蓝物流管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/Pages/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
	<style>
		/* Switch 1 Specific Styles Start */

		.box_1{
			background: #eee;
		}

		input[type="checkbox"].switch_1{
			font-size: 14px;
			-webkit-appearance: none;
			-moz-appearance: none;
			appearance: none;
			width: 3.5em;
			height: 1.5em;
			background: #ddd;
			border-radius: 3em;
			position: relative;
			cursor: pointer;
			outline: none;
			-webkit-transition: all .2s ease-in-out;
			transition: all .2s ease-in-out;
		}

		input[type="checkbox"].switch_1:checked{
			background: #0ebeff;
		}

		input[type="checkbox"].switch_1:after{
			position: absolute;
			content: "";
			width: 1.5em;
			height: 1.5em;
			border-radius: 50%;
			background: #fff;
			-webkit-box-shadow: 0 0 .25em rgba(0,0,0,.3);
			box-shadow: 0 0 .25em rgba(0,0,0,.3);
			-webkit-transform: scale(.7);
			transform: scale(.7);
			left: 0;
			-webkit-transition: all .2s ease-in-out;
			transition: all .2s ease-in-out;
		}

		input[type="checkbox"].switch_1:checked:after{
			left: calc(100% - 1.5em);
		}

		/* Switch 1 Specific Style End */

	</style>
</head>
	<body>
		<div class="weadmin-body">
			<form method="post" class="layui-form-pane" action="${pageContext.request.contextPath}/addrole">
				<div class="layui-form-mid layui-word-aux">
					用户角色不能删除，修改，请认真填写
				</div>
				<div class="layui-form-item">
					<label for="name" class="layui-form-label">
                        <span class="we-red">*</span>角色名
                    </label>
					<div class="layui-input-inline">
						<input type="text" id="name" name="Role_Name" required="" lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
					<label class="layui-form-label">
                        拥有权限
                    </label>
					<table class="layui-table">
						<tbody>
						<div class="layui-form-item">
							<tr>
								<td>
									用户管理
								</td>
								<td>
									<div class="layui-input-block">
									<input type="checkbox" class="switch_1" name="Role_User_Permission" value="0">管理角色列表
									&ensp;
									<input type="checkbox" class="switch_1" name="Role_User_Permission" value="1">管理用户列表
									&ensp;
									</div>
								</td>
							</tr></div>
							<tr>
								<td>
									资源管理
								</td>
								<td>
									<div class="layui-input-block">
											<input type="checkbox" class="switch_1" name="Role_Resource_Permission" value="0">管理客户列表
										&ensp;
											<input type="checkbox" class="switch_1" name="Role_Resource_Permission" value="1">管理车辆列表
										&ensp;
											<input type="checkbox" class="switch_1" name="Role_Resource_Permission" value="2">管理商品列表
										&ensp;
											<input type="checkbox" class="switch_1" name="Role_Resource_Permission" value="3">管理仓库列表
										</div>
								</td>
							</tr>
						</tbody>
					</table>
				<div class="layui-form-item layui-form-text">
					<label for="desc" class="layui-form-label">
                        描述
                    </label>
					<div class="layui-input-block">
						<textarea placeholder="请输入内容" id="desc" required name="Role_Describe" class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="layui-form-item" style="margin-left: 170px">
					<input type="submit" value="提交" class="layui-btn"/>
					<input type="reset" class="layui-btn layui-btn-danger" value="重置"/>
				</div>
			</form>
		</div>
		<script src="${pageContext.request.contextPath}/Pages/lib/layui/layui.js" charset="utf-8"></script>
		<script type="text/javascript">

		</script>
	</body>

</html>