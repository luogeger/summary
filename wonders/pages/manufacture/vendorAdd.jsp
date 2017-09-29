<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>厂商管理</h6>
            <h6 id="sub-title" style="display: line-block;">添加</h6>
            <h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');">
            返回
            </h6>
        </div>
        <div class="row-fluid operation operation-resource">
        	<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商名称</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vName" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">联系电话</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vTel" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">所属国家</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="country" class="form-control input-sm selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商主页</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vUrl" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">所属地区</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="city" class="form-control input-sm selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">联系地址</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vAddr" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商备注</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vRemark" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-sm-12 operation-btn">
				<button type="button"  data-value="submit" onclick="vendorAdd();" class="btn btn-info btn-sm" >确定</button>
				<button type="button"  data-value="reset" onclick="loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');" class="btn btn-primary btn-sm">取消</button>
			</div>
        </div>
    </div>
   <div id="alertDialog"></div>
<script>
		$(function(){
    		$(".selectpicker").selectpicker({
				dropuAuto : false
			});
			initSelects("mdconfig/datacenter/country", "country", {}, null, "key", "value");
    		initSelects("mdconfig/datacenter/city", "city", {}, null, "key", "value");
    	});
//确定添加
	function vendorAdd(){
		var vName = $("#vName").val();//厂商名称
		var vTel = $("#vTel").val();//联系电话
		var vUrl = $("#vUrl").val();//联系邮箱
		var vAddr = $("#vAddr").val();//联系地址
		var vRemark = $("#vRemark").val();//备注
		var vCountry = $("#country").val();
		var city = $("#city").val();
		//厂商验证
		if(vName == null || vName == ""){
			toastr.error("请输入厂商！");
			return false;
		}else{
			var name = vName;
		}
		//country验证
		if(vCountry == null || vCountry == ""){
			toastr.error("请输入来源于哪个国家！");
			return false;
		}else{
			var country = vCountry;
		}
		//联系电话验证
		var reg = /^1[34578]\d{9}$/;
		var regTel = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
		if(vTel == null || vTel == ""){
			toastr.error("电话不能为空！");
			return false;
		}else if(!reg.test(vTel) && !regTel.test(vTel)){
			toastr.error("电话输入的格式不正确！");
			return false;
		}else{
			var phone = vTel;
		}
		//网址验证
		var reg=/^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;   
           if(vUrl == null || vUrl == ""){  
               toastr.error("请输入网址!");  
               return false;  
           }else if(!reg.test(vUrl)){   
               toastr.error("网址格式不正确");  
               return false;  
           }else{
           		var website = vUrl;
           }
		//地址
		if(vAddr == null || vAddr == ""){
			toastr.error("请输入联系地址");
			return false;
		}else{
			var address = vAddr;
		}
		$.ajax({
			"type":"POST",
			"url":"manufacturer/create",
			"data":{
			 	"name":name,
			 	"website":website,
			 	"address":address,
			 	"country":country,
			 	"city":city,
			 	"phone":phone,
			 	"remark":vRemark
			 },
			"dataType":"json",
			"success":function(resp){
				if(resp.code == "200"){
					toastr.success("添加成功！");
					loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');
				}else{
					toastr.error("请求有误！");
				}
			},
			"error":function(resp){
				toastr.error("添加失败！");
			}
		});
	}
</script>