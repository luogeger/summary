<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        #graph{
            height: 300px;
        }
        .pt20{
            padding-top: 20px;
        }
        .m0{
            margin: 0px;
        }
      
    </style>

<!-- navigate -->
    <div class="console-title console-title-border ">
        <h6>资产管理系统</h6>
        <h6>资源管理</h6>
        <h6>数据中心</h6>
        <h6 id="nav_address">上海数据中心</h6>
        <h6  id="nav_details">详情</h6>
        <a id="return-btn" class="pull-right" type="button" style="text-decoration: none;" onclick="loadMainPage('itam-content','pages/resource/dataCenterList.jsp');">
            <span class="icon-reply "></span>
            返回
        </a>
    </div>
<!-- operation -->
        <div class="add-operation">
            <button class="btn btn-info" id="edit">
                <span class="fa fa-edit"></span>
               		 编辑
            </button>
            <button class="btn btn-info save hidden" id="save">
                <span class="fa fa-floppy-o "></span>
               	 保存
            </button>
            <button class="btn btn-primary cancel hidden" style="margin-left:30px;" id="cancel">
                <span class="fa fa-undo"></span>
                	取消
            </button>
        </div>

<!-- AddInfo -->
    <div class="row  m0">
        <div class="col-xs-12 col-sm-12 col-md-6 ">
        	<!--  名称  -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-xs-1 col-sm-1 col-md-1 control-label text-center"  for="monitor-btn">名称</label>
                <div class="col-xs-7 col-sm-6 col-md-8 col-input">
                    <input type="text" class="form-control" id="alias"  disabled>
                </div>
                <div class="col-xs-4 col-sm-5 col-md-3 "></div>
            </div>
            <!--  国家  -->
            <div class="col-btn col-xs-12 pt20 nation" >
                <label class="col-xs-1 col-sm-1 col-md-1 control-label" style="text-align: center;" for="monitor-btn">国家</label>
                <!-- 输入框-->
                <div class="col-xs-7 col-sm-6 col-md-8 col-input nation_i ">
                    <input type="text" class="form-control"  id="nation"  disabled>
                </div>
                <!-- 下拉框 -->
                <div class="col-xs-5 col-sm-4 col-md-6 col-input nation_s  hidden" >
                    <select  class="form-control input-sm selectpicker input-group-select">
                        <option value="">ComboBox</option>
                        <option value="1">中国</option>
                        <option value="2">新加坡</option>
                    </select>
                </div>
                <!-- 空栏 -->
                <div class="col-xs-4 col-sm-5 col-md-3 "></div>
            </div>
            <!--  城市  -->
            <div class="col-btn col-xs-12 pt20 city">
                <label class="col-xs-1 col-sm-1 col-md-1 control-label" style="text-align: center;" for="monitor-btn">城市</label>
                <!--  输入框 -->
                <div class="col-xs-7 col-sm-6 col-md-8 col-input city_i ">
                    <input type="text" class="form-control"  id="city" disabled>
                </div>
                <!--  下拉框  -->
                <div class="col-xs-5 col-sm-4 col-md-6 col-input city_s  hidden">
                    <select  class="form-control input-sm selectpicker input-group-select">
                        <option value="">ComboBox</option>
                        <option value="1">上海</option>
                        <option value="2">广州</option>
                    </select>
                </div>
                <!--  空栏 -->
                <div class="col-xs-4 col-sm-5 col-md-3 "></div>
            </div>
            <!--  地址  -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-xs-1 col-sm-1 col-md-1 control-label text-center"  for="monitor-btn" >地址</label>
                <div class="col-xs-7 col-sm-6 col-md-8 col-input">
                    <textarea cols="10" rows="4" class="form-control" style="resize:none;"  id="address" disabled></textarea>
                </div>
            </div>
            <!-- 描述  -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-xs-1 col-sm-1 col-md-1 control-label text-center"  for="monitor-btn">描述</label>
                <div class="col-xs-7 col-sm-6 col-md-8 col-input">
                    <textarea cols="10" rows="4" class="form-control" style="resize:none;"  id="describe" disabled></textarea>
                </div>
            </div>
        </div>


        <div id="graph" class="col-xs-12 col-sm-12 col-md-6 ">
            这里是饼形图
        </div>

    </div><!--  content  -->


<!-- 表格 -->
    <div class="row m0">
        <h5>机房 </h5>
        <div class="col-sm-11 col-md-11 ">
            <table id="model-table" class="table table-hover no-footer dataTable">
                <thead class="the-box dark full">
                <tr>
                    <th class="sorting_disabled">机房名称</th>
                    <th class="sorting_disabled">备注</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

<script>
	//获取详情页信息
	var dataCenterId = "${param.dataCenterId}";
	//初始化下拉框
	$(function(){
		$(".selectpicker").selectpicker();
		dropuAuto : false;
	});
	//详情页数据渲染
	dataDetail();
   	function dataDetail(obj){
   		$.ajax({
   			"type":"GET",
   			"url":"data-center/detail",
   			"data":{"dataCenterId":dataCenterId},
   			"dataType":"json",
   			"success":function(resp){
   				if(resp.code == "200"){
   					var obj = resp.result.dataCenter;
   					$('#alias').val(obj.name);
   					$('#nation').val(obj.country);
   					$('#city').val(obj.city);
   					$('#address').val(obj.address);
   					$('#describe').val(obj.remark);
   					$('#nav_address').text(obj.name);
   				}else{
   					toastr.warning(resp.msg);
   				}
   			},
   			"error":function(resp){
   				toastr.error("请求失败！");
   			}
   		
   		});
   	}
	
	//渲染表格执行函数
    $(function () {
        var editBtn = $('#edit');//编辑
        var saveBtn = $('#save');//保存
        var cancelBtn = $('#cancel');//取消
        var na_put = $('.nation_i');//国家--输入框
        var na_sel = $('.nation_s');//国家--下拉框
        var ci_put = $('.city_i');//城市--输入框
        var ci_sel = $('.city_s');//城市--下拉框
        //--
        var arrHide = [editBtn, saveBtn, cancelBtn, na_put, na_sel, ci_put, ci_sel];
        var nav_address = $('#nav_address');//数据中心地址
        var	nav_details = $('#nav_details');//详情 
        //--
        //按钮显示隐藏--function
        function hideshow (arr){
            var i, len = arr.length;
            for(i = 0; i < len; i++){
                arr[i].toggleClass('hidden');
            }
        };
		//--编辑按钮
        editBtn.dblclick(function (){
            hideshow(arrHide);
            nav_details.text('编辑');
            $('input').attr("disabled",false);
            $('textarea').attr("disabled",false);
            //初始化下拉框
        });
        //--保存按钮
        saveBtn.on('click', function () {
            hideshow(arrHide);
            nav_details.text('详情');
    		$.ajax({
				"type":"POST",
				"url":"data-center/update",
				"data":{"dataCenterId":dataCenterId,
						"name": $('#alias').val(),
						"country": $('#nation').val(),
						"city": $('#city').val(),
						"address": $('#address').val(),
						"remark": $('#describe').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
						toastr.success(resp.msg);
						$('input').attr("disabled",true);
			            $('textarea').attr("disabled",true);
			    		dataDetail();
			    		initDataTable();
					}else{
						toastr.error(resp.msg);
					}
				},
				"error":function(resp){
					toastr.error("请求失败！");
				}
			});
        });
        //--取消按钮
        cancelBtn.on('click', function () {
            hideshow(arrHide);
            nav_details.text('详情');
            $('input').attr("disabled",true);
            $('textarea').attr("disabled",true);
    		dataDetail();
        });
        //--饼图
        var myChart = echarts.init(document.getElementById('graph'));
        option = {
            title : {
                text: '容量使用情况',
                subtext: '',
                x:'center'
            },

            series : [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data:[
                        {value:996, name:'占用容量'},
                        {value:1548, name:'剩余容量'}
                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart.setOption(option);
    }); // $--end


	//--Table执行
    $(function () {
        initDataTable();
    });
    //--初始化表格
    function initDataTable() {
        $("#model-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "data-center/page",
            "fnServerData": retrieveData, //与后台交互获取数据的处理函数
            "paging":false,
            "bInfo":false,
            "language":{
                'sEmptyTable':'没有相关记录',
            },
            "aoColumns": [
                {
                    "mData": "name",
                    "sWidth":"40%",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }
                , {
                    "mData": "remark",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }
            ],
        });
        $("#model-table").dataTable(temp);
    }
    //--异步获取
    function retrieveData(sSource, aoData, fnCallback) {
        var row; //默认一次加载10条
        var start; //从第几条开始
        $.each(eval(aoData), function (i, field) {//转换为json对象
            if (field.name == "iDisplayStart") {
                start = field.value;
            }
            if (field.name == "iDisplayLength") {
                row = field.value;
            }
        });

        var query = {
            page: conversionPages(start, row),
            rows: row
        };
        $.getJSON(sSource, query, function (rm) {
            if (rm.code == 200) {
                var data = rm.result.pageInfo;
                data.iTotalRecords = rm.result.pageInfo.total;
                data.iTotalDisplayRecords = rm.result.pageInfo.total;
                fnCallback(data);
            } else {
                toastr.error(resp.msg);
            }
        });
    }
 
</script>



