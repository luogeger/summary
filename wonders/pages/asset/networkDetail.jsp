<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.no-padding{
		padding: 0;
	}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>硬件资产管理</h6>
	<h6>网络设备</h6>
	<h6>查看</h6>
	<h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/asset/networkList.jsp')">
                返回
    </h6>
</div>
<div class="row-fluid operation">
	<div class="col-sm-12" style="padding: 5px 0 15px;">
		<button class="btn btn-default btn-sm" onclick="editInfo(this)"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
		<button class="btn btn-default btn-sm hidden" onclick="saveInfo(this)"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
		<button class="btn btn-default btn-sm hidden" onclick="cancelEdit(this)"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
	</div>
	<div class="col-sm-12 title-content">
		<strong>基本信息：</strong>
	</div>
	<div class="col-md-6 col-sm-6">
		<input type="hidden" id="networkDeviceId-edit"/>
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备编码</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="assetCode-edit" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">IPV4</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="ipv4-edit" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备类型</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="hidden" id="assetTypeId-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
            <input type="text" id="assetType-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">服务状态</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="serviceStatus-edit" disabled="disabled" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="hidden" id="manufacturerId-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
            <input type="text" id="manufacturer-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">系统状态</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="systemStatus-edit" disabled="disabled" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="hidden" id="modelId-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
            <input type="text" id="model-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">标签</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="label-edit" disabled="disabled" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">占用U位</label>
		<div class="col-md-9 col-sm-8 col">
			<div class="col-md-4 col-xs-3 no-padding" >
				<input type="text" id="unitStart-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
			</div>
			<div class="col-md-1 col-xs-1 no-padding text-center" style="position: relative;top: 5px;color: #888;">-</div>
			<div class="col-md-4 col-xs-3 no-padding">
				<input type="text" id="unitEnd-edit" readonly="readonly" maxlength="64" class="form-control input-add" style="text-align: left;"/>
			</div>
			<div class="col-md-3 col-xs-5 no-padding text-right" style="position: relative;top: 5px;color: #888;">（共<span class="unit">0</span>位）</div>
			
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">价格</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="price-edit" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">数据中心</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="datacenter-edit" onchange="changeComputerRoom()" disabled="disabled" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">购买时间</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="purchaseDate-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">机房名称</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="computerRoom-edit" onchange="changeCabinet()" disabled="disabled" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">过期时间</label>
		<div class="col-md-9 col-sm-8 col">
			<input type="text" id="expirationDate-edit" value="" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">机柜名称</label>
		<div class="col-md-9 col-sm-8 col">
			<select id="cabinet-edit" disabled="disabled" class="form-control input-sm selectpicker input-group-select">
            </select>
		</div>
	</div>
	<div class="col-md-6 col-sm-6">
		<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备描述</label>
		<div class="col-md-9 col-sm-8  col">
			<input type="text" id="remark-edit" maxlength="64" class="form-control input-add"/>
		</div>
	</div>
	<div class="configurationInfo">
		
	</div>
</div>

<script>
	var networkId = "${param.networkId}";
	$(function(){
		$("#expirationDate-edit").datepicker({
			format: "yyyy-mm-dd",
			autoclose: true,
			startDate: new Date(),
			language: "zh-CN"
		});
		$(".selectpicker").selectpicker();
		//数据中心
		initDatacenterSelects("datacenter-edit", null, "computerRoom-edit", "cabinet-edit");
		//服务状态
		initSelects("mdconfig/service/status", "serviceStatus-edit", null, null, "key", "value");
		//系统状态
		initSelects("mdconfig/system/status", "systemStatus-edit", null, null, "key", "value");
		//标签
		initSelects("label/list", "label-edit", null, null, "labelId", "name");
		setTimeout("networkDetail()",300);
		;
	});
	function networkDetail(){
		$.getJSON("network/device/detail?networkDeviceId="+networkId,function(r){
			if(r.code == 200){
				var networkDevice = r.result.NetworkDeviceVO;
				$("#networkDeviceId-edit").val(networkDevice.networkDeviceId);
				$("#assetType-edit").val(networkDevice.assetTypeName);
				$("#assetTypeId-edit").val(networkDevice.assetTypeId);
				$("#assetCode-edit").val(networkDevice.assetCode);
				$("#remark-edit").val(networkDevice.remark);
				$("#ipv4-edit").val(networkDevice.ipv4);
				$("#bandwidth-edit").val(networkDevice.bandwidth);
				$("#datacenter-edit").selectpicker("val",networkDevice.dataCenterId);
				$("#serviceStatus-edit").selectpicker("val",networkDevice.serviceStatus);
				$("#systemStatus-edit").selectpicker("val",networkDevice.systemStatus);
				$("#manufacturer-edit").val(networkDevice.manufacturerName);
				$("#manufacturerId-edit").val(networkDevice.manufacturerId);
				$("span.unit").text(networkDevice.units);
				$("#price-edit").val(networkDevice.price);
				$("#purchaseDate-edit").val(moment(networkDevice.purchaseDate).format("YYYY-MM-DD"));
				$("#expirationDate-edit").val(moment(networkDevice.expirationDate).format("YYYY-MM-DD"));
				$("#model-edit").val(networkDevice.modelName);
				$("#modelId-edit").val(networkDevice.modelId);
				$("#label-edit").selectpicker("val",networkDevice.labelId);
				$("#cabinet-edit").selectpicker("val",networkDevice.cabinetId);
				$("#unitStart-edit").val(networkDevice.unitStart);
				$("#unitEnd-edit").val(networkDevice.unitEnd);
				$(".selectpicker").selectpicker("refresh");
				loadConfiguration(networkDevice.assetTypeId,"assetTypeId-edit",networkDevice.data);
				$(".operation input").attr("disabled",true);
			}
		});
		
	}
	function cancelAdd(){
		loadMainPage("itam-content","pages/asset/networkList.jsp");
	}
	function editInfo(obj){
		$(obj).addClass("hidden");
		$(obj).siblings().removeClass("hidden");
		$(obj).parent().parent().addClass("operation-resource");
		$(".selectpicker").attr("disabled",false);
		$(".selectpicker").selectpicker("refresh");
		$(".operation input").attr("disabled",false);
	}
	function cancelEdit(obj){
		networkDetail(networkId);
		$(obj).addClass("hidden");
		$(obj).prev().addClass("hidden");
		$(obj).parent().children("button:eq(0)").removeClass("hidden");
		$(obj).parent().parent().removeClass("operation-resource");
		$(".selectpicker").attr("disabled",true);
		$(".selectpicker").selectpicker("refresh");
		$(".operation input").attr("disabled",true);
	}
	function saveInfo(){
		var networkDeviceId = $("#networkDeviceId-edit").val();
		var assetTypeId = $("#assetTypeId-edit").val();
		var assetCode = $("#assetCode-edit").val();
		var ipv4 = $("#ipv4-edit").val();
		var remark = $("#remark-edit").val();
		var bandwidth = "2";
		var serviceStatus = $("#serviceStatus-edit").val();
		var systemStatus = $("#systemStatus-edit").val();
		var manufacturerId = $("#manufacturerId-edit").val();
		var price = $("#price-edit").val();
		var purchaseDate = $("#purchaseDate-edit").val();
		var expirationDate = $("#expirationDate-edit").val();
		var modelId = $("#modelId-edit").val();
		var labelId = $("#label-edit").val();
		var cabinetId = $("#cabinet-edit").val();
		var unitStart = $("#unitStart-edit").val();
		var unitEnd = $("#unitEnd-edit").val();
		var datacenter = $("#datacenter-edit").val();
		var computerRoom = $("#computerRoom-edit").val();
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
		if(serviceStatus == null || serviceStatus == ""){
			toastr.error("请先添加服务状态");
			return false;
		}
		if(systemStatus == null || systemStatus == ""){
			toastr.error("请先添加系统状态");
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
		if(price == null || price == ""){
			toastr.error("请输入价格");
			$("#price-add").focus();
			return false;
		}else if(!REGPRICE.test(price)){
			toastr.error("价格格式有误");
			$("#price-add").focus();
			return false;
		}
		if(datacenter == null || datacenter == ""){
			toastr.error("请先添加数据中心");
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
		var data = {networkDeviceId:networkDeviceId, assetTypeId:assetTypeId, assetCode:assetCode, remark:remark, ipv4:ipv4, bandwidth:bandwidth, 
					serviceStatus:serviceStatus, systemStatus:systemStatus, manufacturerId:manufacturerId,
					price:price, purchaseDate:purchaseDate, expirationDate:expirationDate, modelId:modelId,
					labelId:labelId, cabinetId:cabinetId,unitStart:unitStart, unitEnd:unitEnd, data:configurationData, };
		$.ajax({
				type: 'post',
				url: "network/device/update",
				data: data,
				dataType: 'json',
	            success: function (data) {
	            	if(data.code==200){
	            		toastr.success("修改成功");
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
	function changeComputerRoom(){
		var dataCenterId = $("#datacenter-edit").val();
		initComputerroomSelects(dataCenterId,"computerRoom-edit", "cabinet-edit");
	}
	function changeCabinet(){
		var computerRoomId = $("#computerRoom-edit").val();
		initCabinetSelects(computerRoomId, "cabinet-edit");
	}
</script>
