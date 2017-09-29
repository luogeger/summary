<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.no-padding{
		padding: 0;
	}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>硬件资产管理</h6>
	<h6>存储设备</h6>
	<h6>添加</h6>
</div>
<div class="row-fluid operation operation-resource">
	<div class="col-sm-12 title-content">
		<strong>基本信息</strong>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备编码</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="assetCode-add" maxlength="64" style="ime-mode:disabled" onkeyup="this.value=this.value.replace(/[\u4e00-\u9fa5]/g,'')" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">IPV4</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="ipv4-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备类型</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="assetType-add" onchange="loadConfiguration(null,'assetType-add',null);changeModel()" class="form-control input-sm selectpicker input-group-select input-add">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="resourcePool-add" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="manufacturer-add" onchange="changeModel()"  class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="model-add" onchange="changeUnits(this)" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">占用U位</label>
		<div class="col-md-9 col-sm-8 col">
			<div class="col-md-4 col-xs-3 no-padding" >
				<input type="text" id="unitStart-add" maxlength="64" class="form-control input-add"/>
			</div>
			<div class="col-md-1 col-xs-1 no-padding text-center" style="position: relative;top: 5px;color: #888;">-</div>
			<div class="col-md-4 col-xs-3 no-padding">
				<input type="text" id="unitEnd-add" maxlength="64" class="form-control input-add"/>
			</div>
			<div class="col-md-3 col-xs-5 no-padding text-right" style="position: relative;top: 5px;color: #888;">（共<span class="unit">0</span>位）</div>
			
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">数据中心</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="datacenter-add" onchange="changeComputerRoom()" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所在机房</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="computerRoom-add" onchange="changeCabinet()" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所在机柜</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="cabinet-add" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">服务状态</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="serviceStatus-add" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">系统状态</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="systemStatus-add" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">价格</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="price-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">标签</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="label-add" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">购买时间</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="purchaseDate-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">过期时间</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="expirationDate-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备描述</label>
		<div class="col-md-9 col-sm-8  col">
			<input type="text" id="remark-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="configurationInfo">
	</div>
	<div class="col-sm-12 operation-btn">
		<button type="button"  data-value="submit" onclick="addStorage()" class="btn btn-info btn-sm" >确定</button>
		<button type="button"  data-value="reset" onclick="back()" class="btn btn-primary btn-sm">取消</button>
	</div>
</div>

<script>
	$(function(){
		$("input[id$='Date-add']").datepicker({
			format: "yyyy-mm-dd",
			autoclose: true,
			language: "zh-CN"
		});
		$(".selectpicker").selectpicker();
		//设备类型
		initAssetTypeSelects("assetType-add", {category:STORAGE}, "manufacturer-add", "model-add");
		//资源池
		initPoolSelects("resourcePool-add",{type:STORAGE_POOT_TYPE});
		//数据中心
		initDatacenterSelects("datacenter-add", null, "computerRoom-add", "cabinet-add");
		//服务状态
		initSelects("mdconfig/service/status", "serviceStatus-add", null, null, "key", "value");
		//系统状态
		initSelects("mdconfig/system/status", "systemStatus-add", null, null, "key", "value");
		//标签
		initSelects("label/list", "label-add", null, null, "labelId", "name");
	});
	function addStorage(){
		var assetTypeId = $("#assetType-add").val();
		var assetCode = $("#assetCode-add").val();
		var remark = $("#remark-add").val();
		var ipv4 = $("#ipv4-add").val();
		var resourcePool = $("#resourcePool-add").val();
		var serviceStatus = $("#serviceStatus-add").val();
		var systemStatus = $("#systemStatus-add").val();
		var manufacturerId = $("#manufacturerId-add").val();
		var price = $("#price-add").val();
		var purchaseDate = $("#purchaseDate-add").val();
		var expirationDate = $("#expirationDate-add").val();
		var modelId = $("#model-add").val();
		var labelId = $("#label-add").val();
		var cabinetId = $("#cabinet-add").val();
		var unitStart = $("#unitStart-add").val();
		var unitEnd = $("#unitEnd-add").val();
		var configurationData = "";
		var configurationInfo = $(".configurationInfo [id^='extension']");
		for ( var i = 0; i < configurationInfo.length; i++) {
			var id = $(configurationInfo[i]).attr("data-value");
			var val = $(configurationInfo[i]).val();
			var dataRequired =  $(configurationInfo[i]).attr("data-required");
			if(dataRequired == 1){
				if(val == null || val == ""){
					toastr.error("请输入"+$(configurationInfo[i]).attr("data-name"));
					$(configurationInfo[i]).focus();
					return false;
					break;
				}
			}
			configurationData += "\""+id+"\":\""+val+"\"";
			if(i != configurationInfo.length-1){
				configurationData += ",";
			};
		}
		configurationData = "{"+configurationData+"}";
		var data = {assetTypeId:assetTypeId, assetCode:assetCode, remark:remark, ipv4:ipv4, resourcePoolId:resourcePool, 
					serviceStatus:serviceStatus, systemStatus:systemStatus, manufacturerId:manufacturerId,
					price:price, purchaseDate:purchaseDate, expirationDate:expirationDate, modelId:modelId,
					labelId:labelId, cabinetId:cabinetId,unitStart:unitStart, unitEnd:unitEnd};
		$.ajax({
				type: 'post',
				url: "storage-device/create",
				data: data,
				dataType: 'json',
	            success: function (data) {
	            	if(data.code==200){
	            		toastr.success("存储设备添加成功！");
	            		back();
	            	}else {
	            		toastr.error(data.msg);
					}
				},
				error : function(data) {
					toastr.error(data.msg);
				}
			}); 
	}
	function back(){
		loadMainPage("itam-content","pages/asset/storageList.jsp");
	}
	function changeModel(){
		var manufacturerId = $("#manufacturer-add").val();
		var assetTypeId = $("#assetType-add").val();
		initModelSelects(manufacturerId, "model-add", assetTypeId);
		
	}
	function changeComputerRoom(){
		var dataCenterId = $("#datacenter-add").val();
		initComputerroomSelects(dataCenterId,"computerRoom-add", "cabinet-add");
	}
	function changeCabinet(){
		var computerRoomId = $("#computerRoom-add").val();
		initCabinetSelects(computerRoomId, "cabinet-add");
	}
</script>
