<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>资产管理系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta http-equiv="keywords" content="万达,资产,平台">
	<meta http-equiv="description" content="资产管理系统">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="resources/css/bootstrap/bootstrap.min.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/fontawesome/font-awesome.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/jquery/jquery.alerts.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/toastr/toastr.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/datatable/select.bootstrap.min.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/datatable/dataTables.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/bootstrap/bootstrap-select.min.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/bootstrap/bootstrap-datepicker.min.css" type="text/css"></link>
	<link rel="stylesheet" href="resources/css/style.css" type="text/css"></link>
  	
  </head>
  
  <body>
	<div class="wrapper">
   		<div class="sidebar">
   			<div id="collapse-btn" onclick="toggleCollapse()" class="to-close">
					<div class="caret-navbar-collapse">
						<span class="fa fa-angle-left"></span>
					</div>
			</div>
	  		<div class="sidebar-wrapper panel-group" id="accordion">
	  			<div class="panel">
					<a data-toggle="collapse" class="active" data-parent="#accordion" 
					   href="#collapseOne">
						<i class="fa fa-cloud"></i>
						<span>资产概览</span>
						<i class="fa fa-caret-down caret-direction"></i>
					</a>
					<ul id="collapseOne" class="nav panel-collapse collapse in">
						<li>
							<a onclick="loadMainPage('itam-content','pages/overview/physicalview.jsp');" class="active">
		  						<i class="fa fa-share-alt-square"></i>
								<span>物理视图</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/overview/resoucepool.jsp');">
		  						<i class="fa fa-pie-chart"></i>
								<span>资源池</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="panel">
					<a class="alone" data-parent="#accordion"   onclick="loadMainPage('itam-content','pages/resourcepool/resourcepoolList.jsp')">
						<i class="fa fa-inbox"></i>
						<span>资源池管理</span>
					</a>
				</div>
				<div class="panel">
					<a data-toggle="collapse" class="sidebar-table" data-parent="#accordion" 
					   href="#collapseTwo">
						<i class="fa fa-briefcase"></i>
						<span>资产管理</span>
						<i class="fa fa-caret-right caret-direction"></i>
					</a>
					<ul id="collapseTwo" class="nav panel-collapse collapse">
						<li>
							<a onclick="loadMainPage('itam-content','pages/asset/serverList.jsp');">
		  						<i class="fa fa-server"></i>
								<span>计算设备</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/asset/networkList.jsp')">
		  						<i class="fa fa-globe"></i>
								<span>网络设备</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/asset/securityList.jsp');">
		  						<i class="fa fa-shield"></i>
								<span>安全设备</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/asset/storageList.jsp');">
		  						<i class="fa fa-database"></i>
								<span>存储设备</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/asset/peripheralList.jsp');">
		  						<i class="fa fa-hdd-o"></i>
								<span>外设设备</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/resource/cabinet.jsp')">
		  						<i class="fa fa-microchip"></i>
								<span>机柜设备</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="panel">
					<a data-toggle="collapse" data-parent="#accordion" 
					   href="#collapseThree">
						<i class="fa fa-th-large"></i>
						<span>位置管理</span>
						<i class="fa fa-caret-right caret-direction"></i>
					</a>
					<ul id="collapseThree" class="nav panel-collapse collapse">
						<li>
							<a onclick="loadMainPage('itam-content','pages/resource/dataCenterList.jsp');">
		  						<i class="fa fa-television"></i>
								<span>数据中心</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/resource/computerRoom.jsp');">
		  						<i class="fa fa-desktop"></i>
								<span>机房管理</span>
							</a>
						</li>
						
						<li>
							<a onclick="loadMainPage('itam-content','pages/resource/labelList.jsp')">
		  						<i class="fa fa-tags"></i>
								<span>标签管理</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="panel">
					<a data-toggle="collapse" data-parent="#accordion" 
					   href="#collapseFour">
						<i class="fa fa-tty"></i>
						<span>供应商管理</span>
						<i class="fa fa-caret-right caret-direction"></i>
					</a>
					<ul id="collapseFour" class="nav panel-collapse collapse">
						<li>
							<a onclick="loadMainPage('itam-content','pages/manufacture/vendorManagement.jsp')">
		  						<i class="fa fa-registered"></i>
								<span>厂商管理</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/manufacture/personnelManagement.jsp')">
		  						<i class="fa fa-user-circle-o"></i>
								<span>人员管理</span>
							</a>
						</li>
						<li>
							<a onclick="loadMainPage('itam-content','pages/manufacture/modelManagement.jsp')">
		  						<i class="fa fa-file-text-o"></i>
								<span>型号管理</span>
							</a>
						</li>
					</ul>
				</div>
	  		</div>
		</div>
		<div class="content-wrapper">
			<div id="itam-content">
				
			</div>
		</div>
 	</div>
	<script type="text/javascript" src="resources/js/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="resources/js/d3/d3.min.js"></script>
	<script type="text/javascript" src="resources/js/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="resources/js/jquery/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/js/jquery/dataTables.select.min.js"></script>
	<script type="text/javascript" src="resources/js/jquery/jquery.alerts.js"></script>
	<script type="text/javascript" src="resources/js/toastr/toastr.js"></script>
	<script type="text/javascript" src="resources/js/other/moment.min.js"></script>
	<script type="text/javascript" src="resources/js/jquery/jquery.slimscroll.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap/bootstrap-datepicker.zh-CN.min.js"></script>
	<script type="text/javascript" src="resources/js/constant.js"></script>
	<script type="text/javascript" src="resources/js/index.js"></script>
	<script type="text/javascript">
		$(function(){
			clickLeftMenu();
			loadMainPage("itam-content","pages/overview/physicalview.jsp");
			$(".sidebar-wrapper").slimScroll({
	            height: "100%",
	            width: "180px"
	        });
		});
	</script>
 </body>
</html>
