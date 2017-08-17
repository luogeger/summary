<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        .m0{
            margin: 0;
        }
        .m30{
            margin: 20px 0 0 50px;
        }
    </style>

<!--  navigate  -->
<div class="console-title console-title-border">
    <h6>资产管理系统</h6>
    <h6>资源管理</h6>
    <h6>机柜</h6>
    <h6>添加</h6>
</div>

<!--  info  -->
<div class="row-fluid operation operation-resource">
	<div class="col-md-6 col-sm-6">
		<input type="hidden" id="networkDeviceId-edit"/>
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">机柜编码</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="cabinetNum" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="vendor" class="form-control selectpicker input-group-select"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="model" class="form-control selectpicker input-group-select"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">总U位</label>
		<div class="col-md-9 col-sm-8 col">
            <input type="text" id="units"  maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">数据中心</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="dataCenter" class="form-control selectpicker input-group-select"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所属机房</label>
		<div class="col-md-9 col-sm-8 col">
            <select id="comRoom" class="form-control selectpicker input-group-select"></select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn"  style="height: 60px;">备注</label>
		<div class="col-md-9 col-sm-8 col">
			<textarea id="remark" cols="10" rows="2" class="form-control  input-add" style="resize:none; box-sizing:border-box;" ></textarea>
		</div>
	</div>
	<!-- operation -->
	<div class="col-sm-12 operation-btn">
		<button type="button"  data-value="submit" onclick="saveData()" class="btn btn-info btn-sm" >确定</button>
		<button type="button"  data-value="reset" onclick="cancelData()" class="btn btn-primary btn-sm">取消</button>
	</div>
</div>



<script>
	//初始化
	$(function(){
		$(".selectpicker").selectpicker({
			dropuAuto : false
		});
	});
	// 厂商 - 型号 - 数据中心 - 所属机房 -->下拉框初始化
	initSelects('manufacturer/list', "vendor", {}, null ,"manufacturerId", "name");//厂商
	initSelects('model/list', "model", {}, null ,"modelId", "name");//型号
	initSelects('data-center/list', "dataCenter", {}, null ,"dataCenterId", "name");//数据中心
	initSelects('computer-room/list', "comRoom", {}, null ,"computerRoomId", "name");//所属机房

    //保存按钮
    function saveData (){
    	var cabinetNum = $('#cabinetNum').val();
    	var vendor = $('#vendor').val();
    	var model = $('#model').val();
    	var units = $('#units').val();
    	var dataCenter = $('#dataCenter').val();
    	var comRoom = $('#comRoom').val();
    	var remark = $('#remark').val();
    	//机柜 - 验证
    	if(cabinetNum == null || cabinetNum == ""){
			toastr.error("请先添加机柜");
			return false;
		}
    	//厂商 - 验证
		if(vendor == null || vendor == ""){
			toastr.error("请先添加厂商");
			return false;
		}
    	//型号 - 验证
		if(model == null || model == ""){
			toastr.warning("请输入型号名称！");
			return false;
		}
		//总U位 - 验证
		if( units == null ||  units == ""){
			toastr.warning("请输入总U位！");
			return false;
		}
		//数据中心 - 验证
		if( dataCenter == null ||  dataCenter == ""){
			toastr.warning("请先添加数据中心");
			return false;
		}
		//所属机房 - 验证
    	if( comRoom == null ||  comRoom == ""){
			toastr.warning("请先添加机房");
			return false;
		}
		
		var data = {
				"cabinetId": cabinetNum,
				"manufacturerId": vendor,
				"modelId": model,
				"units": units,
				"name": dataCenter,
				"computerRoomId": comRoom,
				"remark": remark,
		};
		
		$.ajax({
				"type":"POST",
				"url":"cabinet/create",
				"data":data,
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
						toastr.success(resp.msg);
						loadMainPage('itam-content','pages/resource/cabinet.jsp');
					}else{
						toastr.error(resp.msg);
					}
				},
				"error":function(resp){
					toastr.error("请求失败！");
				}
			});
    }
    //取消按钮
    function cancelData (){
    	loadMainPage('itam-content','pages/resource/cabinet.jsp');
    }
    
</script>



































