<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>厂商管理</h6>
            <h6 id="sub-name"></h6>
            <h6 id="sub-title" style="display: line-block;">详情</h6>
            <h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');">
            返回
            </h6>
        </div>
        <div class="row-fluid operation">
			<div class="col-sm-12" style="padding: 5px 0 15px;">
				<button class="btn btn-default btn-sm" onclick="vEdit(this);"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
				<button class="btn btn-default btn-sm hidden" onclick="vendorEdit();"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
				<button class="btn btn-default btn-sm hidden" onclick="cancleEdit(this);"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
			</div>
			<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商名称</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vName" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">联系电话</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="tel" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">所属国家</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="country" disabled="disabled" class="form-control input-sm selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商主页</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vUrl" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">所属地区</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="city" disabled="disabled" class="form-control input-sm selectpicker input-group-select"></select>
				</div>
        	</div>	
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">联系地址</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vAddr" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商备注</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="vRemark" maxlength="64" class="form-control input-add" disabled/>
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
			initSelects("mdconfig/datacenter/country", "country", {}, null, "key", "value");
    		initSelects("mdconfig/datacenter/city", "city", {}, null, "key", "value");
    	});
    	var manufacturerId = "${param.manufacturerId}";
    	vDetail();
    	//详情
    	function vDetail(obj){
    		$.ajax({
    			"type":"GET",
    			"url":"manufacturer/detail",
    			"data":{"manufacturerId":manufacturerId},
    			"dataType":"json",
    			"success":function(resp){
    				if(resp.code == "200"){
    					var obj = resp.result.manufacturer;
    					$("#vName").val(obj.name);
    					$("#country").val(obj.country);
    					$("#city").val(obj.city);
    					$(".selectpicker").selectpicker("refresh");
    					$("#tel").val(obj.phone);
    					$("#vUrl").val(obj.website);
    					$("#vAddr").val(obj.address);
    					$("#vRemark").val(obj.remark);
    					$("#sub-name").html(obj.name);
    				}else{
    					toastr.error(resp.msg);
    				}
    			},
    			"error":function(resp){
    				toastr.error("请求失败！");
    			}
    		
    		});
    	}
    	//点击编辑按钮
    	function vEdit(obj){
    		$(obj).addClass("hidden");
			$(obj).siblings().removeClass("hidden");
			$(obj).parent().parent().addClass("operation-resource");
    		$(".operation input").attr("disabled",false);
    		$(".selectpicker").attr("disabled",false);
    		$("#vName").attr("disabled",true);
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
    		vDetail();
    	}
    	//保存编辑
    	function vendorEdit(){
    		var vName = $("#vName").val();//厂商
    		var vCountry = $("#country").val();
    		var vCity = $("#city").val(); 
			var vUrl = $("#vUrl").val();//联系邮箱
			var vTel = $("#tel").val(); // 电话
			var vAddr = $("#vAddr").val();//联系地址
			var vRemark = $("#vRemark").val();//备注
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
			//city验证
			if(vCity == null || vCity == ""){
				toastr.error("所在城市不能为空！");
				return false;
			}else{
				var city = vCity;
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
			//联系地址
			if(vAddr == null || vAddr == ""){
				toastr.error("请输入联系地址");
			}else{
				var address = vAddr;
			}
			$.ajax({
				"type":"POST",
				"url":"manufacturer/update",
				"data":{"manufacturerId":manufacturerId,
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
						toastr.success("修改成功！");
						loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp');
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