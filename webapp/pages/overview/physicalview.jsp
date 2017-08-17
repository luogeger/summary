<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
.node {
  cursor: pointer;
}

.node circle {
  fill: #fff;
  stroke: steelblue;
  stroke-width: 1.5px;
}

.link {
  fill: none;
  stroke: #ccc;
  stroke-width: 1.5px;
}
.physicalview {
	background-color: #fff;
}
#date-center-content {
	width: 140px;
}
#date-center-content li {
	width: 140px;
	margin: 4px 0;
	transition: all .3s ease 0s;
	transform: scale(1);
	border-radius: 4px;
}
#date-center-content li a {
	background-color: #ccc;
	color: #fff;
	text-align: center;
	border-radius: 4px;
	font-size: 13px;
	line-height: 13px;
	transition: all .3s ease 0s;
}
#date-center-content li.active a {
	background-color: #0093c6 ;
}
#date-center-content li:hover {
	background-color: #0093c6;
	transform: scale(1.1);
}
#date-center-content li:hover a{
	background-color: #0093c6;
}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>资产概览</h6>
	<h6>物理视图</h6>
</div>
<div class="physicalview">
	<div class="d3-view col-md-9 col-sm-12">
	
	</div>
	<div class="data-center col-md-3 col-sm-12">
		<ul id="date-center-content" class="nav">
		</ul>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		initDateCenter();
	});
	function showdiagram(dataCenterId){
		$(".d3-view").empty();
		var margin = {top: 1, right: 120, bottom: 20, left: 120},
		    width = 800 - margin.right - margin.left,
		    height = 800 - margin.top - margin.bottom;
		
		var i = 0,
		    duration = 750,
		    root;
		
		var tree = d3.layout.tree()
		    .size([height, width]);
		
		var diagonal = d3.svg.diagonal()
		    .projection(function(d) { return [d.y, d.x]; });
		
		var svg = d3.select(".d3-view").append("svg")
		    .attr("width", width + margin.right + margin.left)
		    .attr("height", height + margin.top + margin.bottom)
		  .append("g")
		    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		d3.json("assets/overview?dataCenterId="+dataCenterId, function(error, flare) {
		  if (error) throw error;
		
		  root = flare.result;
		  root.x0 = height / 2;
		  root.y0 = 0;
		  eachNode(root.children);
		  update(root);
		});
		function collapse(d) {
		    if (d.children) {
		      d._children = d.children;
		      d._children.forEach(collapse);
		      d.children = null;
		    }
		}
		d3.select(self.frameElement).style("height", "800px");
		function update(source) {
		  // Compute the new tree layout.
		  var nodes = tree.nodes(root).reverse(),
		      links = tree.links(nodes);
		
		  // Normalize for fixed-depth.
		  nodes.forEach(function(d) { d.y = d.depth * 180; });
		
		  // Update the nodes…
		  var node = svg.selectAll("g.node")
		      .data(nodes, function(d) { return d.id || (d.id = ++i); });
		
		  // Enter any new nodes at the parent's previous position.
		  var nodeEnter = node.enter().append("g")
		      .attr("class", "node")
		      .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; });
		      
		
		 nodeEnter.append("circle")
		      .attr("r", 1e-6)
		      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; })
		      .on("click", click); 
		  nodeEnter.append("a")
		  	  .on("click", function(d) { loc(d); })
		  	  .append("text")
		      .attr("x", function(d) { return d.children || d._children ? -10 : 10; })
		      .attr("dy", ".35em")
		      .attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
		      .text(function(d) { return d.name; })
		      .style("fill-opacity", 1e-6);
		
		  // Transition nodes to their new position.
		  var nodeUpdate = node.transition()
		      .duration(duration)
		      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });
		
		  nodeUpdate.select("circle")
		      .attr("r", 4.5)
		      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });
		
		  nodeUpdate.select("text")
		      .style("fill-opacity", 1);
		
		  // Transition exiting nodes to the parent's new position.
		  var nodeExit = node.exit().transition()
		      .duration(duration)
		      .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
		      .remove();
		
		  nodeExit.select("circle")
		      .attr("r", 1e-6);
		
		  nodeExit.select("text")
		      .style("fill-opacity", 1e-6);
		
		  // Update the links…
		  var link = svg.selectAll("path.link")
		      .data(links, function(d) { return d.target.id; });
		
		  // Enter any new links at the parent's previous position.
		  link.enter().insert("path", "g")
		      .attr("class", "link")
		      .attr("d", function(d) {
		        var o = {x: source.x0, y: source.y0};
		        return diagonal({source: o, target: o});
		      });
		
		  // Transition links to their new position.
		  link.transition()
		      .duration(duration)
		      .attr("d", diagonal);
		
		  // Transition exiting nodes to the parent's new position.
		  link.exit().transition()
		      .duration(duration)
		      .attr("d", function(d) {
		        var o = {x: source.x, y: source.y};
		        return diagonal({source: o, target: o});
		      })
		      .remove();
		
		  // Stash the old positions for transition.
		  nodes.forEach(function(d) {
		    d.x0 = d.x;
		    d.y0 = d.y;
		  });
		}
		
		// Toggle children on click.
		function click(d) {
		  var str = "";
		  if (d.children) {
		    d._children = d.children;
		    str = d._children;
		    d.children = null;
		  } else {
		    d.children = d._children;
		    str = d.children;
		    d._children = null;
		  }
		  openOrClose(d);
		  update(d);
		}
		function eachNode(obj){
		  for ( var i = 1; i < obj.length; i++) {
			collapse(obj[i]);
		  }
		  var num = obj[0].children.length;
		  if(num > 1){
		  	for( var i = 1; i < num; i++) {
			   collapse(obj[0].children[i]);
			}
		  }
		}
		function openOrClose(obj){
		  var num = obj.depth;
		  if(root.children != null ){
		  	switch(num){
			case 1: $.each(root.children,function(index,item){
						if(item.name != obj.name){
							collapse(root.children[index]);
						}
					}); 
					break;
			case 2: $.each(root.children,function(index,item){
						if(item.name == obj.parent.name){
							var nodes = root.children[index].children;
							$.each(nodes,function(i,item){
								if(item.name != obj.name){
									collapse(nodes[i]);
								}
							});
						}
					}); 
					break;
		    }
		  }
		  
		}
	}
	function initDateCenter(){
		$.getJSON("data-center/list",function(r){
			if(r.code == 200){
				var list = r.result.list;
				$.each(list,function(index,item){
					if(index == 0){
						$("#date-center-content").append("<li class='active' onclick='changeD3(\""+item.dataCenterId+"\",this)'><a data-value='"+item.dataCenterId+"'>"+item.name+"</a></li>");
						showdiagram(item.dataCenterId);
					}else{
						$("#date-center-content").append("<li onclick='changeD3(\""+item.dataCenterId+"\",this)'><a data-value='"+item.dataCenterId+"'>"+item.name+"</a></li>");
					}
	   			});
			}
		});
	}
	function changeD3(dataCenterId,obj){
		$(obj).addClass("active").siblings().removeClass("active");
		showdiagram(dataCenterId);
	}
	function loc(d){
		var resourceType = d.type;
		var url = "";
		console.log(d);
		if(resourceType == MDCONFIG_DATECENTER){
			url = "pages/resource/dataCenterDetails.jsp";
		}else if(resourceType == MDCONFIG_COMPUTERROOM){
			url = "pages/resource/computerRoomDetails.jsp";
		}else if(resourceType == MDCONFIG_CABINET){
			url = "pages/resource/computerRoomDetails.jsp";
		}else if(resourceType == MDCONFIG_SERVER){
			url = "pages/asset/severDetail.jsp?serverId=";
		}else if(resourceType == MDCONFIG_STORAGE){
			url = "pages/asset/storageDetail.jsp?storageId=";
		}else if(resourceType == MDCONFIG_NETWORK){
			url = "pages/asset/networkDetail.jsp?networkId=";
		}else if(resourceType == MDCONFIG_SECURITY){
			url = "pages/asset/securityDetail.jsp?securityId=";
		}else if(resourceType == MDCONFIG_PERIPHERAL){
			url = "pages/asset/peripheralDetail.jsp?peripheralDeviceId=";
		}
		loadMainPage("itam-content",url+d.id);
	}
</script>