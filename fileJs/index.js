$.fn.dataTable.ext.feature.push( {
	fnInit: function ( settings ) {
		if ( settings.sDom.indexOf('L') > 0  && settings.oFeatures.bPaginate && settings.oFeatures.bLengthChange ){
			var
				classes = settings.oClasses,
				tableId = settings.sTableId;

			var input = $('<input/>', {
				'name': tableId + '_length',
				'aria-controls': tableId,
				'class': classes.sLengthSelect,
				'type':'num'
			});

			var div = $('<div><label/></div>').addClass(classes.sLength );
			if ( ! settings.aanFeatures.L ) {
				div[0].id = tableId+'_length';
			}

			div.children().append(
				settings.oLanguage.sLengthMenu.replace( '_MENU_',input.prop("outerHTML") )
			);

			$('input', div)
				.val( settings._iDisplayLength )
				.bind('keyup.DT', function(e) {
					$(this).val($(this).val().replace(/[^\d]/g,''));
					if($(this).val() == '0' || $(this).val() == ''){
						$(this).val('');
					}else {
						settings.oApi._fnLengthChange( settings, $(this).val() );
						settings.oApi._fnDraw(settings );
					}
				} )
				.bind('blur.DT', function(e) {
					if(!$(this).val()){
						$(this).val('10');
						settings.oApi._fnLengthChange( settings, $(this).val() );
						settings.oApi._fnDraw(settings );
					}
				} );

			// Update node value whenever anything changes the table's length
			$(settings.nTable).bind( 'length.dt.DT', function (e, s, len) {
				if ( settings === s ) {
					$('input', div).val( len );
				}
			} );

			return div[0];
		}
	},
	cFeature: 'L'
} );

$.extend( true, $.fn.DataTable.ext.classes, {
	"sLengthSelect": "table-length-input",
} );

$.extend( true, $.fn.dataTable.defaults, {
	"dom":"<'dataTables_Info'Lp>"+
	"t"+
	"ip"
} );

/*
* 	dataTables公共参数
* */
var tableOptions = {
	"bProcessing" : false,
	"bServerSide": true, //指定从服务器端获取数据
	"sAjaxSource" : "",
	"fnServerData" : "", //与后台交互获取数据的处理函数
	"bDestroy" : true, //将之前的那个数据对象清除掉，换以新的对象设置
	"bRetrieve" : true, //用于指明当执行dataTable绑定时，是否返回DataTable对象
	"sAjaxDataProp" : "list",
	"lengthChange" : true,
	"pageLength":10,//每页加载条数
	"bFilter" : false,
	"bAutoWidth" : false,
	"bSort" : false,
	"fnDrawCallback": "",
	"pagingType": "simple",
	"rowId": "_id",
	"aoColumns" :  [],
	"language":{
		"oAria": {
			"sSortAscending": ": 升序排列",
			"sSortDescending": ": 降序排列"
		},
		"oPaginate": {
			"sFirst":    "首页",
			"sPrevious": "前一页",
			"sNext":     "后一页",
			"sLast":     "尾页"
		},
		"sEmptyTable": "没有相关记录",
		"sInfo": "第 _START_ 到 _END_ 条记录，共 _TOTAL_ 条",
		"sInfoEmpty": "第 0 到 0 条记录，共 0 条",
		"sInfoFiltered": "(从 _MAX_ 条记录中检索)",
		"sInfoPostFix": "",
		"sDecimal": "",
		"sThousands": ",",
		"sLengthMenu": "每页显示 _MENU_ 条",
		"sLoadingRecords": "正在载入...",
		"sProcessing": "正在载入...",
		"sSearch": "",
		"sSearchPlaceholder": "",
		"sUrl": "",
		"sZeroRecords": "没有相关记录",
		"select": {
			rows: {
				_: "。已选择 %d 行",
				0: ""
				//1: "Only 1 row selected"
			}
		}
	},
	"aoColumnDefs": [{
		sDefaultContent: '',
		aTargets: ['_all']
	}]
};

/*
* 	加载页面
* */
function loadMainPage(objName,v) {
	$("#"+objName+"").load(v,function (){
		$("#"+objName+"").css({"min-height": $(window).height()-60 +"px"});
		setMinHeight(objName);
	});
}

function loadMainPage(objName,v,data) {
	$("#"+objName+"").load(v,data,function (){
		$("#"+objName+"").css({"min-height": $(window).height()-60 +"px"});
		setMinHeight(objName);
	});
}


/*
* 	设置最小高度
* */
function setMinHeight(objName) {
	var top = $("#"+objName+"").offset().top.toFixed();//设置div的高度
	$("#"+objName+"").css({"min-height":$(window).height()- 40 - top+"px"});
	return $("#"+objName+"").height();
}

/*
* 	可以全部展开
* */
function clickLeftMenu(){
	$("ul[id^='collapse']:not('#collapseOne')").collapse("hide");
	$("#collapseOne").collapse("show");
	$(".sidebar-wrapper a[data-parent='#accordion']").click(function(){
		if($(this).siblings("ul").hasClass("in")){
			$(this).removeClass("active");
			$(this).children(".caret-direction").removeClass("fa-caret-down").addClass("fa-caret-right");
		}else{
			$(this).addClass("active");
			$(this).children(".caret-direction").removeClass("fa-caret-right").addClass("fa-caret-down");
		}
	});
	$(".sidebar-wrapper ul li a").click(function(){
		$(".sidebar-wrapper ul li a").removeClass("active");
		$(".sidebar-wrapper a.alone").removeClass("active");
		$(this).addClass("active");
	});
	$(".sidebar-wrapper a.alone").click(function(){
		$(".sidebar-wrapper ul li a").removeClass("active");
		$(".sidebar-wrapper a.alone").removeClass("active");
		$(this).addClass("active");
	});
}

/*
* 	向左边隐藏
* */
function toggleCollapse() {
	if($(".sidebar").hasClass("sidebar-hide")){
		$(".sidebar").removeClass("sidebar-hide");
		$(".content-wrapper").css("padding-left", (parseInt($(".content-wrapper").css("padding-left"))+170) + "px");
		$("#collapse-btn").removeClass("to-open");
		$("#collapse-btn").addClass("to-close");
	}else{
		$(".sidebar").addClass("sidebar-hide");
		$(".content-wrapper").css("padding-left", (parseInt($(".content-wrapper").css("padding-left"))-170) + "px");
		$("#collapse-btn").addClass("to-open");
		$("#collapse-btn").removeClass("to-close");
	}
}

/*
* 	checkbox全选
* */
function selectAll(id) {
	var table = $("#"+id).DataTable();
	$("#"+id+" th input[type='checkbox']").attr("checked",false);
    $("#"+id+" th input[type='checkbox']").click(function () {
        if ($(this).prop("checked") === true) {
            table.rows().select();
        } else {
            table.rows().deselect();
        }
    });
}


/*
* 	展开高级搜索
* */
function spreadSearch(){
	if($(".advanced-search-btn span").hasClass("fa-caret-down")){
   		$(".advanced-search-btn span").removeClass("fa-caret-down");    //如果元素为隐藏,则将它显现
   		$(".advanced-search-btn span").addClass("fa-caret-up");
   		$(".advanced-search").show();
   		$(".input-group input").val("");
		$(".input-group input").attr("disabled",true);
	}else{
  		$(".advanced-search-btn span").removeClass("fa-caret-up");
  		$(".advanced-search-btn span").addClass("fa-caret-down");
  		$(".advanced-search").hide();
  		$(".input-group input").val("");
		$(".input-group input").attr("disabled",false);
	}
}


function conversionPages(start,rows){
    return (start / rows + 1);
}


function initEcharts(id, yData, name, type) {
    var myChart = echarts.init(document.getElementById(id));
    var option = {
        tooltip : {
            formatter: "{a} <br/>{b} : {c}%"
        },
        series: [
            {
                name: name,
                type: type,
                startAngle: 210,
                endAngle: -30,
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: [
                            [
                                0.6,
                                '#31B4A1'
                            ],
                            [
                                0.8,
                                '#FFCC00'
                            ],
                            [
                                1,
                                '#EC745E'
                            ]
                        ],
                        width: 23
                    }
                },
                axisLabel: {
                    distance: 14,
                    textStyle: {
                        fontSize: 11
                    }
                },
                splitLine: {
                    show: true,
                    length: 12
                },
                pointer: {
                    width: 5
                },
                itemStyle: {
                    normal: {
                        color: "#323232"
                    },
                },
                title: {
                    offsetCenter: [0,"25%"],
                    textStyle: {
                        fontWeight: "500",
                        fontSize: 16

                    }
                },
                detail: {
                    offsetCenter: [0,"57%"],
                    formatter:'{value}%',
                    textStyle: {
                        fontSize: 14

                    }
                },
                data: yData
            }
        ]
    };
    myChart.setOption(option);
    return myChart;
}


/**
 * 初始化下拉框
 */
//初始下拉框(型号，设备类型，机房，机柜除外)
function initSelects(url, id, data, dataType, resourceId, resourceName){
	$("#"+id).empty();
	if(dataType == MD){
		$("#"+id).append("<option value=''>--请选择--</option>");
	}
	$.getJSON(url,data,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				$("#"+id).append("<option value='"+item[resourceId]+"'>"+item[resourceName]+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
    });
}
//初始化资源池下拉框,data结构为{type:RESOURCE_POOL_TYPE},当type不传时默认为所有资源池
function initPoolSelects(id, data){
	$("#"+id).empty();
	$.getJSON("resource-pool/list",data,function(r){
   		if(r.code == 200) {
   			var list = r.result;
   			$.each(list,function(index,item){
   				$("#"+id).append("<option value='"+item.resourcePoolId+"'>"+item.name+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化设备类型下拉框
function initAssetTypeSelects(id, data, manufacturerId, modelId){
	$("#"+id).empty();
	$.getJSON("asset/type",data,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				if(index == 0){
   					loadConfiguration(item.assetTypeId,id,null);
   					initManufacturerSelects(manufacturerId, null, modelId,item.assetTypeId);
   				}
   				$("#"+id).append("<option value='"+item.assetTypeId+"'>"+item.name+"</option>");
   			});

   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化厂商下拉框
function initManufacturerSelects(id, data, modelId, assetTypeId){
	$("#"+id).empty();
	$("#"+modelId).empty();
	$("#"+modelId).selectpicker("refresh");
	$.getJSON("manufacturer/list",data,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				if(index == 0){
   					initModelSelects(item.manufacturerId,modelId,assetTypeId);
   				}
   				$("#"+id).append("<option value='"+item.manufacturerId+"'>"+item.name+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化型号下拉框
function initModelSelects(manufacturerId, id, assetTypeId){
	$("#"+id).empty();
	$.getJSON("model/list",{manufacturerId: manufacturerId, assetTypeId: assetTypeId},function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				if(index == 0){
   					$("span.unit").text(item.units);
   				}
   				$("#"+id).append("<option units='"+item.units+"' value='"+item.modelId+"'>"+item.name+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化计算设备系统类型下拉框
function initOsTypeSelects(id, data,osVersionId){
	$("#"+id).empty();
	$.getJSON("mdconfig/server/type",data,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				if(index == 0){
   					initOsVersionSelects(osVersionId,item.configId);
   				}
   				$("#"+id).append("<option value='"+item.key+"'>"+item.value+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化计算设备系统版本下拉框
function initOsVersionSelects(id,osTypeId){
	$("#"+id).empty();
	$.getJSON("mdconfig/server/version/"+osTypeId,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				$("#"+id).append("<option value='"+item.key+"'>"+item.value+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化数据中心下拉框
function initDatacenterSelects(id, data, computerRoomId, cabinetId){
	$("#"+id).empty();
	$("#"+computerRoomId).empty();
	$("#"+computerRoomId).selectpicker("refresh");
	$("#"+cabinetId).empty();
	$("#"+cabinetId).selectpicker("refresh");
	$.getJSON("data-center/list",data,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				if(index == 0){
   					initComputerroomSelects(item.dataCenterId, computerRoomId, cabinetId);
   				}
   				$("#"+id).append("<option value='"+item.dataCenterId+"'>"+item.name+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化机房下拉框
function initComputerroomSelects(dataCenterId,id, cabinetId){
	$("#"+id).empty();
	$("#"+cabinetId).empty();
	$("#"+cabinetId).selectpicker("refresh");
	$.getJSON("computer-room/list?dataCenterId="+dataCenterId,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				if(index == 0){
   					initCabinetSelects(item.computerRoomId,cabinetId);
   				}
   				$("#"+id).append("<option value='"+item.computerRoomId+"'>"+item.name+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//初始化机柜下拉框
function initCabinetSelects(computerRoomId, id){
	$("#"+id).empty();
	$.getJSON("cabinet/list?computerRoomId="+computerRoomId,function(r){
   		if(r.code == 200) {
   			var list = r.result.list;
   			$.each(list,function(index,item){
   				$("#"+id).append("<option value='"+item.cabinetId+"'>"+item.name+"</option>");
   			});
   		}
   		$("#"+id).selectpicker("refresh");
   });
}
//改变U位（暂时）
function changeUnits(obj) {
	var units = $(obj).find("option:selected").attr("units");
	$("span.unit").text(units);
}
//加载配置信息
function loadConfiguration(assetTypeId,id,data){
	if(assetTypeId == null || assetTypeId == ""){
		assetTypeId = $("#"+id).val();
	}
	$(".configurationInfo").empty();
	data = $.parseJSON(data);
	$.getJSON("asset/property?assetTypeId="+assetTypeId,function(r){
		if(r.code == 200){
			var list = r.result.list;
			if(list != null && list != ""){
				$(".configurationInfo").append("<div class='col-sm-12 title-content' style='margin-top: 20px;'><strong>系统配置</strong></div>");
				$.each(list,function(index,item){
					var value = "";
					if(data != null && data != ""){
						value = data[item.assetPropertyId];
					}
					var str = "<div class='col-md-6 col-sm-6'>"+
							  "<label class='col-md-3 col-sm-4 control-label col'>"+item.name+"</label>"+
							  "<div class='col-md-9 col-sm-8  col'>";
					if(item.inputType == INPUT_TYPE_INPUT){
						str += "<input type='text' data-type='input' data-name='"+item.name+"' id='extension"+item.assetPropertyId+"' "+
							  "data-required='"+item.required+"' data-value='"+item.assetPropertyId+"'"+
							  " maxlength='"+item.inputLength+"' class='form-control input-add'";
						if(value != null && value != ""){
							str +="value='"+value+"' disabled='disabled'";
						}
						str += ">";
					}else if(item.inputType == INPUT_TYPE_DATE){
						str += "<input type='text' data-type='date' data-name='"+item.name+"' id='extension"+item.assetPropertyId+"' "+
							  "data-required='"+item.required+"' data-value='"+item.assetPropertyId+"'"+
							  " maxlength='"+item.inputLength+"' class='form-control input-add'";
						if(value != null && value != ""){
							str +="value='"+value+"' disabled='disabled'";
						}
						str += ">";
					}else if(item.inputType == INPUT_TYPE_DROP){
						var options = item.enumValue;
						options = options.split(",");
						str += "<select type='text'  data-type='select' data-name='"+item.name+"' id='extension"+item.assetPropertyId+"' "+
							  "data-required='"+item.required+"' data-value='"+item.assetPropertyId+"'"+
							  " class='form-control input-sm selectpicker input-group-select'";
						if(value != null && value != ""){
							str +="disabled='disabled'";
						}
						str += ">";
						for ( var i = 0; i < options.length; i++) {
							if(value == options[i]){
								str += "<option value='"+options[i]+"' selected='selected' >"+options[i]+"</option>";
							}else{
								str += "<option value='"+options[i]+"'>"+options[i]+"</option>";
							}
						}
						str += "</select>";
					}
					str += "</div></div>";
	   				$(".configurationInfo").append(str);
	   			});
				$(".configurationInfo input[data-type='date']").datepicker({
					format: "yyyy-mm-dd",
					autoclose: true,
					language: "zh-CN",
				});
				$(".configurationInfo select.selectpicker").selectpicker();
			}
		}
	});
}
/**
 * 输入验证
 */
