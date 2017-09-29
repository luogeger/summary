<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>人员管理</h6>
            <h6 id="sub-title" style="display: line-block;">添加</h6>
            <h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/manufacture/personnelManagement.jsp');">
            返回
            </h6>
        </div>
        <div class="row-fluid operation operation-resource">
        	<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
			<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">姓名</label>
				<div class="col-md-9 col-sm-8 col">
					<input id="pName" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="change-vendorName" class="form-control selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">联系电话</label>
				<div class="col-md-9 col-sm-8 col">
					<input id="pTel" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">分类</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="type-change" class="form-control input-sm selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">邮箱</label>
				<div class="col-md-9 col-sm-8 col">
					<input id="pEmail" maxlength="64" type="email" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">备注</label>
				<div class="col-md-9 col-sm-8 col">
					<input id="pRemark" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-sm-12 operation-btn">
				<button type="button"  data-value="submit" onclick="personnelAdd();" class="btn btn-info btn-sm" >确定</button>
				<button type="button"  data-value="reset" onclick="loadMainPage('itam-content','pages/manufacture/personnelManagement.jsp');" class="btn btn-primary btn-sm">取消</button>
			</div>
        </div>
    </div>
    <div id="alertDialog"></div>
    <script>
    	$(function(){
    		$(".selectpicker").selectpicker({
				dropuAuto : false
			});
			initSelects("manufacturer/list", "change-vendorName",{},null, "manufacturerId", "name");
    		initSelects("mdconfig/contact/type", "type-change",{},null, "key", "value");
    	});
		//人员添加
		function personnelAdd(){
			var type = $("#type-change").val();
			var manufacturerId = $("#change-vendorName").val();
			var pName = $("#pName").val();
			var pTel = $("#pTel").val();
			var pEmail = $("#pEmail").val();
			var remark = $("#pRemark").val();
			//姓名验证
    		if(pName == null || pName == ""){
				toastr.error("请输入姓名！");
				return false;
			}else{
				var name =pName;
			}
			//电话验证
			var reg = /^1[34578]\d{9}$/;
			var regTel = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/; 
			if(pTel == null || pTel == ""){
				toastr.error("电话不能为空！");
				return false;
			}else if(!reg.test(pTel) && !regTel.test(pTel)){
				toastr.error("电话输入的格式不正确！");
				return false;
			}else{
				var phone = pTel;
			}
			//邮箱验证
			var regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/ ;
			if(pEmail == null || pEmail == ""){
				toastr.error("邮箱不能为空！");
				return false;
			}else if(!regEmail.test(pEmail)){
				toastr.error("输入的邮箱的格式不正确！");
				return false;
			}else{
				var email = pEmail;
			}
			$.ajax({
				"type":"POST",
				"url":"contact/create",
				"data":{
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
						toastr.success("添加成功！");
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
    </script>