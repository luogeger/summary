<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>硬件资产管理</h6>
            <h6>外设设备</h6>
            <h6 id="device-name"></h6>
            <h6 id="sub-title" style="display: line-block;">详情</h6>
            <a id="return-btn" class="pull-right" type="button" style="display: inline-block;cursor: pointer;" onclick="loadMainPage('itam-content','pages/asset/peripheralList.jsp')">
                <span class="icon-reply"></span>
                返回
            </a>
        </div>
        <div class="row-fluid operation">
        	<div class="col-sm-12" style="padding: 5px 0 15px;">
				<button class="btn btn-default btn-sm" onclick="editInfo(this)"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
				<button class="btn btn-default btn-sm hidden" onclick="saveInfo()"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
				<button class="btn btn-default btn-sm hidden" onclick="cancelEdit(this)"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
			</div>
        	<div class="col-sm-12 title-content">
				<strong>基本信息</strong>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备编码</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="assetCode-edit" maxlength="64" style="ime-mode:disabled" onkeyup="this.value=this.value.replace(/[\u4e00-\u9fa5]/g,'')" class="form-control input-add" disabled/>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">服务状态</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="serviceStatus-edit" class="form-control input-sm selectpicker input-group-select"  disabled>
		            </select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备类型</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="assetType-edit" class="form-control input-sm selectpicker input-group-select input-add"  disabled></select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">系统状态</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="systemStatus-edit" class="form-control input-sm selectpicker input-group-select"  disabled></select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">厂商</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="manufacturer-edit" class="form-control input-sm selectpicker input-group-select" disabled></select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">标签</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="label-edit" class="form-control input-sm selectpicker input-group-select" disabled></select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">型号</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="model-edit" class="form-control input-sm selectpicker input-group-select" disabled></select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">价格</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="price-edit" maxlength="64" class="form-control input-add" disabled/>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">占用U位</label>
				<div class="col-md-9 col-sm-8 col">
					<div class="col-md-4 col-xs-3 no-padding" >
						<input type="text" id="unitStart-edit" maxlength="64" class="form-control input-add" readonly/>
					</div>
					<div class="col-md-1 col-xs-1 no-padding text-center" style="position: relative;top: 5px;color: #888;">-</div>
					<div class="col-md-4 col-xs-3 no-padding">
						<input type="text" id="unitEnd-edit" maxlength="64" class="form-control input-add" readonly/>
					</div>
					<div class="col-md-3 col-xs-5 no-padding text-right" style="position: relative;top: 5px;color: #888;">（共<span class="unit">0</span>位）</div>
					
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">购买时间</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="purchaseDate-edit" maxlength="64" class="form-control input-add" readonly/>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">数据中心</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="datacenter-edit" onchange="changeComputerRoom()" class="form-control input-sm selectpicker input-group-select" disabled></select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">过期时间</label>
				<div class="col-md-9 col-sm-8 col">
					<input type="text" id="expirationDate-edit" maxlength="64" class="form-control input-add" disabled/>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所在机房</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="computerRoom-edit" onchange="changeCabinet()" class="form-control input-sm selectpicker input-group-select" disabled>
		            </select>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">设备描述</label>
				<div class="col-md-9 col-sm-8  col">
					<input type="text" id="remark-edit" maxlength="64" class="form-control input-add" disabled/>
				</div>
			</div>
			<div class="col-md-6 col-sm-6">
				<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">所在机柜</label>
				<div class="col-md-9 col-sm-8 col">
					<select id="cabinet-edit" class="form-control input-sm selectpicker input-group-select" disabled>
		            </select>
				</div>
			</div>
			 <div class="configurationInfo">
		
			</div>
        </div>
    </div>
   
<script>
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
		//设备类型
		initSelects("asset/type", "assetType-edit", {category:PERIPHERAL}, null, "assetTypeId", "name");
		//厂商
		initSelects("manufacturer/list", "manufacturer-edit",{},null, "manufacturerId", "name");
		//型号
		initSelects("model/list", "model-edit",{},null, "modelId", "name");
		
   	});
	var peripheralDeviceId = "${param.peripheralDeviceId}";
	setTimeout(" deviceDetail()",500);
	//详情
	function deviceDetail(){
		$.ajax({
		"type":"GET",
		"url":"peripheral/device/detail",
		"data":{"peripheralDeviceId":peripheralDeviceId},
		"dataType":"json",
		"success":function(resp){
			if(resp.code == "200"){
				var obj = resp.result.PeripheralDeviceVO;
				$("#assetCode-edit").val(obj.assetCode);             //设备编码
				$("#serviceStatus-edit").val(obj.serviceStatus);     //服务状态
				$("#assetType-edit").val(obj.assetTypeId);             //设备类型
				$("#systemStatus-edit").val(obj.systemStatus);       // 系统状态
				$("#manufacturer-edit").val(obj.manufacturerId);     //厂商
				$("#label-edit").val(obj.labelId);                   //标签
				$("#model-edit").val(obj.modelId);                   //型号
				$("#price-edit").val(obj.price);                     //价格
				$("#unitStart-edit").val(obj.unitStart);             //开始U位
				$("#unitEnd-edit").val(obj.unitEnd);                 //结束U位
				$("#purchaseDate-edit").val(moment(obj.purchaseDate).format("YYYY-MM-DD"));       //购买时间
				$("#datacenter-edit").val(obj.dataCenterId);         //数据中心
				$("#expirationDate-edit").val(moment(obj.expirationDate).format("YYYY-MM-DD"));   //过期时间
				$("#computerRoom-edit").val(obj.computerRoomId);   //所在机房
				$("#remark-edit").val(obj.remark);                   //设备描述
				$("#cabinet-edit").val(obj.cabinetId);             //所在机柜
				$(".unit").html(obj.units);                          //共U位
				$("#device-name").html(obj.assetTypeName);       
				$(".selectpicker").selectpicker("refresh");          //初始化下拉菜单
				loadConfiguration(obj.assetTypeId,"assetType-edit",obj.data);
				//loadConfiguration(networkDevice.assetTypeId,"assetTypeId-edit",networkDevice.data);
				$(".operation input").attr("disabled",true);
			}
		},
		"error":function(resp){
			toastr.error("详情请求失败！");
		}
	});
	}
	//点击编辑
	function editInfo(obj){
		$(obj).addClass("hidden");
		$(obj).siblings().removeClass("hidden");
		$(obj).parent().parent().addClass("operation-resource");
		$(".selectpicker").attr("disabled",false);
		$("#assetCode-edit").attr("disabled",true);
		$("#manufacturer-edit").attr("disabled",true);
		$("#assetType-edit").attr("disabled",true);
		$("#model-edit").attr("disabled",true);
		$(".selectpicker").selectpicker("refresh");
		$(".operation input").attr("disabled",false);
	}
	function cancelEdit(obj){
		deviceDetail();
		$(obj).addClass("hidden");
		$(obj).prev().addClass("hidden");
		$(obj).parent().children("button:eq(0)").removeClass("hidden");
		$(obj).parent().parent().removeClass("operation-resource");
		$(".selectpicker").attr("disabled",true);
		$(".selectpicker").selectpicker("refresh");
		$(".operation input").attr("disabled",true);
	}
	//编辑
	function saveInfo(){
		var assetTypeId = $("#assetType-edit").val();              //设备类型
		var assetCode = $("#assetCode-edit").val();                //设备编码
		var remark = $("#remark-edit").val();                      //设备描述
		var serviceStatus = $("#serviceStatus-edit").val();        //服务状态
		var systemStatus = $("#systemStatus-edit").val();          //系统状态
		var manufacturerId = $("#manufacturer-edit").val();      //厂商
		var price = $("#price-edit").val();                        //价格
		var purchaseDate = $("#purchaseDate-edit").val();          //购买时间
		var expirationDate = $("#expirationDate-edit").val();      //过期时间
		var modelId = $("#model-edit").val();                    //型号
		var labelId = $("#label-edit").val();                      //标签
		var cabinetId = $("#cabinet-edit").val();                  //所在机柜
		var unitStart = $("#unitStart-edit").val();                //开始U位
		var unitEnd = $("#unitEnd-edit").val();                    //结束U位
		var datacenter = $("#datacenter-edit").val();              //数据中心
		var computerRoom = $("#computerRoom-edit").val();          //所在机房
		if(assetCode == null || assetCode == ""){
			toastr.error("请输入设备编码");
			$("#assetCode-edit").focus();
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
			$("#unitStart-edit").focus();
			return false;
		}else if(unitEnd == null || unitEnd == ""){
			toastr.error("请输入结束U位");
			$("#unitEnd-edit").focus();
			return false;
		}else if(unitStart > unitEnd){
			toastr.error("开始U位要小于结束U位");
			$("#unitEnd-edit").focus();
			return false;
		}else if(unitEnd > parseInt(unit)){
			toastr.error("结束U位要小于等于总U位");
			$("#unitEnd-edit").focus();
			return false;
		}
		if(price == null || price == ""){
			toastr.error("请输入价格");
			$("#price-edit").focus();
			return false;
		}else if(!REGPRICE.test(price)){
			toastr.error("价格格式有误");
			$("#price-edit").focus();
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
			$("#purchaseDate-edit").focus();
			return false;
		}else if(expirationDate == null || expirationDate == ""){
			toastr.error("请选择过期时间");
			$("#expirationDate-edit").focus();
			return false;
		}else if(purchaseDate >= expirationDate){
			toastr.error("过期时间要大于购买时间");
			$("#expirationDate-edit").focus();
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
		//console.log(configurationData);
		var data = {
				"peripheralDeviceId":peripheralDeviceId,
				"remark":remark,
				"serviceStatus":serviceStatus,
				"systemStatus":systemStatus,
				"manufacturerId":manufacturerId,
				"modelId":modelId,
				"price":price,
				"purchaseDate":purchaseDate,
				"expirationDate":expirationDate,
				"labelId":labelId,
				"cabinetId":cabinetId,
				"unitEnd":unitEnd,
				"unitStart":unitStart,
				"data":configurationData,
			};
		$.ajax({
			"type":"POST",
			"url":"peripheral/device/update",
			"data":data,
			"dataType":"json",
			"success":function(resp){
				if(resp.code == "200" ){
					toastr.success("更新成功！");
					loadMainPage('itam-content','pages/asset/peripheralList.jsp');
				}else{
					toastr.error(resp.msg);
				}
			},
			"error":function(resp){
				toastr.error("更新失败！");
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