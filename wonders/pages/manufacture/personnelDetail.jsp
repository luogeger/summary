<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>人员管理</h6>
            <h6 id="sub-name"></h6>
            <h6 id="sub-title" style="display: line-block;">详情</h6>
            <h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/manufacture/personnelManagement.jsp');">
            返回
            </h6>
        </div>
        <div class="row-fluid operation">
        	<div class="col-sm-12" style="padding: 5px 0 15px;">
				<button class="btn btn-default btn-sm" onclick="onEdit(this);"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
				<button class="btn btn-default btn-sm hidden" onclick="personnelEdit();"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
				<button class="btn btn-default btn-sm hidden" onclick="cancleEdit(this);"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
			</div>
        	<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
			<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">姓名</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="lName" maxlength="64" class="form-control input-add"  disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="verName" class="form-control selectpicker input-group-select" disabled></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">联系电话</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="lTel" maxlength="64" class="form-control input-add"  disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">分类</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="type" class="form-control selectpicker input-group-select" disabled></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">邮箱</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="email" id="lEmail" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">备注</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="pRemark" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        </div>
    </div>
    <div id="alertDialog"></div>
    <script>
    	$(function(){
			$(".selectpicker").selectpicker({
				dropuAuto : false
			});
			initSelects('manufacturer/list', "verName", {}, null ,"manufacturerId", "name");//厂商列表
    		initSelects('mdconfig/contact/type', "type", {}, null ,"key", "value");//人员分类
		});
    	var contactId = "${param.contactId}";
    	pDetail();
    	//人员详细信息
    	function pDetail(){
    		$.ajax({
    			"type":"GET",
    			"url":"contact/detail?contactId="+contactId,
    			"data":{},
    			"dataType":"json",
    			"success":function(resp){
    				if(resp.code == "200"){
    					var obj = resp.result.contact;
    					$("#lName").val(obj.name);              // 姓名
    					$("#verName").val(obj.manufacturerId);  // 厂商
    					$("#lTel").val(obj.phone);              // 电话
    					$("#type").val(obj.type);               // 分类
    					$("#lEmail").val(obj.email);            // 邮箱
    					$("#pRemark").val(obj.remark);          // 备注
    					$("#sub-name").html(obj.name);
    					$(".selectpicker").selectpicker("refresh");
    				}
    			},
    			"error":function(resp){
    				toastr.error("请求失败！");
    			}
    		});
    	}
    	//人员编辑
    	function personnelEdit(){
    		var lName = $("#lName").val();
    		var lTel = $("#lTel").val();
    		var lEmail = $("#lEmail").val();
    		var remark = $("#pRemark").val();
    		var type = $("#type").val();
    		var manufacturerId=$("#verName").val();
    		//姓名验证
    		if(lName == null || lName == ""){
				toastr.error("请输入姓名！");
				return false;
			}else{
				var name = lName;
			}
			//电话验证
			var reg = /^1[34578]\d{9}$/;
			var regTel = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/; 
			if(lTel == null || lTel == ""){
				toastr.error("电话不能为空！");
				return false;
			}else if(!reg.test(lTel) && !regTel.test(lTel)){
				toastr.error("电话输入的格式不正确！");
				return false;
			}else{
				var phone = lTel;
			}
			var regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
			if(lEmail == null || lEmail == ""){
				toastr.error("邮箱不能为空！");
			}else if(!regEmail.test(lEmail)){
				toastr.error("输入的邮箱的格式不正确！");
			}else{
				var email = lEmail;
			}
    		$.ajax({
    			"type":"POST",
    			"url":"contact/update",
    			"data":{
    					"contactId":contactId,
    					"name":name,
    					"type":type,
    					"phone":phone,
    					"email":email,
    					"remark":remark,
    					"manufacturerId":manufacturerId,
    				},
    			"dataType":"json",
    			"success":function(resp){
    				if(resp.code == "200"){
    					toastr.success("更新成功！");
    					loadMainPage('itam-content','pages/manufacture/personnelManagement.jsp');
    				}else{
    					toastr.error("输入的数值有误！");
    				}
    			},
    			"error":function(resp){
    				toastr.error("请求失败！");
    			}
    		});
    	}
    	//点击编辑按钮
    	function onEdit(obj){
    		$(obj).addClass("hidden");
			$(obj).siblings().removeClass("hidden");
			$(obj).parent().parent().addClass("operation-resource");
    		$(".operation input").attr("disabled",false);
    		$(".selectpicker").attr("disabled",false);
    		$("#lName").attr("disabled",true);
    		$("#sub-title").html("编辑");
    		$(".selectpicker").selectpicker("refresh");
    	}
    	//点击取消按钮
    	function cancleEdit(obj){
    		$(obj).addClass("hidden");
		    $(obj).prev().addClass("hidden");
			$(obj).parent().children("button:eq(0)").removeClass("hidden");
			$(obj).parent().parent().removeClass("operation-resource");
    		$(".operation input").attr("disabled",true);
    		$(".selectpicker").attr("disabled",true);
    		$("#sub-title").html("详情");
    		$(".selectpicker").selectpicker("refresh");
    	}
    </script>