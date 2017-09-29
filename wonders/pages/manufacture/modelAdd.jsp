<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>型号管理</h6>
            <h6 id="sub-title" style="display: line-block;">添加</h6>
             <h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/manufacture/modelManagement.jsp');">
           返回
           </h6>
        </div>
        <div class="row-fluid operation operation-resource">
        	<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
		   <div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">型号名称</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<input type="text" id="modelName" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">厂商名称</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<select id="vName-edit" class="form-control selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">资产分类</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<select id="resModel" class="form-control selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col" id="unite-type">总U位</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="unit-add" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">资产类型</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<select id="deviceType" class="form-control selectpicker input-group-select"></select>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6">
        		<label class="col-md-3 col-sm-4 control-label col">型号备注</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<input type="text" id="mRemark" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-md-6 col-sm-6" id="portNumber-show" style="display:none">
        		<label class="col-md-3 col-sm-4 control-label col">端口数</label>
				<div class="col-md-9 col-sm-8 text-right col">
					<input type="text" id="portNum" maxlength="64" class="form-control input-add"/>
				</div>
        	</div>
        	<div class="col-sm-12 operation-btn">
				<button type="button"  data-value="submit" onclick="modelAdd();" class="btn btn-info btn-sm" >确定</button>
				<button type="button"  data-value="reset" onclick="loadMainPage('itam-content','pages/manufacture/modelManagement.jsp');" class="btn btn-primary btn-sm">取消</button>
			</div>
        </div>
    </div>
    <div id="alertDialog"></div>
<script>
	$(function(){
		$(".selectpicker").selectpicker({
			dropuAuto : false
		});
		
	});
  	modelType();//初始化资产类型表
	initSelects('manufacturer/list', "vName-edit", {}, null ,"manufacturerId", "name");//厂商列表
	initSelects('asset/type', "deviceType", {"category":CABINET}, null ,"assetTypeId", "name");//资产分类
	$(".selectpicker").selectpicker("refresh");
	onresModel();
	function modelAdd(){
		var mName = $("#modelName").val(); //型号名称
		var mUnits = $("#unit-add").val();//总U位
		var category = $("#resModel").val();//资产类型
		var portNumber = $("#portNum").val(); // 端口数
		var remark = $("#mRemark").val();//型号描述
		var manufacturerId = $("#vName-edit").val(); //厂商ID
		var assetTypeId = $("#deviceType").val();                //设备ID
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
			"url":"model/create",
			"data":{
					"name":name,
					"category":category,
					"assetTypeId":assetTypeId,
					"manufacturerId":manufacturerId,
					"remark":remark,
					"units":units,
					"portNumber":portNumber,
				},
			"dataType":"json",
			"success":function(resp){
				if(resp.code == "200"){
					toastr.success("添加成功！");
					loadMainPage('itam-content','pages/manufacture/modelManagement.jsp');
				}else{
					toastr.error(resp.msg);
				};
			},
			"error":function(resp){
				toastr.error("请求失败！");
			}
		});
	}
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
			console.log("请求失败！");
		}
	});
}
  //监听资产类型改变
	$("#resModel").change(function(){
		var value = $("#resModel").val();
		if(value == NETWORK  || value == SECURITY){
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
	//监听资产类型
	function onresModel(){
		$("#resModel").change(function(){
			initSelects('asset/type', "deviceType", {"category":$("#resModel").val()}, null ,"assetTypeId", "name");//设备类型
		});
	}
  </script>