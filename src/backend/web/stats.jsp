<%-- 
    Document   : index
    Created on : 6-apr-2010, 14:08:43
    Author     : tim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%!
    public String seconds2readable(long iSeconds) {
        StringBuffer tOutput = new StringBuffer();
        if (iSeconds >= 3600*24) {
            int tDays = (int)(iSeconds / (3600*24));
            iSeconds -= tDays * 3600*24;
            tOutput.append(tDays + " days");
        }
        if (iSeconds >= 3600) {
            int tHours = (int)(iSeconds / (3600));
            iSeconds -= tHours * 3600;
            if (tOutput.length() > 0)
                tOutput.append(", ");
            tOutput.append(tHours + " hours");
        }
        if (iSeconds >= 60) {
            int tMinutes = (int)(iSeconds / (60));
            iSeconds -= tMinutes * 60;
            if (tOutput.length() > 0)
                tOutput.append(", ");
            tOutput.append(tMinutes + " minutes");
        }
        if (iSeconds > 0) {
            if (tOutput.length() > 0)
                tOutput.append(" and ");
            tOutput.append((int)iSeconds + " seconds");
        }

        return tOutput.toString();
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>StockPlay -- Statistics</title>
    </head>
    <body>
        <h1>Statistics</h1>

        <%
            // Define XML-RPC client object
            org.apache.xmlrpc.client.XmlRpcClientConfigImpl tConfig = new org.apache.xmlrpc.client.XmlRpcClientConfigImpl();
            tConfig.setServerURL(new java.net.URL("http://localhost:" + request.getServerPort() + "/backend/public"));
            org.apache.xmlrpc.client.XmlRpcClient tClient = new org.apache.xmlrpc.client.XmlRpcClient();
            tClient.setConfig(tConfig);

            // Login
            String tSession = (String) tClient.execute("User.Validate", new Object[]{"Administrator", "chocolademousse"});
            tConfig.setBasicUserName(tSession);
            tConfig.setBasicPassword("");
            tClient.setConfig(tConfig);
        %>
        
        <h2>Backend</h2>
        <% java.util.HashMap<String, Object> tStatsBackend = (java.util.HashMap<String, Object>)(tClient.execute("System.Backend.Stats", new Object[]{})); %>
        <p>
            <b>Requests served</b>: <%=tStatsBackend.get("req")%>.<br />
            <b>Uptime</b>: <%=seconds2readable(Long.parseLong((String)tStatsBackend.get("uptime")))%>.<br />
            <b>Users logged in</b>: <%=tStatsBackend.get("users")%>.<br />
        </p>

        <h2>Database</h2>
        <% java.util.HashMap<String, Object> tStatsDatabase = (java.util.HashMap<String, Object>)(tClient.execute("System.Database.Stats", new Object[]{})); %>
        <p>
            <b>Transaction rate</b>: <%=tStatsDatabase.get("rate")%> transactions per minute.<br />
            <b>Uptime</b>: <%=seconds2readable(Long.parseLong((String)tStatsDatabase.get("uptime")))%>.<br />
        </p>

        <h2>Cache</h2>
        <form action="stats.jsp" method="post">
            <p>
                <input type="submit" name="submit" value="Clear" />
            </p>
        </form>
        <%
            String iAction = request.getParameter("submit");
            if (iAction != null && iAction.equalsIgnoreCase("clear")) {
                com.kapti.cache.Manager.clear();
            }
        %>
        <table border="1">
            <tr>
                <th>Cache</th>
                <th>Raw Hits</th>
                <th>Raw Misses</th>
                <th>Memory size</th>
                <th>Total puts</th>
                <th>Total removes</th>
            </tr>
        <% for (Object tCacheId : net.sf.cache4j.CacheFactory.getInstance().getCacheIds()) {
            net.sf.cache4j.CacheInfo tCacheInfo = net.sf.cache4j.CacheFactory.getInstance().getCache(tCacheId).getCacheInfo();
            %>
            <tr>
                <td><%=net.sf.cache4j.CacheFactory.getInstance().getCache(tCacheId).getCacheConfig().getCacheId()%></td>
                <td><%= tCacheInfo.getCacheHits() %></td>
                <td><%= tCacheInfo.getCacheMisses() %></td>
                <td><%= tCacheInfo.getMemorySize() %></td>
                <td><%= tCacheInfo.getTotalPuts() %></td>
                <td><%= tCacheInfo.getTotalRemoves() %></td>
            </tr>
        <%
        }
        %>
        </table>

        <h2>Cache manager</h2>
        <p>
            <font color="RED"><b>Cache clears</b>: <%= com.kapti.cache.Manager.getManagerClears() %></font>
        </p>
        <table border="1">
            <tr>
                <th>Cache</th>
                <th>Managed calls</th>
                <th>Hits</th>
                <th>Misses</th>
                <th>Memory size</th>
            </tr>
        <% java.util.Map<net.sf.cache4j.Cache, com.kapti.cache.Manager.ManagerInfo> tManagerInfoMap = com.kapti.cache.Manager.getManagerInfo();
        for (net.sf.cache4j.Cache tCache : tManagerInfoMap.keySet()) {
            %><tr>
                <td><%= tCache.getCacheConfig().getCacheId() %></td>
                <td><%= tManagerInfoMap.get(tCache).keys %></td>
                <td><%= tManagerInfoMap.get(tCache).hits %></td>
                <td><%= tManagerInfoMap.get(tCache).misses %></td>
                <td><%= tManagerInfoMap.get(tCache).size %></td>
            </tr>
            <%
        }
        %>
        </table>

        <h3>Managed entries</h3>
        <table border="1">
            <tr>
                <th>Cache</th>
                <th>Method</th>
                <th>Arguments</th>
                <th>Count</th>
                <th>Cycle ratio</th>
            </tr>
        <% for (net.sf.cache4j.Cache tCache : tManagerInfoMap.keySet()) {
            com.kapti.cache.Manager.ManagerInfo tInfo = tManagerInfoMap.get(tCache);
            for ( com.kapti.cache.CallKey tCallKey : tInfo.entries.keySet()) {
                %><tr>
                    <td><%= tCache.getCacheConfig().getCacheId() %></td>
                    <td><%= tCallKey.method.getName() %></td>
                    <td><%= java.util.Arrays.deepToString(tCallKey.args) %></td>
                    <td><%= tInfo.entries.get(tCallKey).count %></td>
                    <td><%= tInfo.entries.get(tCallKey).cycleratio %></td>
                </tr>
                <%
            }
        }
        %>
        </table>
    </body>
</html>
