<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>型号管理</h6>
            <h6 id="sub-name"></h6>
            <h6 id="sub-title" style="display: line-block;">详情</h6>
             <h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/manufacture/modelManagement.jsp');">
            返回
            </h6>
        </div>
        <div class="row-fluid operation">
        	<div class="col-sm-12" style="padding: 5px 0 15px;">
				<button class="btn btn-default btn-sm" onclick="mEdit(this);"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
				<button class="btn btn-default btn-sm hidden" onclick="modelEdit();"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
				<button class="btn btn-default btn-sm hidden" onclick="cancleEdit(this);"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
			</div>
        	<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
			<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">型号名称</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<input type="text" id="modelName" maxlength="64" class="form-control input-add" disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<select id="vName-edit" class="form-control selectpicker input-group-select" disabled></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">资产分类</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<select id="resModel" class="form-control selectpicker input-group-select" disabled></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col" id="unite-type">总U位</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="unit-detail" maxlength="64" class="form-control input-add"  disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">资产类型</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<select id="deviceType" class="form-control selectpicker input-group-select" disabled></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">型号描述</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<input type="text" id="mRemark" maxlength="64" class="form-control input-add"  disabled/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6" id="portNumber-show" style="display:none">
        		<label class="col-md-3 col-sm-4 control-label col">端口数</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<input type="text" id="portNum" maxlength="64" class="form-control input-add"  disabled/>
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
		initSelects('manufacturer/list', "vName-edit", {}, null ,"manufacturerId", "name");//厂商列表
		modelType();//资产分类
		
		onresModel();
	});
	var modelId = "${param.modelId}";
	mDetail();
	//详情
	function mDetail(){
		$.ajax({
			"type":"get",
			"url":"model/detail?modelId="+modelId,
			"data":{},
			"dataType":"json",
			"success":function(resp){
				if(resp.code == "200"){
					var obj = resp.result.model;
					$("#modelName").val(obj.name);
					$("#unit-detail").val(obj.units);
					$("#portNum").val(obj.portNumber);
					$("#mRemark").val(obj.remark);
					$("#sub-name").html(obj.name);
					$("#vName-edit").val(obj.manufacturerId);	
					$("#resModel").val(obj.category);
					initSelects('asset/type', "deviceType", {"category":$("#resModel").val()}, null ,"assetTypeId", "name");//资产类型
					$(".selectpicker").selectpicker("refresh");
					$("#deviceType").val(obj.assetTypeId);
					if(obj.category == CABINET){
						$("#unite-type").html("总U位");
					}else{
						$("#unite-type").html("占用U位");
					}
					if(obj.category == NETWORK || obj.category == SECURITY){
						$("#portNumber-show").css("display","block");
					}else{
						$("#portNumber-show").css("display","none");
					}
				}
			},
			"error":function(resp){
				toastr.error(resp.msg);
			}
		});
	}
	
	//编辑
	function mEdit(obj){
		$(obj).addClass("hidden");
		$(obj).siblings().removeClass("hidden");
		$(obj).parent().parent().addClass("operation-resource");
		$("#sub-title").html("编辑");
		$("#unite-type").html("总U位");
		$(".selectpicker").attr("disabled",false);
		$(".operation input").attr("disabled",false);
		$("#modelName").attr("disabled",true);
		$(".selectpicker").selectpicker("refresh");
	}
	//确定编辑
	function modelEdit(){
		var mName = $("#modelName").val();
		var mUnits = $("#unit-detail").val();
		var category = $("#resModel").val();//型号类型
		var remark = $("#mRemark").val();//型号描述
		var portNumber = $("#portNum").val(); //端口数
		var manufacturerId = $("#vName-edit").val(); //厂商ID
		var assetTypeId = $("#deviceType").val(); // 设备类型ID
		//型号名称验证
		if(mName == null || mName == ""){
			toastr.error("请输入型号名称！");
			return false;
		}else{
			var name = mName;
		}
		//总U位验证
		if( mUnits == null ||  mUnits == ""){
			toastr.error("请输入总U位！");
			return false;
		}else{
			var units =  mUnits;
		}
		$.ajax({
			"type":"POST",
			"url":"model/update",
			"data":{"modelId":modelId,
					"name":name,
					"category":category,
					"assetTypeId":assetTypeId,
					"manufacturerId":manufacturerId,
					"remark":remark,
					"units":units,
					"portNumber":portNumber
					},
			"dataType":"json",
			"success":function(resp){
				if(resp.code == "200"){
					toastr.success("更新成功！");
					loadMainPage('itam-content','pages/manufacture/modelManagement.jsp');
				}else{
					toastr.error("输入的数值有误！");
				}
			},
			"error":function(resp){
				toastr.error("请求失败！");
			}
		});
	}
	//取消编辑
	function cancleEdit(obj){
		$(obj).addClass("hidden");
		$(obj).prev().addClass("hidden");
		$(obj).parent().children("button:eq(0)").removeClass("hidden");
		$(obj).parent().parent().removeClass("operation-resource");
		$("#sub-title").html("详情");
		$(".selectpicker").attr("disabled",true);
		$(".selectpick").selectpicker("refresh");
		$(".operation input").attr("disabled",true);
		mDetail();
	}
	//监听资产类型改变
	$("#resModel").change(function(){
		var value = $("#resModel").val();
		if(value == NETWORK || value == SECURITY){
			$("#portNumber-show").css("display","block");
		}else{
			$("#portNumber-show").css("display","none");
		}
		if(value == CABINET){
			$("#unite-type").html("总U位");
		}else{
			$("#unite-type").html("占用U位");
		}
	});
	 //初始化资产类型下拉菜单
function modelType(){
	$.ajax({
		"type":"GET",
		"url":"mdconfig/resource/type",
		"data":{},
		"dataType":"json",
		"success":function(resp){
			if(resp.code == "200"){
			  var arr = resp.result.list;
			  for(var i=0;i<arr.length;i++){
			  	var key = arr[i].key;
			  	var value = arr[i].value;
			  	if(arr[i].key != 1 && arr[i].key != 2){
			  		var str = "<option value="+key+">"+value+"</option>";
			  			$("#resModel").append(str);
			  	}
			  	$(".selectpicker").selectpicker("refresh");
			  }
			}else{
				toastr.error(resp.msg);
			}
		},
		"error":function(resp){
			toastr.error("请求失败！");
		}
	});
}
  //监听资产类型
	function onresModel(){
		$("#resModel").change(function(){
			initSelects('asset/type', "deviceType", {"category":$("#resModel").val()}, null ,"assetTypeId", "name");//设备类型
		});
	}
</script>