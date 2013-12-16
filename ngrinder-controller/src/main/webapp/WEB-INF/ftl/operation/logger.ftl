<!DOCTYPE html>
<html>
<head>
<#include "../common/common.ftl">
<#include "../common/datatables.ftl">
<title><@spring.message "log.view.title"/></title>
</head>

<body>
	<#include "../common/navigator.ftl">
	<div class="container">
		<div class="row">
			<div class="span12">
				<legend class="header">
					<@spring.message "navigator.dropDown.logMonitoring"/>
				</legend>
				<table id="log_container">
				</table>
			</div>
		</div>
		<#include "../common/copyright.ftl">
	</div>
	<script>
		// Wrap this function in a closure so we don't pollute the namespace
		(function pollingLogs() {
			var ajaxObj = new AjaxObj("/operation/log/last");
			ajaxObj.success = function(data) {
				var eachLog = $("tr#" +data.index + " td");
				if (eachLog.size() != 0) {
					//noinspection JSUnresolvedVariable
					if (eachLog.attr("id") != data.modification) {
						eachLog.html(data.log);
						//noinspection JSUnresolvedVariable
						eachLog.attr("id", data.modification);
					}
				} else {
					var $logContainer = $("#log_container");
					var logEntries = $logContainer.find("tr");
					if (logEntries.size() > 5) {
						logEntries.first().remove();
					}
					$logContainer.append($("<tr id='" + data.index + "'><td id='" + data.modification + "'>" + data.log + "</td></tr>"));
				}
				setTimeout(pollingLogs, 5000);
			};
            ajaxObj.call();
		})();
	</script>
</body>
</html>