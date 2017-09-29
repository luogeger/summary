<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.no-padding{
		padding: 0;
	}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>硬件资产管理</h6>
	<h6>安全设备</h6>
	<h6>添加</h6>
	<h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/asset/securityList.jsp')">
                返回
    </h6>
</div>
<div class="row-fluid operation operation-resource">
	<div class="col-sm-12 title-content">
		<strong>基本信息：</strong>
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
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">服务状态</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="serviceStatus-add" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="manufacturer-add" onchange="changeModel()" class="form-control input-sm selectpicker input-group-select">
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
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="model-add" onchange="changeUnits(this)" class="form-control input-sm selectpicker input-group-select">
            </select>
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
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">价格</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="price-add" maxlength="64" class="form-control input-add"/>
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
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">购买时间</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="purchaseDate-add" maxlength="64" class="form-control input-add"/>
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
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">过期时间</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="expirationDate-add" maxlength="64" class="form-control input-add"/>
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
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备描述</label>
		<div class="col-md-9 col-sm-8  col">
			<input type="text" id="remark-add" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="configurationInfo">
	</div>
	<div class="col-sm-12 operation-btn">
		<button type="button"  data-value="submit" onclick="addsecurity()" class="btn btn-info btn-sm" >确定</button>
		<button type="button"  data-value="reset" onclick="cancelAdd()" class="btn btn-primary btn-sm">取消</button>
	</div>
</div>

<script>
	$(function(){
		$("#purchaseDate-add").datepicker({
			format: "yyyy-mm-dd",
			autoclose: true,
			endDate: new Date(),
			language: "zh-CN"
		});
		$("#expirationDate-add").datepicker({
			format: "yyyy-mm-dd",
			autoclose: true,
			startDate: new Date(),
			language: "zh-CN"
		});
		$(".selectpicker").selectpicker();
		//设备类型
		initAssetTypeSelects("assetType-add", {category: SECURITY}, "manufacturer-add", "model-add");
		//数据中心
		initDatacenterSelects("datacenter-add", null, "computerRoom-add", "cabinet-add");
		//服务状态
		initSelects("mdconfig/service/status", "serviceStatus-add", null, null, "key", "value");
		//系统状态
		initSelects("mdconfig/system/status", "systemStatus-add", null, null, "key", "value");
		//标签
		initSelects("label/list", "label-add", null, null, "labelId", "name");
	});
	function addsecurity(){
		var assetTypeId = $("#assetType-add").val();
		var assetCode = $("#assetCode-add").val();
		var ipv4 = $("#ipv4-add").val();
		var remark = $("#remark-add").val();
		var bandwidth = "2";
		var serviceStatus = $("#serviceStatus-add").val();
		var systemStatus = $("#systemStatus-add").val();
		var manufacturerId = $("#manufacturer-add").val();
		var price = $("#price-add").val();
		var purchaseDate = $("#purchaseDate-add").val();
		var expirationDate = $("#expirationDate-add").val();
		var modelId = $("#model-add").val();
		var labelId = $("#label-add").val();
		var cabinetId = $("#cabinet-add").val();
		var unitStart = $("#unitStart-add").val();
		var unitEnd = $("#unitEnd-add").val();
		var datacenter = $("#datacenter-add").val();
		var computerRoom = $("#computerRoom-add").val();
		if(assetCode == null || assetCode == ""){
			toastr.error("请输入设备编码");
			$("#assetCode-add").focus();
			return false;
		}
		if(ipv4 == null || ipv4 == ""){
			toastr.error("请输入IP");
			$("#ipv4-add").focus();
			return false;
		}else if(!REGIP.test(ipv4)){
			toastr.error("IP格式错误");
			$("#ipv4-add").focus();
			return false;
		}
		if(assetTypeId == null || assetTypeId == ""){
			toastr.error("请先添加设备状态");
			return false;
		}
		if(serviceStatus == null || serviceStatus == ""){
			toastr.error("请先添加服务状态");
			return false;
		}
		if(manufacturerId == null || manufacturerId == ""){
			toastr.error("请先添加厂商");
			return false;
		}
		if(systemStatus == null || systemStatus == ""){
			toastr.error("请先添加系统状态");
			return false;
		}
		if(modelId == null || modelId == ""){
			toastr.error("请先添加型号");
			return false;
		}
		if(labelId == null || labelId == ""){
			toastr.error("请先添加标签");
			return false;
		}
		var unit = $("span.unit").text();
		if(unitStart == null || unitStart == ""){
			toastr.error("请输入开始U位");
			$("#unitStart-add").focus();
			return false;
		}else if(unitEnd == null || unitEnd == ""){
			toastr.error("请输入结束U位");
			$("#unitEnd-add").focus();
			return false;
		}else if(unitStart > unitEnd){
			toastr.error("开始U位要小于结束U位");
			$("#unitEnd-add").focus();
			return false;
		}else if(unitEnd > parseInt(unit)){
			toastr.error("结束U位要小于等于总U位");
			$("#unitEnd-add").focus();
			return false;
		}
		if(datacenter == null || datacenter == ""){
			toastr.error("请先添加数据中心");
			return false;
		}
		if(price == null || price == ""){
			toastr.error("请输入价格");
			$("#price-add").focus();
			return false;
		}else if(!REGPRICE.test(price)){
			toastr.error("价格格式有误");
			$("#price-add").focus();
			return false;
		}
		if(computerRoom == null || computerRoom == ""){
			toastr.error("请先添加机房");
			return false;
		}
		if(cabinetId == null || cabinetId == ""){
			toastr.error("请先添加机柜");
			return false;
		}
		if(purchaseDate == null || purchaseDate == ""){
			toastr.error("请选择购买时间");
			$("#purchaseDate-add").focus();
			return false;
		}else if(expirationDate == null || expirationDate == ""){
			toastr.error("请选择过期时间");
			$("#expirationDate-add").focus();
			return false;
		}else if(purchaseDate >= expirationDate){
			toastr.error("过期时间要大于购买时间");
			$("#expirationDate-add").focus();
			return false;
		}
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
		console.log(configurationData);
		var data = {assetTypeId:assetTypeId, assetCode:assetCode, remark:remark, ipv4:ipv4, bandwidth:bandwidth, 
					serviceStatus:serviceStatus, systemStatus:systemStatus, manufacturerId:manufacturerId,
					price:price, purchaseDate:purchaseDate, expirationDate:expirationDate, modelId:modelId,
					labelId:labelId, cabinetId:cabinetId,unitStart:unitStart, unitEnd:unitEnd, data:configurationData, };
		$.ajax({
				type: 'post',
				url: "security/device/create",
				data: data,
				dataType: 'json',
	            success: function (data) {
	            	if(data.code==200){
	            		toastr.success("添加成功");
	            		cancelAdd();
	            	}else {
	            		toastr.error(data.msg);
					}
				},
				error : function(data) {
					toastr.error(data.msg);
				}
			}); 
	}
	function cancelAdd(){
		loadMainPage("itam-content","pages/asset/securityList.jsp");
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
