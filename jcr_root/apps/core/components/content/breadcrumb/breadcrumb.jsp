<%@page session="false"%>
<%--
 Custom  Breadcrumb component
--%>
    <%@include file="/libs/foundation/global.jsp"%>
<%
%><%

    // get starting point of trail
    long level = currentStyle.get("absParent", 2L);
    long endLevel = currentStyle.get("relParent", 1L);
    String delimStr = currentStyle.get("delim", "&nbsp;&gt;&nbsp;");
    String trailStr = currentStyle.get("trail", "");
   
    int currentLevel = currentPage.getDepth();

    String delim = "";

    while (level < currentLevel - endLevel) {

        	Page trail = currentPage.getAbsoluteParent((int) level);
            if (trail == null) {
                break;
            }
            
            boolean isPageHidden=trail.isHideInNav();;
            String pageHiddenStr= null;
           
			// Check is Page Hidden or not
            if(!isPageHidden){
				String title = trail.getNavigationTitle();

                if (title == null || title.equals("")) {
                    title = trail.getNavigationTitle();
                }
                if (title == null || title.equals("")) {
                    title = trail.getTitle();
                }
                if (title == null || title.equals("")) {
                    title = trail.getName();
                }

                %><%= xssAPI.filterHTML(delim) %><%
                %><a href="<%= xssAPI.getValidHref(trail.getPath()+".html") %>"
                     onclick="CQ_Analytics.record({event:'followBreadcrumb',values: { breadcrumbPath: '<%= xssAPI.getValidHref(trail.getPath()) %>' },collect: false,options: { obj: this },componentPath: '<%=resource.getResourceType()%>'})"><%
                %><%= xssAPI.encodeForHTML(title) %><%
                %></a><%
        
                delim = delimStr;

            }

            level++;
        }
        if (trailStr.length() > 0) {
            %><%= xssAPI.filterHTML(trailStr) %><%
        }





%>
